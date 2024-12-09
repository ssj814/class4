package com.example.dto;

import java.util.List;
import java.util.Map;

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
	private int product_totalsales;
	private int product_like;
	private String product_createdat;
	private String product_isactive;
	private int cart_id;
	private String user_id;
	private int quantity;
	private Map<String, String> groupedOptions; // 옵션 타입별 그룹화된 데이터
	private List<CartDTO> selectedOptions; // 선택된 옵션
	private boolean hasOptions; // 옵션 유무
	private int stock; // 옵션 없는 상품의 재고
}
