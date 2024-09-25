package com.example.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.TrainerBoardCommentDTO;

@Repository
public class TrainerBoardCommentDAO {
	
	@Autowired
	SqlSessionTemplate template;
	
	//네임스페이스 다른걸로 바꾸고 dao도 수정좀^^;;
	//네임스페이스 다른걸로 바꾸고 dao도 수정좀^^;;
	//네임스페이스 다른걸로 바꾸고 dao도 수정좀^^;;
	//네임스페이스 다른걸로 바꾸고 dao도 수정좀^^;;
	//네임스페이스 다른걸로 바꾸고 dao도 수정좀^^;;
	
	public int commentAdd( TrainerBoardCommentDTO dto) {
		int n=template.insert("TrainerBoardCommentMapper.commentAdd", dto);
		System.out.println("CommentDAO :"+n);
		return n;
	}


	public List<TrainerBoardCommentDTO> commentSelect(int postid) {
		List<TrainerBoardCommentDTO> dto = template.selectList("TrainerBoardCommentMapper.commentSelect", postid);
		return dto;
	}


	public void delete(Integer postid) {
		// TODO Auto-generated method stub
	int p = postid;
		template.delete("TrainerBoardCommentMapper.commentDelete",p);
	}
	
	
}
