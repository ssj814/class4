package com.example.service.trainer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.trainer.TrainerBoardCommentDAO;
import com.example.dto.TrainerBoardCommentDTO;

@Service
public class TrainerBoardCommentService {
	
	@Autowired
	TrainerBoardCommentDAO dao;
	
	
	public int commentAdd(TrainerBoardCommentDTO dto) {
	
		
		int n=0;
		
			n=dao.commentAdd(dto);
			
			System.out.println("commentAdd "+n);
	
		return n;
	}
	
	public List<TrainerBoardCommentDTO> getCommentsByPostId(int postid) {
	
		List<TrainerBoardCommentDTO> dto = null;
		
	
			dto = dao.commentSelect( postid);
	
		return dto;
	}

	public void delete(Integer postid) {
		// TODO Auto-generated method stub
		dao.delete(postid);
		
		
	}

	

	


}
