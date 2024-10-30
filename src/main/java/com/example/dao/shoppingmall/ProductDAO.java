package com.example.dao.shoppingmall;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ProductCategoryDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.dto.ProductRecentDTO;

@Repository
public class ProductDAO {
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<ProductDTO> selectProductMainList() {
		return session.selectList("ProductMapper.selectProductMainList");
	}
	
	public ProductDTO selectDetailproduct(int productId) {
		return session.selectOne("ProductMapper.selectDetailproduct",productId);
	}

	public List<ProductDTO> selectProductList(Map<String, Object> map, RowBounds bounds) {
		return session.selectList("ProductMapper.selectProductList",map,bounds);
	}

	public int selectProductListCount(Map<String, String> selectMap) {
		return session.selectOne("ProductMapper.selectProductListCount",selectMap);
	}

	public int addViewCount(int productId) {
		return session.update("ProductMapper.addViewCount",productId);
	}
	
	public int maxProductId() {
		return session.selectOne("ProductMapper.maxProductId");
	}
	
	public int productDelete(int productId) {
		return session.delete("ProductMapper.productDelete",productId);
	}
	
	public int insertProduct(ProductDTO dto) {
		return session.insert("ProductMapper.insertProduct",dto);
	}

	public int updateProduct(ProductDTO dto) {
		return session.update("ProductMapper.updateProduct", dto);
	}

	public int insertProductOption(ProductOptionDTO option) {
		return session.insert("ProductMapper.insertProductOption", option);
	}

	public List<ProductOptionDTO> selectProductOptions(int productId) {
		return session.selectList("ProductMapper.selectProductOptions", productId);
	}

	public void updateProductOption(ProductOptionDTO option) {
		session.update("ProductMapper.updateProductOption", option);
	}

	public void deleteProductOption(int optionId) {
		session.delete("ProductMapper.deleteProductOption", optionId);		
	}

	public List<ProductCategoryDTO> selectCategoryList() {
		return session.selectList("ProductMapper.selectCategoryList");
	}

	public ProductRecentDTO checkRecentView(Map<String, Object> data) {
		return session.selectOne("ProductMapper.checkRecentView", data);
	}

	public void insertRecentView(Map<String, Object> data) {
		session.insert("ProductMapper.insertRecentView",data);
	}

	public void updateRecentView(Map<String, Object> data) {
		session.insert("ProductMapper.updateRecentView",data);
	}

	public List<ProductRecentDTO> getRecentProducts(String user_id) {
		return session.selectList("ProductMapper.getRecentProducts", user_id);
	}

	public void deleteRecentView(String user_id) {
		session.delete("ProductMapper.deleteRecentView", user_id);
	}



}
