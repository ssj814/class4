package com.example.controller.shoppingmall;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.CartDTO;
import com.example.dto.OrderRequestDTO;
import com.example.dto.ProductDTO;
import com.example.entity.CardInfo;
import com.example.entity.OrderMain;
import com.example.entity.OrderPayment;
import com.example.entity.OrderProduct;
import com.example.entity.OrderProductOption;
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
	

	@PostMapping("/user/orderpayment")
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
	@PostMapping("/user/order")
	@ResponseBody
	@Transactional
	public Map<String, Object> createOrder(@RequestBody OrderRequestDTO orderRequest) {

	    // 현재 사용자 ID 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String userId = authentication.getName();

	    // Step 1: Save OrderMain
	    OrderMain orderMain = new OrderMain();
	    orderMain.setUserId(userId);
	    orderMain.setOrderDate(LocalDate.now());
	    orderMain.setContact(orderRequest.getContact());
	    orderMain.setZipcode(orderRequest.getZipcode());
	    orderMain.setAddress(orderRequest.getBasicAddress());
	    orderMain.setAddressDetail(orderRequest.getDetailAddress());
	    orderMain.setPaymentMethod(orderRequest.getPaymentMethod());
	    orderMain.setTotalAmount(BigDecimal.valueOf(orderRequest.getTotalAmount()));
	    OrderMain savedOrderMain = orderService.saveOrderMain(orderMain);

	    // Step 2: Save OrderPayment
	    OrderPayment orderPayment = new OrderPayment();
	    orderPayment.setOrderId(savedOrderMain.getOrderId());
	    orderPayment.setCardType(orderRequest.getCardType());
	    orderPayment.setInstallmentType(orderRequest.getInstallmentType());
	    orderPayment.setPaymentDate(Date.valueOf(LocalDate.now()));
	    orderService.saveOrderPayment(orderPayment);

	    // Step 3: Save OrderProducts and their options
	    List<Long> productIds = orderRequest.getProductIds();
	    List<Integer> quantities = orderRequest.getQuantities();
	    List<Double> individualPrices = orderRequest.getIndividualPrices();
	    List<List<String>> optionTypes = orderRequest.getOptionTypes();
	    List<List<String>> optionNames = orderRequest.getOptionNames();

	    for (int i = 0; i < productIds.size(); i++) {
	        OrderProduct orderProduct = new OrderProduct();
	        orderProduct.setOrderId(savedOrderMain.getOrderId());
	        orderProduct.setProductId(productIds.get(i));
	        orderProduct.setQuantity(quantities.get(i));
	        orderProduct.setPrice(BigDecimal.valueOf(individualPrices.get(i)));
	        OrderProduct savedOrderProduct = orderService.saveOrderProduct(orderProduct);

	        List<String> types = optionTypes.get(i);
	        List<String> names = optionNames.get(i);
	        for (int j = 0; j < types.size(); j++) {
	            OrderProductOption orderProductOption = new OrderProductOption();
	            orderProductOption.setOrderProductId(savedOrderProduct.getOrderProductId());
	            orderProductOption.setOptionType(types.get(j));
	            orderProductOption.setOptionName(names.get(j));
	            orderService.saveOrderProductOption(orderProductOption);
	        }
	    }
	 // 반환할 orderId를 JSON 형식으로 감싸서 반환
	    Map<String, Object> response = new HashMap<>();
	    response.put("orderId", savedOrderMain.getOrderId());
	    response.put("message", "결제가 완료되었습니다.");
	    return response;
	}
	
	// 결제 성공 페이지
	@GetMapping("/user/orderSuccess")
	public String orderSuccess(@RequestParam("orderId") Long orderId, Model model) {
		OrderMain orderMain = orderService.findOrderMainById(orderId);
		OrderPayment orderPay = orderService.findOrderPaymentById(orderId);
		List<CardInfo> cardInfoList = cardInfoService.getAllCardInfo();
		
		model.addAttribute("cardInfoList", cardInfoList);
	    model.addAttribute("orderPay", orderPay);
	    model.addAttribute("orderMain", orderMain);
		return "shoppingMall/orderSuccess";
	}

}
