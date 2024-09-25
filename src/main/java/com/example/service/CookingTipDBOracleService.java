package com.example.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.CookingTipDBDao;
import com.example.dto.CookingTipListupDTO;

@Service
public class CookingTipDBOracleService implements CookingTipDBService {
	
	@Autowired
	CookingTipDBDao dao;
	
	
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public List<CookingTipListupDTO> list() {
		return dao.list(session);
	}

}
