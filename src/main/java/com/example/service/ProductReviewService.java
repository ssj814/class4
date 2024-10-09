package com.example.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.ProductReviewDAO;
import com.example.dto.ProductReviewDTO;
import com.example.dto.ProductReviewFeedbackDTO;

@Service
public class ProductReviewService {
	
	@Autowired
	ProductReviewDAO dao;

	public int insertReview(ProductReviewDTO productReviewDTO) {
		return dao.insertReview(productReviewDTO); 
	}

	public List<ProductReviewDTO> selectReviewList(int productId) {
		return dao.selectReviewList(productId); 
	}

	public int deleteReview(int reviewId) {
		return dao.deleteReview(reviewId); 
	}

	public ProductReviewDTO selectReview(int reviewId) {
		return dao.selectReview(reviewId); 
	}

	public int updateReview(ProductReviewDTO productReviewDTO) {
		return dao.updateReview(productReviewDTO); 
	}

	public int updateReviewFeedback(Map<String, Object> map) {
		return dao.updateReviewFeedback(map); 
	}
	
	public int addReviewFeedback(Map<String, Object> map) {
		return dao.addReviewFeedback(map); 
	}
	
	public int checkUserFeedback(Map<String, Object> map) {
		return dao.checkUserFeedback(map); 
	}

	public int updateUserFeedback(Map<String, Object> map) {
		return dao.updateUserFeedback(map); 
	}

	public int insertUserFeedback(Map<String, Object> map) {
		return dao.insertUserFeedback(map); 
	}




	


}
