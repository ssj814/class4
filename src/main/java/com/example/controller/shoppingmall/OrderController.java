package com.example.controller.shoppingmall;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.CartDTO;
import com.example.dto.ProductDTO;
import com.example.entity.CardInfo;
import com.example.entity.Order;
import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.service.shoppingmall.CardInfoService;
import com.example.service.shoppingmall.CartService;
import com.example.service.shoppingmall.OrderService;
import com.example.service.shoppingmall.ProductService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {
	
	private final OrderService orderService;
	private final ProductService pService;
	private final CartService cService;
	private final CardInfoService cardInfoService;
	
	private final UserRepository userRepository;
	

	@PostMapping("/orderpayment")
	public String orderPayment(@RequestParam String[] cartIdList, Model m) {
		System.out.println("결제 정보 입력 페이지 이동");
		List<CartDTO> cartList = new ArrayList<>();
		List<ProductDTO> productList = new ArrayList<>();

		for (var i = 0; i < cartIdList.length; i++) {
			String cartId = cartIdList[i];
			if (cartId == null || cartId.trim().isEmpty()) {
				System.out.println("빈 cartId 발견, 무시합니다.");
				continue; // 빈 문자열은 무시
			}
			int cart_id = Integer.parseInt(cartId);
			CartDTO cDTO = cService.selectByCartId(cart_id);
			cartList.add(cDTO);
			ProductDTO pDTO = pService.selectDetailproduct(cDTO.getProduct_id());
			productList.add(pDTO);
		}
		List<CardInfo> cardInfoList = cardInfoService.getAllCardInfo();
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String user_id = authentication.getName();
		// UserRepository를 통해 User 엔티티 가져오기
		User user = userRepository.findByUserid(user_id).orElse(null);
		System.out.println("user : "+user);
		if (user != null) {
			m.addAttribute("user", user); // 사용자 정보를 모델에 추가
		} else {
			System.out.println("사용자 정보를 찾을 수 없습니다.");
		}
		
    	m.addAttribute("cardInfoList", cardInfoList);
    	m.addAttribute("cartList", cartList);
    	m.addAttribute("productList", productList);
		return "shoppingMall/orderPayment";
	}

	// 결제 정보 저장 후 성공 페이지로 리다이렉트
	@PostMapping("/order")
	public String createOrder(Order order) {
		orderService.saveOrder(order);
		return "redirect:/ordersuccess";
	}

	// 결제 성공 페이지
	@GetMapping("/ordersuccess")
	public String orderSuccess() {
		return "shoppingMall/ordersuccess";
	}

}
