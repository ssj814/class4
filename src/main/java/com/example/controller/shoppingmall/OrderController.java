package com.example.controller.shoppingmall;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class OrderController {

	@PostMapping("/orderList")
	@ResponseBody
	public String OrderList(@RequestParam String productIdList) {
		return productIdList;
	}
	
}
