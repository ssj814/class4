package com.example.service;

import java.util.List;

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
	
}
