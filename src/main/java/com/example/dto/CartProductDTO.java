package com.example.dto;

import org.apache.ibatis.type.Alias;

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
	
	public CartProductDTO(int product_id, int product_category_id, String product_name, int product_price,
			String product_description, String product_imagename, int product_inventory, int product_totalsales,
			int product_like, String product_createdat, String product_isactive, int cart_id, int user_id,
			int quantity) {
		super();
		this.product_id = product_id;
		this.product_category_id = product_category_id;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_description = product_description;
		this.product_imagename = product_imagename;
		this.product_inventory = product_inventory;
		this.product_totalsales = product_totalsales;
		this.product_like = product_like;
		this.product_createdat = product_createdat;
		this.product_isactive = product_isactive;
		this.cart_id = cart_id;
		this.user_id = user_id;
		this.quantity = quantity;
	}
	public CartProductDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getProduct_category_id() {
		return product_category_id;
	}
	public void setProduct_category_id(int product_category_id) {
		this.product_category_id = product_category_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getProduct_description() {
		return product_description;
	}
	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}
	public String getProduct_imagename() {
		return product_imagename;
	}
	public void setProduct_imagename(String product_imagename) {
		this.product_imagename = product_imagename;
	}
	public int getProduct_inventory() {
		return product_inventory;
	}
	public void setProduct_inventory(int product_inventory) {
		this.product_inventory = product_inventory;
	}
	public int getProduct_totalsales() {
		return product_totalsales;
	}
	public void setProduct_totalsales(int product_totalsales) {
		this.product_totalsales = product_totalsales;
	}
	public int getProduct_like() {
		return product_like;
	}
	public void setProduct_like(int product_like) {
		this.product_like = product_like;
	}
	public String getProduct_createdat() {
		return product_createdat;
	}
	public void setProduct_createdat(String product_createdat) {
		this.product_createdat = product_createdat;
	}
	public String getProduct_isactive() {
		return product_isactive;
	}
	public void setProduct_isactive(String product_isactive) {
		this.product_isactive = product_isactive;
	}
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
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return "CartProductDTO [product_id=" + product_id + ", product_category_id=" + product_category_id
				+ ", product_name=" + product_name + ", product_price=" + product_price + ", product_description="
				+ product_description + ", product_imagename=" + product_imagename + ", product_inventory="
				+ product_inventory + ", product_totalsales=" + product_totalsales + ", product_like=" + product_like
				+ ", product_createdat=" + product_createdat + ", product_isactive=" + product_isactive + ", cart_id="
				+ cart_id + ", user_id=" + user_id + ", quantity=" + quantity + "]";
	}
	
	
	
	
	
}
