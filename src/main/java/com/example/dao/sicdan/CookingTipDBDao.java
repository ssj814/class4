package com.example.dao.sicdan;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.example.dto.CookingTipListupDTO;

public interface CookingTipDBDao {
	public abstract List<CookingTipListupDTO> list(SqlSessionTemplate session);
}
