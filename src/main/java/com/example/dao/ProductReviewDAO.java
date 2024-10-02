package com.example.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductReviewDAO {
	
	@Autowired
	SqlSessionTemplate session;

}
