package com.example.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ContestPost;





@Repository
public class ContestPostDAO {
@Autowired
SqlSessionTemplate session;
	public List<ContestPost> getPostsByPage(Map<String, Integer> params) {
		// TODO Auto-generated method stub
		return session.selectList("getPostsByPage", params);
	}
	public int getTotalPosts() {
		// TODO Auto-generated method stub
		return session.selectOne("getTotalPosts");
	}
	public ContestPost Content(String postid) {
		// TODO Auto-generated method stub
		return session.selectOne("Content", postid);
	}
	public void deltContent(ContestPost dto) {
		session.delete("deltContent", dto);
		
	}
	public void UpdatePost(ContestPost dto) {
		// TODO Auto-generated method stub
		session.update("UpdatePost", dto);
		
	}
	public void contentInsert(ContestPost dto) {
		// TODO Auto-generated method stub
		session.insert("contentInsert", dto);
	}
	public List<ContestPost> writerSearch(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return session.selectList("writerSearch", params);
	}
	public int getWriterSearchCount(String text) {
		// TODO Auto-generated method stub
		return session.selectOne("getWriterSearchCount", text);
	}
	public List<ContestPost> ContentSearch(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return session.selectList("ContentSearch", params);
	}
	public int getContentSearchCount(String text) {
		// TODO Auto-generated method stub
		return session.selectOne("getContentSearchCount", text);
	}
	public void count(String postid) {
		
		session.update("viewcount", postid);
		
	}

}
