package com.example.controller.sicdan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class CookingTipController {



	/*
	 * @RequestMapping("/cookingTip") public String list2(Model m) { return
	 * "cookingTip/list2"; }
	 */
	

	@RequestMapping("/cookingTip_cooking")
	public String list1(Model m) {
		return "cookingTip/cookingForm";
	}

	@RequestMapping("/cookingTip_page")
	public String list2(String num, Model m) {
		return "cookingTip/"+num;
	}

}
