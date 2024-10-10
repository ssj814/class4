package com.example.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ProductReviewDTO;
import com.example.dto.ProductReviewFeedbackDTO;

@Repository
public class ProductReviewDAO {
	
	@Autowired
	SqlSessionTemplate session;

	public int insertReview(ProductReviewDTO productReviewDTO) {
		return session.insert("ProductReviewMapper.insertReview",productReviewDTO);
	}

	public List<ProductReviewDTO> selectReviewList(int productId, RowBounds bounds) {
		return session.selectList("ProductReviewMapper.selectReviewList",productId,bounds);
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

	public int updateReviewFeedback(Map<String, Object> map) {
		return session.update("ProductReviewMapper.updateReviewFeedback",map);
	}
	
	public List<ProductReviewFeedbackDTO> selectUserFeedback(Map<String, Object> map) {
		return session.selectList("ProductReviewMapper.selectUserFeedback",map);
	}
	
	public int checkUserFeedback(Map<String, Object> map) {
		return session.selectOne("ProductReviewMapper.checkUserFeedback",map);
	}

	public int updateUserFeedback(Map<String, Object> map) {
		return session.update("ProductReviewMapper.updateUserFeedback",map);
	}

	public int insertUserFeedback(Map<String, Object> map) {
		return session.insert("ProductReviewMapper.insertUserFeedback",map);
	}


}
