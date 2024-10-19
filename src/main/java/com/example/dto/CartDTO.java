package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("CartDTO")
public class CartDTO {

	private int cart_id;
	private int user_id;
	private int product_id;
	private int quantity;
	private String option_type;
	private String option_name;

	public int getCart_id() {
		return cart_id;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getOption_type() {
		return option_type;
	}

	public void setOption_type(String option_type) {
		this.option_type = option_type;
	}

	public String getOption_name() {
		return option_name;
	}

	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}

	public CartDTO(int cart_id, int user_id, int product_id, int quantity, String option_type, String option_name) {
		super();
		this.cart_id = cart_id;
		this.user_id = user_id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.option_type = option_type;
		this.option_name = option_name;
	}

	public CartDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "CartDTO [cart_id=" + cart_id + ", user_id=" + user_id + ", product_id=" + product_id + ", quantity="
				+ quantity + ", option_type=" + option_type + ", option_name=" + option_name + "]";
	}

}
