package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("ProductOptionDTO")
public class ProductOptionDTO {
	private int option_id;
	private int product_id;
	private String option_type;
	private String option_name;
	private int stock;
	private String option_name_with_stock;
}
