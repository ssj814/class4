package com.example.controller.shoppingmall;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

import com.example.dto.BoardPostsDTO;
import com.example.dto.FaqDTO;
import com.example.dto.NoticeDTO;
import com.example.dto.ProductCategoryDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.dto.ProductRecentDTO;
import com.example.dto.ProductReviewDTO;
import com.example.service.faq.FaqService;
import com.example.service.image.ImageService;
import com.example.service.notice.NoticeService;
import com.example.service.shoppingmall.ProductReviewService;
import com.example.service.shoppingmall.ProductService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {
	
	@Autowired
	ProductService service;
	
	@Autowired
	ProductReviewService productReviewService;
	
	@Autowired
	NoticeService nService;
	
	@Autowired
	ImageService imageService;
	
	@Autowired
	FaqService faqService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String shopMain(Model m, HttpSession session) {
		List<ProductDTO> popularProduct = service.selectProductMainList("PRODUCT_VIEW");
		List<ProductDTO> newProduct = service.selectProductMainList("PRODUCT_CREATEDAT");
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		Boolean noticePopupClosed = (Boolean) session.getAttribute("noticePopupClosed");
		System.out.println("noticePopupClosed : "+noticePopupClosed);
	    if (noticePopupClosed == null || !noticePopupClosed) {
	        List<BoardPostsDTO> popupNotices = nService.getPopupPosts();
	        session.setAttribute("popupNotices", popupNotices);
	    }
		m.addAttribute("popularProduct",popularProduct);
		m.addAttribute("newProduct",newProduct);
		m.addAttribute("CategoryList",CategoryList);
		return "shoppingMall/shopMain";
	}
	
	@RequestMapping(value="/shopList", method=RequestMethod.GET)
	public String shopList(Model m,
			@RequestParam(value="category", required = false) String category,
			@RequestParam(value="page", required = false, defaultValue = "1") Integer page,
			@RequestParam(value="search", required = false) String search,
			@RequestParam(value="sort", required = false) String sort ) {

		int perPage = 8; 
		RowBounds bounds = null;
		bounds = new RowBounds((page-1)*perPage,perPage);

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
		int totalProductSize = service.selectProductMainList("PRODUCT_VIEW").size(); // 전체 상품 개수
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

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String user_id = authentication.getName();
		
		// 최근 본 상품 목록 조회 및 이미지 정보 추가
	    List<Map<String, Object>> recentProductWithImages = getRecentImages(user_id);
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		m.addAttribute("recentProducts", recentProductWithImages);
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
	public String shopDetail(int productId, Model m,
			@RequestParam(value="reviewPage", required = false, defaultValue = "1") Integer reviewPage,
			@RequestParam(value="sortType", required = false, defaultValue = "newest") String sortType) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String user_id = authentication.getName();
		
		// 최근 본 상품 추가 또는 업데이트 처리
	    manageRecentProduct(productId, user_id);

	    // 최근 본 상품 목록 조회 및 이미지 정보 추가
	    List<Map<String, Object>> recentProductWithImages = getRecentImages(user_id);
	    
		//selectReviewList용 map 생성
		Map<String, Object> map = new HashMap<>();
		map.put("productId", productId);
		map.put("sortType", sortType);
		
		//총 평점
		List<ProductReviewDTO> allProductReview = productReviewService.selectReviewList(map, new RowBounds(0, Integer.MAX_VALUE));
		double averageRating = allProductReview.stream()
			    .mapToDouble(ProductReviewDTO::getRating) // 각 리뷰의 평점을 DoubleStream으로 변환
			    .average() // 평균 계산
			    .orElse(0.0); // 값이 없을 경우 기본값 설정
		long roundedAverageRating = Math.round(averageRating);
		
		//리뷰 페이징
		int perPage = 5;
		int totalReviews = allProductReview.size();
		int totalPage = (int) Math.ceil((double) totalReviews / perPage);
		RowBounds bounds = new RowBounds(0, perPage*reviewPage);
		
		ProductDTO productDTO = service.selectDetailproduct(productId);
		List<ProductReviewDTO> productReviewDTO = productReviewService.selectReviewList(map,bounds);
		List<ProductOptionDTO> rawOptions = service.selectProductOptions(productId);
		// 옵션 데이터 가공
	    Map<String, List<ProductOptionDTO>> groupedOptions = rawOptions.stream()
	            .collect(Collectors.groupingBy(ProductOptionDTO::getOption_type));
	    
	    System.out.println("groupedOptions" + groupedOptions);
	    
	    List<Map<String, String>> options = new ArrayList<>();
	    for (String optionType : groupedOptions.keySet()) {
	        List<ProductOptionDTO> optionList = groupedOptions.get(optionType);

	        // 옵션 이름과 재고를 ,로 연결
	        String optionNames = optionList.stream()
	                .map(ProductOptionDTO::getOption_name)
	                .collect(Collectors.joining(","));
	        String stocks = optionList.stream()
	                .map(option -> String.valueOf(option.getStock()))
	                .collect(Collectors.joining(","));
	        
	        // 옵션상품의 총 재고량 
	        int totalStock = optionList.stream()
	                .mapToInt(ProductOptionDTO::getStock)
	                .sum();

	        // 가공된 데이터 추가
	        Map<String, String> optionData = new HashMap<>();
	        optionData.put("option_type", optionType);
	        optionData.put("option_name", optionNames);
	        optionData.put("stock", stocks);
	        optionData.put("totalStock", String.valueOf(totalStock));
	        options.add(optionData);
	    }
		service.addViewCount(productId); //조회수++
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		// 상품 문의
		HashMap<String, Object> askMap = new HashMap<>();
		askMap.put("category", "ask-product");
		List<FaqDTO> ask = faqService.qnaList(askMap, new RowBounds());
		
		m.addAttribute("averageRating",roundedAverageRating);
	    m.addAttribute("sortType",sortType);
		m.addAttribute("recentProducts", recentProductWithImages);
		m.addAttribute("CategoryList",CategoryList);
		m.addAttribute("reviewPage", reviewPage);
		m.addAttribute("totalPage", totalPage);
		m.addAttribute("product", productDTO);
		m.addAttribute("productReview", productReviewDTO);
		m.addAttribute("options", options);
		m.addAttribute("ask", ask);
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
	
	//상품 등록
	@PostMapping(value="/product")
	public String productInsert(MultipartFile product_image, ProductDTO ProductDTO, Model m, RedirectAttributes redirectAttributes,
			@RequestParam(value = "option_type", required = false) List<String> optionTypes,
			@RequestParam(value = "option_name", required = false) List<String> optionNames,
            @RequestParam(value = "stock", required = false) List<String> stocks,
            @RequestParam(value = "stock_no_option", required = false, defaultValue = "0") Integer stockNoOption) {
		
		//이미지 처리
		String imgName = imageService.saveImg(product_image, "shoppingMall_product");
		ProductDTO.setProduct_imagename(imgName);
		
		//상품 등록
		int insertResult = service.insertProduct(ProductDTO);
		
	    if (optionTypes != null && !optionTypes.isEmpty()) {
	        // 옵션 처리
	    	processProductOptions(ProductDTO.getProduct_id(), optionTypes, optionNames, stocks, new ArrayList<>());
	        ProductDTO.setProduct_stock(0); // 옵션이 있는 경우, stock을 0으로 설정
	        service.updateProductStock(ProductDTO);
	    } else {
	        // 옵션이 없는 경우 처리
	        if (stockNoOption != null && stockNoOption > 0) {
	            ProductDTO.setProduct_stock(stockNoOption);
	            service.updateProductStock(ProductDTO);
	        }
	    }
	    
	    String mesg = insertResult == 1 ? "상품 등록이 완료되었습니다." : "상품 등록에 실패했습니다.";
		redirectAttributes.addFlashAttribute("mesg", mesg);
		return "redirect:/shopList";
	}
	
	//상품 삭제
	@DeleteMapping(value="/product/productId/{productId}")
	@ResponseBody
	public Map<String,String> productDelete(@PathVariable("productId") int productId, Model m) {
		
		Map<String,String> response = new HashMap<String, String>();
		
		//상품 데이터 조회
		ProductDTO productDTO = service.selectDetailproduct(productId);
		if(productDTO == null) {
			response.put("mesg","상품이 존재하지 않습니다.");
			return response;
		}
		
		//이미지 삭제
		String imgName = productDTO.getProduct_imagename();
		imageService.deleteImg(imgName,"shoppingMall_product");

		//상품 삭제 
		int deleteResult  = service.productDelete(productId);
		
		if(deleteResult == 1) {
			response.put("mesg","상품이 삭제 되었습니다.");
		} else {
			response.put("mesg","상품 삭제 실패.");
		}
		return response;
	}
	
	@GetMapping(value="/productUpdate")
	public String productUpdate(int productId, Model m,
			@RequestParam(value = "page", required = false, defaultValue = "1") String page) {
		ProductDTO productDTO = service.selectDetailproduct(productId);
		List<ProductOptionDTO> rawOptions  = service.selectProductOptions(productId);
		List<ProductCategoryDTO> CategoryList = service.selectCategoryList();
		
		// 옵션 데이터 가공
	    Map<String, List<ProductOptionDTO>> groupedOptions = rawOptions.stream()
	            .collect(Collectors.groupingBy(ProductOptionDTO::getOption_type));

	    List<Map<String, String>> options = new ArrayList<>();
	    for (String optionType : groupedOptions.keySet()) {
	        List<ProductOptionDTO> optionList = groupedOptions.get(optionType);

	        // 옵션 이름과 재고를 ,로 연결
	        String optionNames = optionList.stream()
	                .map(ProductOptionDTO::getOption_name)
	                .collect(Collectors.joining(","));
	        String stocks = optionList.stream()
	                .map(option -> String.valueOf(option.getStock()))
	                .collect(Collectors.joining(","));

	        // 가공된 데이터 추가
	        Map<String, String> optionData = new HashMap<>();
	        optionData.put("option_type", optionType);
	        optionData.put("option_name", optionNames);
	        optionData.put("stock", stocks);
	        options.add(optionData);
	    }
	    
	    // 옵션 여부 설정
	    productDTO.setHasOptions(!rawOptions.isEmpty());
	    
		m.addAttribute("CategoryList",CategoryList);
		m.addAttribute("product", productDTO);
		m.addAttribute("options", options);
		m.addAttribute("currentPage", page);
		return "shoppingMall/productUpdate";
	}
	
	//상품 수정
	@PostMapping(value="/productUpdate")
	public String productUpdatePost(MultipartFile product_image, ProductDTO ProductDTO, Model m,
			@RequestParam(value = "option_type", required = false) List<String> optionTypes,
            @RequestParam(value = "option_name", required = false) List<String> optionNames,
            @RequestParam(value = "stock", required = false) List<String> stocks,
            @RequestParam(value = "stock_no_option", required = false, defaultValue = "0") int stockNoOption,
			@RequestParam(value = "page", required = false, defaultValue = "1") String page, RedirectAttributes redirectAttributes) {	
		
		//상품 조회
		ProductDTO productDTO = service.selectDetailproduct(ProductDTO.getProduct_id());
		
		//이미지 처리
		String preimgName = productDTO.getProduct_imagename();
		String imgName = imageService.updateImg(product_image, preimgName, "shoppingMall_product");
		ProductDTO.setProduct_imagename(imgName);
		
		//상품 수정
		int updateResult = service.updateProduct(ProductDTO);
		
		// 기존 옵션 조회
        List<ProductOptionDTO> existingOptions = service.selectProductOptions(ProductDTO.getProduct_id());
        
        // 옵션 처리
        if (optionTypes != null && optionNames != null && stocks != null) {
            // 기존 옵션 전달
        	processProductOptions(ProductDTO.getProduct_id(), optionTypes, optionNames, stocks, existingOptions);
        } else {
            // 옵션이 없는 경우 처리
            if (existingOptions != null && !existingOptions.isEmpty()) {
                for (ProductOptionDTO existingOption : existingOptions) {
                    service.deleteProductOption(existingOption.getOption_id());
                }
            }
            // 상품 수량 업데이트
            ProductDTO.setProduct_stock(stockNoOption);
            service.updateProductStock(ProductDTO);
        }
        
        String mesg = updateResult == 1 ? "수정 완료 되었습니다." : "수정 실패 되었습니다.";
		redirectAttributes.addFlashAttribute("mesg", mesg);
	//	ra.addAttribute("page", page);
		
		return "redirect:/shopList";
	}
	
	private void manageRecentProduct(int productId, String userId) {
	    Map<String, Object> data = new HashMap<>();
	    data.put("product_id", productId);
	    data.put("user_id", userId);

	    // 최근 본 상품 추가 또는 업데이트
	    ProductRecentDTO existingRecentView = service.checkRecentView(data);
	    if (existingRecentView != null) {
	        service.updateRecentView(data);
	    } else {
	        service.insertRecentView(data);
	    }
	    
	    // 최근 본 상품이 20개를 초과하면 가장 오래된 항목을 삭제
	    List<ProductRecentDTO> recentProducts = service.getRecentProducts(userId);
	    if (recentProducts.size() > 20) {
	        service.deleteRecentView(userId); // 가장 오래된 항목 삭제
	    }
	}

	private List<Map<String, Object>> getRecentImages(String userId) {
	    // 최근 본 상품 목록 조회
	    List<ProductRecentDTO> recentProducts = service.getRecentProducts(userId);

	    // 각 productId에 맞는 이미지 정보 조회 및 추가
	    List<Map<String, Object>> recentProductWithImages = new ArrayList<>();
	    for (ProductRecentDTO recentProduct : recentProducts) {
	        ProductDTO product = service.selectDetailproduct(recentProduct.getProduct_id());
	        Map<String, Object> productData = new HashMap<>();
	        productData.put("productId", product.getProduct_id());
	        productData.put("productImage", product.getProduct_imagename());
	        recentProductWithImages.add(productData);
	    }
	    
	    return recentProductWithImages;
	}
	
	@GetMapping("/clearPopupNotice")
	@ResponseBody
	public ResponseEntity<Void> clearPopupNotice(HttpSession session) {
	    session.setAttribute("noticePopupClosed", true);
	    session.removeAttribute("popupNotices");
	    return ResponseEntity.ok().build();
	}
	
	private void processProductOptions(
		    int productId,
		    List<String> optionTypes,
		    List<String> optionNames,
		    List<String> stocks,
		    List<ProductOptionDTO> existingOptions
		) {
		    if (optionTypes == null || optionNames == null || stocks == null) {
		        return; // 옵션이 없으면 바로 종료
		    }

		    if (optionTypes.size() == 1) {
		        // 단일 옵션 처리
		        String optionType = optionTypes.get(0);
		        for (int i = 0; i < optionNames.size(); i++) {
		            String optionName = optionNames.get(i);
		            String stock = stocks.get(i);

		            String[] optionNameArray = optionName.split(",");
		            String[] stockArray = stock.split(",");
		            if (optionNameArray.length != stockArray.length) {
		                throw new IllegalArgumentException("옵션 이름과 재고의 개수가 맞지 않습니다.");
		            }

		            // 옵션 추가 또는 업데이트
		            for (int j = 0; j < optionNameArray.length; j++) {
		                String name = optionNameArray[j].trim();
		                Integer stockValue = Integer.parseInt(stockArray[j].trim());

		                boolean isUpdated = false;
		                for (ProductOptionDTO existingOption : existingOptions) {
		                    if (existingOption.getOption_type().equals(optionType) &&
		                        existingOption.getOption_name().equals(name)) {
		                        existingOption.setStock(stockValue);
		                        service.updateProductOption(existingOption);
		                        isUpdated = true;
		                        break;
		                    }
		                }

		                if (!isUpdated) {
		                    ProductOptionDTO newOption = new ProductOptionDTO();
		                    newOption.setProduct_id(productId);
		                    newOption.setOption_type(optionType);
		                    newOption.setOption_name(name);
		                    newOption.setStock(stockValue);
		                    service.insertProductOption(newOption);
		                }
		            }
		        }
		    } else {
		        // 다중 옵션 처리
		        for (int i = 0; i < optionTypes.size(); i++) {
		            String optionType = optionTypes.get(i);
		            String optionName = optionNames.get(i);
		            String stock = stocks.get(i);

		            String[] optionNameArray = optionName.split(",");
		            String[] stockArray = stock.split(",");
		            if (optionNameArray.length != stockArray.length) {
		                throw new IllegalArgumentException("옵션 이름과 재고의 개수가 맞지 않습니다.");
		            }

		            for (int j = 0; j < optionNameArray.length; j++) {
		                String name = optionNameArray[j].trim();
		                Integer stockValue = Integer.parseInt(stockArray[j].trim());

		                boolean isUpdated = false;
		                for (ProductOptionDTO existingOption : existingOptions) {
		                    if (existingOption.getOption_type().equals(optionType) &&
		                        existingOption.getOption_name().equals(name)) {
		                        existingOption.setStock(stockValue);
		                        service.updateProductOption(existingOption);
		                        isUpdated = true;
		                        break;
		                    }
		                }

		                if (!isUpdated) {
		                    ProductOptionDTO newOption = new ProductOptionDTO();
		                    newOption.setProduct_id(productId);
		                    newOption.setOption_type(optionType);
		                    newOption.setOption_name(name);
		                    newOption.setStock(stockValue);
		                    service.insertProductOption(newOption);
		                }
		            }
		        }
		    }

		    // 삭제해야 할 기존 옵션 처리
        	if (optionTypes.size() == 1) {
        	    // 단일 옵션 처리
        	    String optionType = optionTypes.get(0); // 단일 옵션 타입
        	    List<String> optionNameList = optionNames; // 넘어온 옵션 이름 리스트

        	    for (ProductOptionDTO existingOption : existingOptions) {
        	        boolean shouldDelete = true;

        	        // 동일한 옵션 타입 내에서 이름이 존재하는지 확인
        	        if (existingOption.getOption_type().equals(optionType) &&
        	            optionNameList.contains(existingOption.getOption_name())) {
        	            shouldDelete = false;
        	        }

        	        // 삭제 처리
        	        if (shouldDelete) {
        	            service.deleteProductOption(existingOption.getOption_id());
        	        }
        	    }
        	} else {
        	    // 다중 옵션 처리
        	    for (ProductOptionDTO existingOption : existingOptions) {
        	        boolean shouldDelete = true;

        	        for (int i = 0; i < optionTypes.size(); i++) {
        	            String optionType = optionTypes.get(i);
        	            String[] optionNameArray = optionNames.get(i).split(",");

        	            // 동일한 옵션 타입 내에서 이름이 존재하는지 확인
        	            if (existingOption.getOption_type().equals(optionType) &&
        	                Arrays.asList(optionNameArray).contains(existingOption.getOption_name())) {
        	                shouldDelete = false;
        	                break;
        	            }
        	        }

        	        // 삭제 처리
        	        if (shouldDelete) {
        	            service.deleteProductOption(existingOption.getOption_id());
        	        }
        	    }
        	}
		}
	
	//상품 문의
	@GetMapping("/user/shop_productAsk/{productId}")
	public String getProductAskPage(@PathVariable int productId, Model m) {
		m.addAttribute("productId", productId);
		return "shoppingMall/shopAskForm";
	}
	
	@PostMapping("/shop_productAsk")
	public String postProductAsk(FaqDTO faqDTO,
			RedirectAttributes redirectAttributes) {
		//유저 처리
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String user_id = authentication.getName();
		faqDTO.setQuestioner(user_id);
		faqDTO.setCategory("ask-product");
		
		faqService.saveQuestion(faqDTO);

		redirectAttributes.addFlashAttribute("closeWindow", true);
		return "redirect:/user/shop_productAsk/" + faqDTO.getProduct_id();
	}
	
}
