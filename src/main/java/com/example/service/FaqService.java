package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.FaqDAO;
import com.example.dto.FaqDTO;

@Service
public class FaqService {
	
	@Autowired
	FaqDAO dao;

	public List<FaqDTO> list() {
		return dao.list();
	}

	

}
