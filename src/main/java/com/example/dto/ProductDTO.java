package com.example.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
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
	private int product_totalsales; //총판매량
	private int product_view;	
	private String product_createdat;
	private String product_isactive; //product_status로 변경
	
	//상품 등록용
	public ProductDTO(int product_category_id, String product_name, int product_price,
			String product_description, int product_inventory, String product_isactive) {
		super();
		this.product_category_id = product_category_id;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_description = product_description;
		this.product_inventory = product_inventory;
		this.product_isactive = product_isactive;
	}
	
}
