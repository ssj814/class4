package com.example.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.ContestPostDAO;
import com.example.dto.ContestPost;





@Service
public class ContestPostService {
@Autowired
ContestPostDAO dao;

public List<ContestPost> getPostsByPage(Map<String, Integer> params) {
	// TODO Auto-generated method stub
	return dao.getPostsByPage(params);
}

public int getTotalPosts() {
	// TODO Auto-generated method stub
	return dao.getTotalPosts();
}
@Transactional
public ContestPost Content(String postid) {
	dao.count(postid);
	return dao.Content(postid);
}

public void deltContent(ContestPost dto) {
	dao.deltContent(dto);
	
}

public void UpdatePost(ContestPost dto) {
	// TODO Auto-generated method stub
	dao.UpdatePost(dto);
	
}

public void contentInsert(ContestPost dto) {
	dao.contentInsert(dto);
}

public List<ContestPost> writerSearch(HashMap<String, Object> params) {
	// TODO Auto-generated method stub
	return dao.writerSearch(params);
}

public int getWriterSearchCount(String text) {
	// TODO Auto-generated method stub
	return dao.getWriterSearchCount(text);
}

public List<ContestPost> ContentSearch(HashMap<String, Object> params) {
	// TODO Auto-generated method stub
	return dao.ContentSearch(params);
}

public int getContentSearchCount(String text) {
	// TODO Auto-generated method stub
	return dao.getContentSearchCount(text);
}

}
