package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.ContestCommentDAO;
import com.example.dto.ContestCommentDTO;





@Service
public class ContestCommentService {
	@Autowired
	ContestCommentDAO dao;

	public List<ContestCommentDTO> commtSelect(String postid) {
		// TODO Auto-generated method stub
		return dao.commtSelect(postid);
	}

	public void Commentinsert(ContestCommentDTO insert) {
		dao.Commentinsert(insert);
		
	}

	public ContestCommentDTO commtInsertSelect(ContestCommentDTO insert) {
		// TODO Auto-generated method stub
		return dao.commtInsertSelect(insert);
	}

	public void CommentUpdate(ContestCommentDTO dto) {
		dao.CommentUpdate(dto);
		
	}

	public ContestCommentDTO reComment(String commetnid) {
		// TODO Auto-generated method stub
		return dao.reComment(commetnid);
	}

	public void DeleteComment(ContestCommentDTO dto) {
		dao.DeleteComment(dto);
		
	}
}
