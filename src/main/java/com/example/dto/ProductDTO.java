package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("ProductDTO")
public class ProductDTO {

	private int product_id;
	private int product_category_id;
	private String product_name;
	private int product_price;
	private String product_description;
	private String product_imagename;
	private int product_inventory;
	private int product_totalsales; // 총판매량
	private int product_view;
	private String product_createdat;
	private String product_isactive; // product_status로 변경

}