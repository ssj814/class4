package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("ProductCategoryDTO")
public class ProductCategoryDTO {
	private int product_category_id;
	private String product_category_name;
	private String product_category_eng_name;
}
