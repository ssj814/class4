package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.SearchResultDTO;
import com.example.service.SearchService;

@Controller
public class SearchController {

	@Autowired
    private SearchService searchService;
	
	@GetMapping("/searchAll")
    public String search(@RequestParam("keyword") String keyword, Model model) {
		
		System.out.println("keyword : "+keyword);
        // 검색어를 기반으로 결과를 조회
        List<SearchResultDTO> results = searchService.searchAll(keyword);
        // 모델에 검색결과 추가
        model.addAttribute("results", results);
        model.addAttribute("keyword", keyword);

        return "search/searchResult"; // 결과를 표시할 JSP 파일
    }
	
}
