package com.example.controller.shoppingmall;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.entity.Order;
import com.example.service.shoppingmall.OrderService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    
    @PostMapping("/orderpayment")
    public String orderPayment(@RequestParam String productIdList, Model m) {
    	System.out.println("결제 정보 입력 페이지 이동");
    	System.out.println(productIdList);
//    	m.addAttribute("orderItems", productIdList);
    	return "shoppingMall/orderpayment";
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
