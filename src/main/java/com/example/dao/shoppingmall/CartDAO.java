package com.example.dao.shoppingmall;

import java.util.HashMap;
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
		return session.selectList("CartMapper.selectCart", user_id);
	}

	public int cartCheck(Map<String, Object> map) {
		return session.selectOne("CartMapper.cartCheck", map);
	}

	public int cartInsert(Map<String, Object> map) {
		return session.insert("CartMapper.cartInsert", map);
	}

	public void cartUpdate(CartDTO dto) {
		session.update("CartMapper.cartUpdate", dto);
	}

	public void cartDelete(CartDTO dto) {
		session.delete("CartMapper.cartDelete", dto);
	}

	public int increaseQuantity(Map<String, Object> map) {
		return session.update("CartMapper.increaseQuantity", map);
	}

	public List<CartDTO> selectProductOptions(int product_id, int user_id) {
		Map<String, Object> data = new HashMap<>();
		data.put("product_id", product_id);
		data.put("user_id", user_id);
		return session.selectList("CartMapper.selectProductOptions", data);
	}

	public int updateCartOption(Map<String, Object> map) {
		return session.update("CartMapper.updateCartOption",map);
	}

	public int checkExistingCart(Map<String, Object> map) {
		Integer existingCartId = session.selectOne("CartMapper.checkExistingCart", map);
	    return existingCartId != null ? existingCartId : 0;
	}

	public int increaseQuantityByCartId(int cart_id) {
		return session.update("CartMapper.increaseQuantityByCartId",cart_id);
	}

	public void deleteCartById(int cart_id) {
		session.delete("CartMapper.deleteCartById", cart_id);
	}

}
