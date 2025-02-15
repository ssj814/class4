package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("ProductReviewDTO")
public class ProductReviewDTO {
	
	private int review_id;
	private int product_id;
	private String user_id;
	private String create_date;
	private String content;
	private int rating;
	private String photos;
	private int feedback_up;
	private int feedback_down;

}
