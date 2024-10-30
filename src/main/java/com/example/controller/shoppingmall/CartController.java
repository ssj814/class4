package com.example.controller.shoppingmall;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
import com.example.service.shoppingmall.CartService;
import com.example.service.shoppingmall.ProductService;
import com.example.service.shoppingmall.WishService;
import com.example.service.user.SecurityUserDetailService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {
	
	@Autowired
	CartService service;
	@Autowired
	WishService wishService;
	@Autowired
	ProductService productService;

	@GetMapping("/cartList")
	public String cartList(Model m, HttpSession session ) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String user_id = authentication.getName();
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
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		//int user_Id = 1; //임시 유저
		String user_Id = authentication.getName();

		int productId = (int) requestMap.get("productId");
		int productQuantity = (int) requestMap.get("productQuantity");
		List<Map<String, String>> options = (List<Map<String, String>>) requestMap.get("options");
		Map<String,Object> map = createCartMap(user_Id, productId, -1, options);
		int check = service.cartCheck(map); //cart에 존재여부
		
		map.put("quantity", productQuantity);
		Map<String,String> responseMap = new HashMap<String,String>();
		if (check == 1) {
	        // 이미 장바구니에 존재하는 경우 수량 증가
	        int updateResult = service.increaseQuantity(map);
	        responseMap.put("mesg", updateResult == 1 ? "장바구니에 기존 항목 수량 증가 완료" : "수량 증가 실패");
	    } else {
	        // 장바구니에 존재하지 않는 경우 새로 추가
	        int insertResult = service.cartInsert(map);
	        responseMap.put("mesg", insertResult == 1 ? "장바구니 추가 완료" : "장바구니 추가 실패");
	    }
		return responseMap;
	}
	
	@PostMapping("/cartQuantity")
	@ResponseBody
	public void cartUpdate(@RequestParam("cartId") Integer cartId, 
	@RequestParam("quantity") Integer quantity) {
		if (cartId == null || quantity == null ) {	// 유효성 검사
	        throw new IllegalArgumentException("Cart ID and Quantity cannot be null");
	    }

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String user_Id = authentication.getName();
	    CartDTO dto = new CartDTO();
	    dto.setUser_id(user_Id);
	    dto.setCart_id(cartId);
	    dto.setQuantity(quantity);
	    service.cartUpdate(dto);
	}
	
	@PostMapping("/cartDelete")
	@ResponseBody
	public void deleteCartItems(@RequestParam("cartIds") List<Integer> cartIds) {
	    if (cartIds == null || cartIds.isEmpty()) {
	        throw new IllegalArgumentException("삭제할 상품이 선택되지 않았습니다.");
	    }

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String user_Id = authentication.getName();
	    cartIds.forEach(cartId -> {
	        CartDTO dto = new CartDTO();
	        dto.setUser_id(user_Id);
	        dto.setCart_id(cartId);
	        service.cartDelete(dto);
	    });
	}
	
	@PostMapping("/updateCartOption")
	@ResponseBody
	public Map<String, String> updateCartOption(@RequestBody Map<String, Object> requestMap) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		//int user_Id = 1; //임시 유저
		String user_Id = authentication.getName();
	    int cartId = Integer.parseInt((String) requestMap.get("cartId"));
	    int productId = Integer.parseInt((String) requestMap.get("productId"));
	    List<Map<String, String>> options = (List<Map<String, String>>) requestMap.get("options");
	    
	    Map<String, Object> map = createCartMap(user_Id, productId, cartId, options);
	    // 동일한 상품이 장바구니에 있는지 확인
	    int existingCartId = service.checkExistingCart(map); // 이미 있는 상품의 cartId를 리턴
	    Map<String, String> responseMap = new HashMap<>();
	    if (existingCartId > 0) {
	        // 동일한 옵션이 있는 경우 수량 증가
	        int updateResult = service.increaseQuantityByCartId(existingCartId);
	        if (updateResult == 1) {
	            // 현재 cartId 상품 삭제
	            service.deleteCartById(cartId);
	            responseMap.put("mesg", "장바구니의 기존 항목 수량 증가 완료");
	        } else {
	            responseMap.put("mesg", "수량 증가 실패");
	        }
	    } else {
	        // 동일한 옵션이 없는 경우, 옵션을 업데이트
	        int updateResult = service.updateCartOption(map);
	        responseMap.put("mesg", updateResult == 1 ? "옵션 업데이트 완료" : "옵션 업데이트 실패");
	    }

	    return responseMap;
	}
	
	//옵션 데이터를 처리 및 장바구니에 존재하는지 확인
	private Map<String, Object> createCartMap(String userId, int productId, int cartId, List<Map<String, String>> options) {
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

	    Map<String, Object> map = new HashMap<>(); 
	    map.put("user_id", userId);
	    map.put("product_Id", productId);
	    if (cartId > 0) {
	        map.put("cart_Id", cartId);
	    }
	    map.put("option_type", optionTypes.toString());
		map.put("option_name", optionNames.toString());

		return map;
	}
}
