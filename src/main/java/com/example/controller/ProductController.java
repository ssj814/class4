package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	ProductService service;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String shopMain(Model m) {
		List<ProductDTO> ProductList = service.selectProductMainList();
		m.addAttribute("ProductList",ProductList);
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
			int offset = (Integer.parseInt(page)-1)*perPage;
			bounds = new RowBounds(offset,8);
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
		m.addAttribute("ProductList", ProductList);
		m.addAttribute("category", category);
		m.addAttribute("search", search);
		m.addAttribute("sort", sort);
		m.addAttribute("totalPage", totalPage);
		m.addAttribute("currentPage", page);
		return "shoppingMall/shopList";
	}
	
	/*
	@RequestMapping("/getImage") //image로 바꾸기
	public void image(int productId, HttpServletResponse response) {
		ProductDTO dto = service.selectDetailproduct(productId);
        InputStream imageStream = (InputStream)dto.getProduct_image();
        response.setContentType("image/jpeg"); //이미지 MIME 타입설정
        OutputStream out = null; //응답스트림으로 데이터 쓰기
		try {
			out = response.getOutputStream();
	        byte[] buffer = new byte[4096];
	        int bytesRead = -1;
	        while ((bytesRead = imageStream.read(buffer)) != -1) {
	           out.write(buffer, 0, bytesRead);
	        }
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
	        try {
	        	if(imageStream!=null)imageStream.close();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	*/
	
	@RequestMapping(value="/shopDetail", method=RequestMethod.GET)
	public String shopDetail(int productId, Model m) {
		service.addViewCount(productId); //조회수++
		ProductDTO product = service.selectDetailproduct(productId);
		m.addAttribute("product", product);
		return "shoppingMall/shopDetail";
	}
	
	@GetMapping(value="/product")
	public String productInsertForm(Model m) {
		int n = service.maxProductId(); //등록될 상품id값
		m.addAttribute("ProductId",n);
		return "shoppingMall/productInsert";
	}
	
	@PostMapping(value="/product")
	public String productInsert(MultipartFile product_image, ProductDTO ProductDTO, Model m,
			@RequestParam(value = "option_type", required = false) List<String> optionTypes,
            @RequestParam(value = "option_name", required = false) List<String> optionNames) {
		String uploadDir = "C:/images/shoppingMall_product/"; //이미지 저장 경로
		InputStream inputStream = null;
		
		System.out.println(">>>>>"+optionTypes+"\t"+optionNames);
		
		try {
			inputStream = product_image.getInputStream();
			ProductDTO.setProduct_imagename(product_image.getOriginalFilename());
			service.insertProduct(ProductDTO);
			product_image.transferTo(new File(uploadDir + product_image.getOriginalFilename())); //이미지 저장
			
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
		return "redirect:/shopList";
	}
	
	@DeleteMapping(value="/product/productId/{productId}")
	@ResponseBody
	public Map<String,String> productDelete(@PathVariable("productId") int productId, Model m) {
		//삭제되면 추가하기 귀찮아서 일단 막아둠.
		//int n = service.productDelete(productId);
		Map<String,String> map = new HashMap<String, String>();
		map.put("mesg","삭제완료");
		/*
		if(n!=1) {
			map.put("mesg","오류");
		}
		*/
		return map;
	}
	
	@GetMapping(value="/productUpdate")
	public String productUpdate(int productId, Model m,
			@RequestParam(value = "page", required = false, defaultValue = "1") String page) {
		ProductDTO productDTO = service.selectDetailproduct(productId);
		m.addAttribute("product", productDTO);
		m.addAttribute("currentPage", page);
		return "shoppingMall/productUpdate";
	}
	
	@PostMapping(value="/productUpdate")
	public String productUpdatePost(MultipartFile product_image, ProductDTO ProductDTO, Model m,
			@RequestParam(value = "page", required = false, defaultValue = "1") String page, RedirectAttributes ra) {	
		String uploadDir = "C:/images/shoppingMall_product/"; //이미지 저장 경로
		InputStream inputStream = null;
		try {
			if(!product_image.isEmpty()) {
				inputStream = product_image.getInputStream();
				ProductDTO.setProduct_imagename(product_image.getOriginalFilename());
				product_image.transferTo(new File(uploadDir + product_image.getOriginalFilename())); //이미지 저장
			} 
			int n = service.updateProduct(ProductDTO);
			/*
			if(n==1) {
				m.addAttribute("mesg","상품을 수정했습니다.");
			}
			*/
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
