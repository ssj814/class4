package com.example.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.SearchDAO;
import com.example.dto.SearchResultDTO;

@Service
public class SearchService {

	@Autowired
	SearchDAO dao;
	
	public List<SearchResultDTO> searchAll(String keyword) {
        return dao.searchAll(keyword);
    }

	public List<SearchResultDTO> searchDetail(String category, String keyword, Integer subcategory) {
		Map<String, Object> params = new HashMap<>();
	    params.put("category", category);
	    params.put("keyword", keyword);
	    params.put("subcategory", subcategory);
		return dao.searchDetail(params);
	}
	
}
