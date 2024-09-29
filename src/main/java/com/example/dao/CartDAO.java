package com.example.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.CartDTO;
import com.example.dto.CartProductDTO;

@Repository
public class CartDAO {
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<CartProductDTO> selectCart(int user_id) {
		return session.selectList("CartMapper.selectCart",user_id);
	}
	
	public int cartCheck(Map<String, Object> map) {
		return session.selectOne("CartMapper.cartCheck",map);
	}
	
	public int cartInsert(Map<String, Object> map) {
		return session.insert("CartMapper.cartInsert",map);
	}

	public void cartUpdate(CartDTO dto) {
		session.update("CartMapper.cartUpdate",dto);
	}

	public void cartDelete(CartDTO dto) {
		session.delete("CartMapper.cartDelete", dto);
	}

	public int increaseQuantity(Map<String, Object> map) {
		return session.update("CartMapper.increaseQuantity", map);
	}

	

}
