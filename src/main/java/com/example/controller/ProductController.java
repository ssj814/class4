package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.ProductCategoryDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.dto.ProductReviewDTO;
import com.example.service.ProductReviewService;
import com.example.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	ProductService service;
	
	@Autowired
	ProductReviewService productReviewService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String shopMain(Model m) {
		List<ProductDTO> ProductList = service.selectProductMainList();
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		m.addAttribute("ProductList",ProductList);
		m.addAttribute("CategoryList",CategoryList);
		return "shoppingMall/shopMain";
	}
	
	@RequestMapping(value="/shopList", method=RequestMethod.GET)
	public String shopList(@RequestParam Map<String,String> map, Model m) {
		String category = map.get("category");
		String page = map.get("page");
		String search = map.get("search");
		String sort = map.get("sort");
		//페이징
		int perPage = 8; 
		RowBounds bounds = null;
		if (page==null) {
			bounds = new RowBounds(0,perPage);
		} else {
			bounds = new RowBounds((Integer.parseInt(page)-1)*perPage,8);
		}
		// 카테고리, 일반검색, 정렬용 map
		Map<String, Object> dataMap = new HashMap<String, Object>();
		//카테고리별 데이터
		dataMap.put("category", category);
		//일반 검색
		if(search!=null) {
			dataMap.put("search", search.trim());
		}
		//정렬
		List<String> sortList = null;
		if ("nameAsc".equals(sort)) {
			sortList = Arrays.asList("product_name","asc");
		} else if ("priceAsc".equals(sort)) {
			sortList = Arrays.asList("product_price","asc");
		} else if ("priceDesc".equals(sort)) {
			sortList = Arrays.asList("product_price","desc");
		}
		dataMap.put("sortList", sortList);
		List<ProductDTO> ProductList = service.selectProductList(dataMap,bounds);
		//페이징
		int totalProductSize = service.selectProductMainList().size(); // 전체 상품 개수
		if(search!=null || category!=null) { // 조건에 걸린 전체 상품 개수
			Map<String, String> selectMap = new HashMap<String, String>();
			selectMap.put("search", search);
			selectMap.put("category", category);
			totalProductSize = service.selectProductListCount(selectMap); 
		}
		int totalPage = totalProductSize/perPage;
		if(totalProductSize%perPage!=0) {
			totalPage++;
		}
		
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		m.addAttribute("ProductList", ProductList);
		m.addAttribute("CategoryList",CategoryList);
		m.addAttribute("category", category);
		m.addAttribute("search", search);
		m.addAttribute("sort", sort);
		m.addAttribute("totalPage", totalPage);
		m.addAttribute("currentPage", page);
		return "shoppingMall/shopList";
	}
	
	@GetMapping(value="/shopDetail")
	public String shopDetail(int productId, Integer reviewPage, Model m) {
		//페이징
		int perPage = 5;
		if(reviewPage == null) reviewPage = 1;
		int totalReviews = productReviewService.selectReviewList(productId, new RowBounds(0, Integer.MAX_VALUE)).size();
		int totalPage = (int) Math.ceil((double) totalReviews / perPage);
		RowBounds bounds = new RowBounds(0 , perPage*reviewPage);

		ProductDTO productDTO = service.selectDetailproduct(productId);
		List<ProductReviewDTO> productReviewDTO = productReviewService.selectReviewList(productId,bounds);
		List<ProductOptionDTO> options = service.selectProductOptions(productId);
		service.addViewCount(productId); //조회수++
		
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		m.addAttribute("CategoryList",CategoryList);
		m.addAttribute("reviewPage", reviewPage);
		m.addAttribute("totalPage", totalPage);
		m.addAttribute("product", productDTO);
		m.addAttribute("productReview", productReviewDTO);
		m.addAttribute("options", options);
		return "shoppingMall/shopDetail";
	}
	
	@GetMapping(value="/product")
	public String productInsertForm(Model m) {
		int n = service.maxProductId(); //등록될 상품id값
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		m.addAttribute("CategoryList",CategoryList);
		m.addAttribute("ProductId",n);
		return "shoppingMall/productInsert";
	}
	
	@PostMapping(value="/product")
	public String productInsert(MultipartFile product_image, ProductDTO ProductDTO, Model m, RedirectAttributes redirectAttributes,
			@RequestParam(value = "option_type", required = false) List<String> optionTypes,
            @RequestParam(value = "option_name", required = false) List<String> optionNames) {
		String uploadDir = "C:/images/shoppingMall_product/"; //이미지 저장 경로
		UUID uuid = UUID.randomUUID();
		InputStream inputStream = null;
		int num = 0;
		try {
			inputStream = product_image.getInputStream();
			String imgName = uuid + product_image.getOriginalFilename();
			ProductDTO.setProduct_imagename(imgName);
			num = service.insertProduct(ProductDTO);
			product_image.transferTo(new File(uploadDir + imgName)); //이미지 저장
			
			// 옵션 처리
	        if (optionTypes != null && optionNames != null) {
	            for (int i = 0; i < optionTypes.size(); i++) {
	                String optionType = optionTypes.get(i);
	                String optionName = optionNames.get(i);

	                if (optionType != null && !optionType.isEmpty()) {
	                    ProductOptionDTO option = new ProductOptionDTO();
	                    option.setProduct_id(ProductDTO.getProduct_id());
	                    option.setOption_type(optionType);
	                    option.setOption_name(optionName);
	                    service.insertProductOption(option);
	                }
	            }
	        }
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(inputStream!=null)inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		String mesg = "";
		if(num==1) {
			mesg = "상품 등록이 완료되었습니다.";
		} else {
			mesg = "상품 등록에 실패했습니다.";
		}
		
		redirectAttributes.addFlashAttribute("mesg", mesg);
		return "redirect:/shopList";
	}
	
	@DeleteMapping(value="/product/productId/{productId}")
	@ResponseBody
	public Map<String,String> productDelete(@PathVariable("productId") int productId, Model m) {
		//저장된 외부 이미지 삭제
		ProductDTO productDTO = service.selectDetailproduct(productId);
		String imgName = productDTO.getProduct_imagename();
		if (imgName != null) {
			String uploadDir = "C:/images/shoppingMall_product/";
			File file = new File(uploadDir + imgName);
			file.delete(); // 파일이미지 삭제
		}
		//상품 삭제 
		int n = service.productDelete(productId);
		Map<String,String> map = new HashMap<String, String>();
		map.put("mesg","상품이 삭제 되었습니다.");
		if(n!=1) {
			map.put("mesg","상품 삭제 실패");
		}
		return map;
	}
	
	@GetMapping(value="/productUpdate")
	public String productUpdate(int productId, Model m,
			@RequestParam(value = "page", required = false, defaultValue = "1") String page) {
		ProductDTO productDTO = service.selectDetailproduct(productId);
		List<ProductOptionDTO> options = service.selectProductOptions(productId);
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		m.addAttribute("CategoryList",CategoryList);
		m.addAttribute("product", productDTO);
		m.addAttribute("options", options);
		m.addAttribute("currentPage", page);
		return "shoppingMall/productUpdate";
	}
	
	@PostMapping(value="/productUpdate")
	public String productUpdatePost(MultipartFile product_image, ProductDTO ProductDTO, Model m,
			@RequestParam(value = "option_type", required = false) List<String> optionTypes,
            @RequestParam(value = "option_name", required = false) List<String> optionNames,
			@RequestParam(value = "page", required = false, defaultValue = "1") String page, RedirectAttributes ra) {	
		String uploadDir = "C:/images/shoppingMall_product/"; //이미지 저장 경로
		UUID uuid = UUID.randomUUID();
		String imgName = null;
		InputStream inputStream = null;
		try {
			if(!product_image.isEmpty()) {
				//기존 이미지 삭제
				ProductDTO productDTO = service.selectDetailproduct(ProductDTO.getProduct_id());
				imgName = productDTO.getProduct_imagename();
				if (imgName != null) {
					File file = new File(uploadDir + imgName);
					file.delete(); // 이미지 삭제
				}
				//새로운 이미지 등록
				inputStream = product_image.getInputStream();
				imgName = uuid + product_image.getOriginalFilename();
				ProductDTO.setProduct_imagename(imgName);
				product_image.transferTo(new File(uploadDir + imgName)); //이미지 저장
			} 
			int n = service.updateProduct(ProductDTO);
			/*
			if(n==1) {
				m.addAttribute("mesg","상품을 수정했습니다.");
			}
			*/
			// 기존 옵션 조회
	        List<ProductOptionDTO> existingOptions = service.selectProductOptions(ProductDTO.getProduct_id());

	        // 옵션 처리
	        if (optionTypes != null && optionNames != null) {
	            for (int i = 0; i < optionTypes.size(); i++) {
	                String optionType = optionTypes.get(i);
	                String optionName = optionNames.get(i);

	                if (optionType != null && !optionType.isEmpty()) {
	                    boolean isUpdated = false;

	                    // 기존 옵션과 비교하여 업데이트 또는 추가
	                    for (ProductOptionDTO existingOption : existingOptions) {
	                        if (existingOption.getOption_type().equals(optionType)) {
	                            // OPTION_TYPE이 같은 경우 OPTION_NAME 업데이트
	                            existingOption.setOption_name(optionName);
	                            service.updateProductOption(existingOption);
	                            isUpdated = true;
	                            break;
	                        }
	                    }

	                    // OPTION_TYPE이 없는 경우 새로운 옵션 추가
	                    if (!isUpdated) {
	                        ProductOptionDTO newOption = new ProductOptionDTO();
	                        newOption.setProduct_id(ProductDTO.getProduct_id());
	                        newOption.setOption_type(optionType);
	                        newOption.setOption_name(optionName);
	                        service.insertProductOption(newOption);
	                    }
	                }
	            }

	            // 삭제해야 할 기존 옵션 처리
	            for (ProductOptionDTO existingOption : existingOptions) {
	                boolean shouldDelete = true;

	                // 현재 옵션 리스트와 비교하여 삭제 여부 결정
	                for (String optionType : optionTypes) {
	                    if (existingOption.getOption_type().equals(optionType)) {
	                        shouldDelete = false;
	                        break;
	                    }
	                }

	                if (shouldDelete) {
	                    service.deleteProductOption(existingOption.getOption_id());
	                }
	            }
	        }
	        
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(inputStream!=null)inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		ra.addAttribute("page", page);
		
		return "redirect:/shopList";
	}
		
	
}
