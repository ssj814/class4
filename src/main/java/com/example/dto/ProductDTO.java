package com.example.dto;

import org.apache.ibatis.type.Alias;

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

	// 상품 등록용
	public ProductDTO(int product_category_id, String product_name, int product_price, String product_description,
			int product_inventory, String product_isactive) {
		super();
		this.product_category_id = product_category_id;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_description = product_description;
		this.product_inventory = product_inventory;
		this.product_isactive = product_isactive;
	}

	public ProductDTO() {
		super();
	}

	public ProductDTO(int product_id, int product_category_id, String product_name, int product_price,
			String product_description, String product_imagename, int product_inventory, int product_totalsales,
			int product_view, String product_createdat, String product_isactive) {
		super();
		this.product_id = product_id;
		this.product_category_id = product_category_id;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_description = product_description;
		this.product_imagename = product_imagename;
		this.product_inventory = product_inventory;
		this.product_totalsales = product_totalsales;
		this.product_view = product_view;
		this.product_createdat = product_createdat;
		this.product_isactive = product_isactive;
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

	public int getProduct_view() {
		return product_view;
	}

	public void setProduct_view(int product_view) {
		this.product_view = product_view;
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

	@Override
	public String toString() {
		return "ProductDTO [product_id=" + product_id + ", product_category_id=" + product_category_id
				+ ", product_name=" + product_name + ", product_price=" + product_price + ", product_description="
				+ product_description + ", product_imagename=" + product_imagename + ", product_inventory="
				+ product_inventory + ", product_totalsales=" + product_totalsales + ", product_view=" + product_view
				+ ", product_createdat=" + product_createdat + ", product_isactive=" + product_isactive + "]";
	}

}
