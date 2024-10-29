package com.example.controller.sicdan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.dto.CookingTipListupDTO;
import com.example.service.sicdan.CookingTipDBService;

@Controller
public class CookingTipController {
	@Autowired
	CookingTipDBService service;
	
	
	@RequestMapping("/cookingTip_list")  
	public String list(Model m) {
		List<CookingTipListupDTO> allData = service.list();
		m.addAttribute("allData", allData);
		return "cookingTip/list";
	}
	
	
	
	

	@RequestMapping("/cookingTip")
	public String list2(Model m) {
		return "cookingTip/list2";
	}

	

	@RequestMapping("/cookingTip_cooking")
	public String list1(Model m) {
		return "cookingTip/cooking";
	}

	@RequestMapping("/cookingTip_page")
	public String list2(String num, Model m) {
		return "cookingTip/"+num;
	}

}
