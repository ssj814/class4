package com.example.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.example.dto.CookingTipListupDTO;

@Repository
public class CookingTipDBOracleDAO implements CookingTipDBDao {
	
	@Override
	public List<CookingTipListupDTO> list(SqlSessionTemplate session) {
		return session.selectList("CookingTipMapper.selectAll");
	}

}
