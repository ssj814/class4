package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.CartDTO;
import com.example.dto.CartProductDTO;
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
		m.addAttribute("ProductList", ProductList);
		return "shoppingMall/cartList";
	}
	
	@GetMapping("/cart")
	@ResponseBody
	public Map<String,String> cartInsert(int productId, Model m) {
		int user_Id = 1; //임시 유저
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id", user_Id);
		map.put("product_Id", productId);
		int check = service.cartCheck(map); //cart에 존재?
		Map<String,String> responseMap = new HashMap<String,String>();
		responseMap.put("mesg","이미 장바구니에 존재하는 상품입니다");
		if(check!=1) {
			int n = service.cartInsert(map);
			if(n==1) {
				responseMap.put("mesg","장바구니 추가 완료");
			}else {
				responseMap.put("mesg","실패");
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
