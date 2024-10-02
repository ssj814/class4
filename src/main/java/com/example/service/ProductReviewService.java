package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.ProductReviewDAO;
import com.example.dto.ProductReviewDTO;

@Service
public class ProductReviewService {
	
	@Autowired
	ProductReviewDAO dao;

	public int insertReview(ProductReviewDTO productReviewDTO) {
		return dao.insertReview(productReviewDTO); 
	}
	


}
