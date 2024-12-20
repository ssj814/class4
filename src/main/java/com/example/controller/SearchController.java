package com.example.controller;

import java.util.List;
import java.util.Map;

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
    public String search(@RequestParam("keyword") String keyword, Model m) {
		
        // 검색어를 기반으로 결과를 조회
        List<SearchResultDTO> results = searchService.searchAll(keyword);
        
        // 게시판 섹션 데이터 추가
        List<Map<String, String>> boardSections = List.of(
            Map.of("id", "1", "name", "Notice"),
            Map.of("id", "2", "name", "TrainerBoard"),
            Map.of("id", "3", "name", "Sicdan")
        );
        
        m.addAttribute("boardSections", boardSections);
        m.addAttribute("results", results);
        m.addAttribute("keyword", keyword);

        return "search/searchResult"; // 결과를 표시할 JSP 파일
    }
	
}
