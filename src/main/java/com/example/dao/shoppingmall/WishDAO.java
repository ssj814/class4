package com.example.dao.shoppingmall;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ProductWishDTO;


@Repository
public class WishDAO {
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<ProductWishDTO> selectWishList(int user_id) {
		return session.selectList("WishMapper.selectWishList",user_id);
	}
	
	public int checkWish(Map<String, Object> map) {
		return session.selectOne("WishMapper.checkWish",map);
	}
	
	public int wishInsert(Map<String, Object> map) {
		return session.insert("WishMapper.wishInsert",map);
	}

	public void wishDelete(Map<String, Object> map) {
		session.delete("WishMapper.wishDelete",map);
	}

	public int AllwishDelete(Map<String, Object> map) {
		return session.delete("WishMapper.AllwishDelete",map);
	}

}
