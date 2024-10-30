package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("ProductRecentDTO")
public class ProductRecentDTO {
	private int product_id;
	private String user_id;
	private String viewDate;
}
