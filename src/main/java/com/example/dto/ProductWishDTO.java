package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("ProductWishDTO")
public class ProductWishDTO {
		private int wish_id;
		private String user_id;
		private int product_id;
		private String option_type;
		private String option_name;
}
