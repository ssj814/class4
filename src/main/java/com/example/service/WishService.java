package com.example.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.WishDAO;

@Service
public class WishService {
	
	@Autowired
	WishDAO dao;

	public List<Integer> selectWishList(int user_id) {
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
