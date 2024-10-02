package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.ProductReviewDAO;

@Service
public class ProductReviewService {
	
	@Autowired
	ProductReviewDAO productReviewDao;

}
