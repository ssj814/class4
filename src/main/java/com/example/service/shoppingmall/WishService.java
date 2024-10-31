package com.example.service.shoppingmall;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.shoppingmall.WishDAO;
import com.example.dto.ProductWishDTO;

@Service
public class WishService {
	
	@Autowired
	WishDAO dao;

	public List<ProductWishDTO> selectWishList(int user_id) {
		return dao.selectWishList(user_id);
	}

	public int checkWish(Map<String, Object> map) {
		return dao.checkWish(map);
	}

	public int wishInsert(Map<String, Object> map) {
		return dao.wishInsert(map);
	}

	public void wishDelete(Map<String, Object> map) {
		dao.wishDelete(map);
	}

	public int AllwishDelete(Map<String, Object> map) {
		return dao.AllwishDelete(map);
	}

		
	
}
