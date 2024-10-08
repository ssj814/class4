package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.CartDTO;
import com.example.dto.CartProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.service.CartService;
import com.example.service.ProductService;
import com.example.service.WishService;

@Controller
public class CartController {
	
	@Autowired
	CartService service;
	@Autowired
	WishService wishService;
	@Autowired
	ProductService productService;

	@GetMapping("/cartList")
	public String cartList(Model m) {
		int user_id = 1;
		List<CartProductDTO> ProductList = service.selectCart(user_id);
		 for (CartProductDTO product : ProductList) {
			// 모든 옵션을 가져오기
		        List<ProductOptionDTO> allOptions = productService.selectProductOptions(product.getProduct_id());
		        product.setAllOptions(allOptions);
		        
		        // 장바구니에 선택된 옵션을 가져오기
		        List<CartDTO> selectedOptions = service.selectProductOptions(product.getProduct_id(), user_id);
		        product.setSelectedOptions(selectedOptions);
		    }
		m.addAttribute("ProductList", ProductList);
		return "shoppingMall/cartList";
	}
	
	@PostMapping("/cart")
	@ResponseBody
	public Map<String,String> cartInsert(@RequestBody Map<String, Object> requestMap) {
		int user_Id = 1; //임시 유저
		int productId = (int) requestMap.get("productId");
		List<Map<String, String>> options = (List<Map<String, String>>) requestMap.get("options");
		
		// 옵션 데이터를 쉼표로 구분된 문자열로 변환
		// StringBuilder : 문자열을 반복적으로 수정하거나 추가하는 작업에서 String보다 성능 좋음
	    StringBuilder optionTypes = new StringBuilder();
	    StringBuilder optionNames = new StringBuilder();
	    for (Map<String, String> option : options) {
	        if (optionTypes.length() > 0) {
	            optionTypes.append(",");
	            optionNames.append(",");
	        }
	        optionTypes.append(option.get("type"));
	        optionNames.append(option.get("name"));
	    }
		
		
		Map<String,Object> map = new HashMap<>();
		map.put("user_id", user_Id);
		map.put("product_Id", productId);
		map.put("option_type", optionTypes.toString());
	    map.put("option_name", optionNames.toString());
		
		int check = service.cartCheck(map); //cart에 존재여부
		Map<String,String> responseMap = new HashMap<String,String>();
		if (check == 1) {
	        // 이미 장바구니에 존재하는 경우 수량 증가
	        int updateResult = service.increaseQuantity(map);
	        if (updateResult == 1) {
	            responseMap.put("mesg", "장바구니에 기존 항목 수량 증가 완료");
	        } else {
	            responseMap.put("mesg", "수량 증가 실패");
	        }
	    } else {
	        // 장바구니에 존재하지 않는 경우 새로 추가
	        int insertResult = service.cartInsert(map);
	        if (insertResult == 1) {
	            responseMap.put("mesg", "장바구니 추가 완료");
	        } else {
	            responseMap.put("mesg", "장바구니 추가 실패");
	        }
	    }
		return responseMap;
	}
	
	@PostMapping("/cartQuantity")
	@ResponseBody
	public void cartUpdate(@RequestParam("productId") Integer productId, 
	                       @RequestParam("quantity") Integer quantity) {
	    if (productId == null || quantity == null) {	// 유효성 검사
	        throw new IllegalArgumentException("Product ID and Quantity cannot be null");
	    }

	    int user_Id = 1; // 임시 유저 ID 설정
	    CartDTO dto = new CartDTO();
	    dto.setUser_id(user_Id);
	    dto.setProduct_id(productId);
	    dto.setQuantity(quantity);
	    service.cartUpdate(dto);
	}
	
	@PostMapping("/cartDelete")
	@ResponseBody
	public void deleteCartItems(@RequestParam("productIds") List<Integer> productIds) {
	    if (productIds == null || productIds.isEmpty()) {
	        throw new IllegalArgumentException("삭제할 상품이 선택되지 않았습니다.");
	    }

	    int userId = 1; // 임시 유저 ID 설정
	    productIds.forEach(productId -> {
	        CartDTO dto = new CartDTO();
	        dto.setUser_id(userId);
	        dto.setProduct_id(productId);
	        service.cartDelete(dto);
	    });
	}
	
	
}
