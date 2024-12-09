package com.example.service.shoppingmall;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.shoppingmall.ProductDAO;
import com.example.dto.ProductCategoryDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.dto.ProductRecentDTO;

@Service
public class ProductService {
	
	@Autowired
	ProductDAO dao;
	
	public List<ProductDTO> selectProductMainList(String order) {
		return dao.selectProductMainList(order);
	}//selectProductMainList() - 메인에서 보여질 상품들(전체 선택, 조회수 정렬)
	
	public ProductDTO selectDetailproduct(int productId) {
		return dao.selectDetailproduct(productId);
	}//selectDetailproduct() - 상품 아이디에 따른 상품 하나

	public List<ProductDTO> selectProductList(Map<String, Object> dataMap, RowBounds bounds) {
		return dao.selectProductList(dataMap,bounds);
	}//selectProductList() - 카테고리, 상품이름, 정렬에 따른 상품들

	public int selectProductListCount(Map<String, String> selectMap) {
		return dao.selectProductListCount(selectMap);
	}//selectProductListCount() - 카테고리, 상품이름 에 따른 상품 count(*)
	
	public int addViewCount(int productId) {
		return dao.addViewCount(productId);
	}//addViewCount() - 조회수++
	
	public int maxProductId() {
		return dao.maxProductId();
	}//maxProductId() - 상품 아이디 최대값

	public int productDelete(int productId) { //deleteProduct로 변환
		return dao.productDelete(productId);
	}//productDelete() - 상품 삭제
	
	public int insertProduct(ProductDTO dto) { 
		return dao.insertProduct(dto);
	}//insertProduct() - 상품 등록
	
	public int updateProduct(ProductDTO dto) {
		return dao.updateProduct(dto);
	}//updateProduct() - 상품정보 update

	public int insertProductOption(ProductOptionDTO option) {
		 return dao.insertProductOption(option);
	}

	public List<ProductOptionDTO> selectProductOptions(int productId) {
		return dao.selectProductOptions(productId);
	}

	public void updateProductOption(ProductOptionDTO option) {
		dao.updateProductOption(option);
	}

	public void deleteProductOption(int optionId) {
		dao.deleteProductOption(optionId);
	}

	public List<ProductCategoryDTO> selectCategoryList() {
		return dao.selectCategoryList();
	}

	public ProductRecentDTO checkRecentView(Map<String, Object> data) {
		return dao.checkRecentView(data);
	}

	public void insertRecentView(Map<String, Object> data) {
		dao.insertRecentView(data);
	}

	public void updateRecentView(Map<String, Object> data) {
		dao.updateRecentView(data);
	}

	public List<ProductRecentDTO> getRecentProducts(String user_id) {
		return dao.getRecentProducts(user_id);
	}

	public void deleteRecentView(String user_id) {
		dao.deleteRecentView(user_id);
	}

	public void updateProductStock(ProductDTO dto) {
		dao.updateProductStock(dto);
	}
	
}
