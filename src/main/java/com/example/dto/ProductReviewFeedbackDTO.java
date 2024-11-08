package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("ProductReviewFeedbackDTO")
public class ProductReviewFeedbackDTO {
	
	private String user_id;
	private int review_id;
	private String feedback;

}
