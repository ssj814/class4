package com.example.controller.faq;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.dto.FaqDTO;
import com.example.service.faq.FaqService;



@Controller
public class FaqController {

	@Autowired
	FaqService service;
	
	
	@RequestMapping("/Faq_allList")  
	public String list(Model m) {
		List<FaqDTO> allData = service.list();
		m.addAttribute("allData", allData);
	//	System.out.println("출력"+allData);
		return "faq/faqHeader";
	}
	
}
