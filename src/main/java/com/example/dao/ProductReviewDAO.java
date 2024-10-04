package com.example.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ProductReviewDTO;

@Repository
public class ProductReviewDAO {
	
	@Autowired
	SqlSessionTemplate session;

	public int insertReview(ProductReviewDTO productReviewDTO) {
		return session.insert("ProductReviewMapper.insertReview",productReviewDTO);
	}

	public List<ProductReviewDTO> selectReviewList(int productId) {
		return session.selectList("ProductReviewMapper.selectReviewList",productId);
	}

	public int deleteReview(int reviewId) {
		return session.delete("ProductReviewMapper.deleteReview",reviewId);
	}

	public ProductReviewDTO selectReview(int reviewId) {
		return session.selectOne("ProductReviewMapper.selectReview",reviewId);
	}

	public int updateReview(ProductReviewDTO productReviewDTO) {
		return session.update("ProductReviewMapper.updateReview",productReviewDTO);
	}

}
