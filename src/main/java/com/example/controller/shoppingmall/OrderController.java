package com.example.controller.shoppingmall;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
import org.springframework.web.servlet.view.RedirectView;

import com.example.dto.CartDTO;
import com.example.dto.OrderRequestDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
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
	    System.out.println("결제 정보 입력 페이지 이동 (여러 상품)");

	    System.out.println("cartIdList :"+cartIdList.toString());
	    List<CartDTO> cartList = new ArrayList<>();
	    List<ProductDTO> productList = new ArrayList<>();

	    for (String cartId : cartIdList) {
	        if (cartId == null || cartId.trim().isEmpty()) {
	            continue;
	        }
	        int cart_id = Integer.parseInt(cartId);
	        CartDTO cDTO = cService.selectByCartId(cart_id);
	        cartList.add(cDTO);
	        ProductDTO pDTO = pService.selectDetailproduct(cDTO.getProduct_id());
	        productList.add(pDTO);
	    }
	    System.out.println("cartList :"+cartList);
	    addCommonAttributes(m);
	    m.addAttribute("cartList", cartList);
	    m.addAttribute("productList", productList);

	    return "shoppingMall/orderPayment";
	}
	
	@PostMapping("/user/singleOrderPayment")
	public String singleOrderPayment(
	    @RequestParam("productId") int productId,
	    @RequestParam("quantity") int quantity,
	    @RequestParam(value = "optionType", required = false) List<String> optionTypes,
	    @RequestParam Map<String, String> params, // 각 옵션 이름을 담기 위한 Map
	    Model m) {

	    System.out.println("결제 정보 입력 페이지 이동 (단일 상품)"+ params);
	    System.out.println("optionTypes :"+optionTypes);

	    ProductDTO product = pService.selectDetailproduct(productId);
	    if (product == null) {
	        return "errorPage"; // 예외 처리
	    }

	    // 옵션 데이터 추출
	    List<Map<String, String>> options = new ArrayList<>();
	    if (optionTypes != null) {
	        for (String optionType : optionTypes) {
	            Map<String, String> option = new HashMap<>();
	            option.put("type", optionType);
	            option.put("name", params.get("optionName_" + optionType)); // optionType에 맞는 옵션 이름 가져오기
	            options.add(option);
	        }
	    }

	    // 모델에 데이터 추가
	    addCommonAttributes(m);
	    m.addAttribute("product", product);
	    m.addAttribute("quantity", quantity);
	    m.addAttribute("options", options);

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

	    // Save OrderMain
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

	    // Save OrderPayment
	    OrderPayment orderPayment = new OrderPayment();
	    orderPayment.setOrderId(savedOrderMain.getOrderId());
	    orderPayment.setCardType(orderRequest.getCardType());
	    orderPayment.setInstallmentType(orderRequest.getInstallmentType());
	    orderPayment.setPaymentDate(Date.valueOf(LocalDate.now()));
	    orderService.saveOrderPayment(orderPayment);

	    // Save OrderProduct & options
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

	        List<ProductOptionDTO> rawOptions = pService.selectProductOptions(productIds.get(i).intValue());
	        List<String> types = optionTypes.get(i);
	        List<String> names = optionNames.get(i);
	        
	        if (rawOptions != null && rawOptions.size() > 0) {
	        	System.out.println("옵션 상품 재고 변경");
	    	    Map<String, List<ProductOptionDTO>> groupedOptions = rawOptions.stream()
	    	            .collect(Collectors.groupingBy(ProductOptionDTO::getOption_type));
	    	    
		        for (int j = 0; j < types.size(); j++) {
		            OrderProductOption orderProductOption = new OrderProductOption();
		            orderProductOption.setOrderProductId(savedOrderProduct.getOrderProductId());
		            orderProductOption.setOptionType(types.get(j));
		            orderProductOption.setOptionName(names.get(j));
		            orderService.saveOrderProductOption(orderProductOption);
		            
		            // 옵션 상품 재고 처리
		            List<ProductOptionDTO> ProductOptionsByType = groupedOptions.get(orderProductOption.getOptionType());
		            for (ProductOptionDTO option : ProductOptionsByType) {
		                if (option.getOption_name().equals(orderProductOption.getOptionName())) {
		                	int updateProductOptionStock = option.getStock() - quantities.get(i);
		                	option.setStock(updateProductOptionStock);
		                	pService.updateProductOption(option);
		                    break;
		                }
		            }
		        }
	        } else {
	        	// 옵션 없는 상품 처리
	        	System.out.println("옵션 없는 상품 재고 변경");
	        	ProductDTO product = pService.selectDetailproduct(productIds.get(i).intValue());
	        	int preProductStock = product.getProduct_stock();
			    int updateProductStock = preProductStock - orderRequest.getQuantities().get(i).intValue();
			    product.setProduct_stock(updateProductStock);
			    pService.updateProductStock(product);
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

	private void addCommonAttributes(Model m) {
	    List<CardInfo> cardInfoList = cardInfoService.getAllCardInfo();

	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String userId = authentication.getName();
	    User user = userRepository.findByUserid(userId).orElse(null);

	    if (user != null) {
	        m.addAttribute("user", user);
	    } else {
	        System.out.println("사용자 정보를 찾을 수 없습니다.");
	    }

	    m.addAttribute("cardInfoList", cardInfoList);
	}
}
