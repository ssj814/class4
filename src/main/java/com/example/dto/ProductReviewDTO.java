package com.example.dto;

import java.util.Date;

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
	private int user_id;
	private Date create_date;
	private String content;
	private int rating;
	private String photos;
	private String feedback;

}
