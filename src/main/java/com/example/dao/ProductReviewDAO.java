package com.example.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ProductReviewDTO;

@Repository
public class ProductReviewDAO {
	
	@Autowired
	SqlSessionTemplate session;

	public int insertReview(ProductReviewDTO productReviewDTO) {
		System.out.println(productReviewDTO);
		return session.insert("ProductReviewMapper.insertReview",productReviewDTO);
	}

}
