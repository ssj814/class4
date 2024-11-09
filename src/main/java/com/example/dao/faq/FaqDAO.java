package com.example.dao.faq;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.FaqDTO;

@Repository
public class FaqDAO {
	
	@Autowired
	SqlSessionTemplate session;

	public List<FaqDTO> list() {
		return session.selectList("FaqMapper.faqList");
	}
	
	
}
