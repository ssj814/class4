package com.example.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("CartProductDTO")
public class CartProductDTO {
	private int product_id;
	private int product_category_id;
	private String product_name;
	private int product_price;
	private String product_description;
	private String product_imagename;
	private int product_inventory;
	private int product_totalsales;
	private int product_like;
	private String product_createdat;
	private String product_isactive;
	private int cart_id;
	private int user_id;
	private int quantity;
	private List<ProductOptionDTO> allOptions; // 전체 옵션 목록
	private List<CartDTO> selectedOptions; // 선택된 옵션

}
