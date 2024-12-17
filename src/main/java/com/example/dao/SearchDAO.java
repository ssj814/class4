package com.example.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.SearchResultDTO;

@Repository
public class SearchDAO {

	@Autowired
	SqlSessionTemplate session;
	
	public List<SearchResultDTO> searchAll(String keyword) {
		return session.selectList("SearchMapper.selectAll", keyword);
	}

}
