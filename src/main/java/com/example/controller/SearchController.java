package com.example.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
        
        for (SearchResultDTO result : results) {
            result.setContent(truncateAndHighlight(result.getContent(), keyword, 50));
            result.setTitle(truncateAndHighlight(result.getTitle(), keyword, 50));
        }
        m.addAttribute("results", results);
        m.addAttribute("boardSections", boardSections);
        m.addAttribute("keyword", keyword);

        return "search/searchResult"; // 결과를 표시할 JSP 파일
    }
	
	@GetMapping("/searchDetail")
	public String searchDetail(
	        @RequestParam("category") String category,
	        @RequestParam("keyword") String keyword,
	        @RequestParam(value = "subcategory", required = false) Integer subcategory,
	        Model m) {
		
	    List<SearchResultDTO> results = searchService.searchDetail(category, keyword, subcategory);
	    
	    for (SearchResultDTO result : results) {
            result.setContent(truncateAndHighlight(result.getContent(), keyword, 50));
            result.setTitle(truncateAndHighlight(result.getTitle(), keyword, 50));
        }
	    
	    String subcategoryName = null;
	    if ("POSTS".equals(category)) { // 게시글 카테고리만 처리
	        if (subcategory != null) {
	            switch (subcategory) {
	                case 1:
	                    subcategoryName = "Notice";
	                    break;
	                case 2:
	                    subcategoryName = "TrainerBoard";
	                    break;
	                case 3:
	                    subcategoryName = "Sicdan";
	                    break;
	                default:
	                    subcategoryName = "Unknown";
	            }
	        }
	    }
	    
        m.addAttribute("results", results);
	    m.addAttribute("category", category);
	    m.addAttribute("subcategoryName", subcategoryName);
	    m.addAttribute("keyword", keyword);

	    return "search/searchDetail";
	}
	
	public String truncateAndHighlight(String content, String keyword, int maxLength) {
	    if (content == null || keyword == null || keyword.isEmpty()) {
	        return content; // 내용이나 검색어가 없으면 원래 내용 반환
	    }

	    // 첫 번째 검색어의 위치 찾기
	    int keywordPosition = content.toLowerCase().indexOf(keyword.toLowerCase());
	    
	    // 검색어가 포함되어 있지 않다면 원본 그대로 반환
	    if (keywordPosition == -1) {
	        return content.length() > maxLength ? content.substring(0, maxLength) + "..." : content;
	    }

	    // 검색어를 기준으로 잘라낼 시작과 끝 위치 계산
	    int startIndex = Math.max(0, keywordPosition - maxLength / 2);
	    int endIndex = Math.min(content.length(), startIndex + maxLength);

	    // 잘라낸 텍스트 생성
	    String truncatedContent = content.substring(startIndex, endIndex);
	    if (startIndex > 0) truncatedContent = "..." + truncatedContent; // 앞부분이 잘린 경우
	    if (endIndex < content.length()) truncatedContent += "..."; // 뒷부분이 잘린 경우

	    // 검색어 강조 처리 (대소문자 구분 없이)
	    return truncatedContent.replaceAll("(?i)(" + Pattern.quote(keyword) + ")", "<mark>$1</mark>");
	}

}
