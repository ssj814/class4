package com.example.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ProductDTO;

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



}
