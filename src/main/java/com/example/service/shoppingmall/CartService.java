package com.example.service.shoppingmall;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.shoppingmall.CartDAO;
import com.example.dto.CartDTO;
import com.example.dto.CartProductDTO;
import com.example.dto.ProductOptionDTO;

@Service
public class CartService {
	
	@Autowired
	CartDAO dao;

	public List<CartProductDTO> selectCart(int user_id) {
		return dao.selectCart(user_id);
	}

	public int cartCheck(Map<String, Object> map) {
		return dao.cartCheck(map);
	}

	public int cartInsert(Map<String, Object> map) {
		return dao.cartInsert(map);
	}

	public void cartUpdate(CartDTO dto) {
		dao.cartUpdate(dto);
	}

	public void cartDelete(CartDTO dto) {
		dao.cartDelete(dto);
	}

	public int increaseQuantity(Map<String, Object> map) {
		return dao.increaseQuantity(map);
	}

	public List<CartDTO> selectProductOptions(int product_id, int user_id) {
		return dao.selectProductOptions(product_id,user_id);
	}

	public int updateCartOption(Map<String, Object> map) {
		return dao.updateCartOption(map);
	}

	public int checkExistingCart(Map<String, Object> map) {
		return dao.checkExistingCart(map);
	}

	public int increaseQuantityByCartId(int cart_id) {
		return dao.increaseQuantityByCartId(cart_id);
	}

	public void deleteCartById(int cart_id) {
		dao.deleteCartById(cart_id);
	}

		
	
}
