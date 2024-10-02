package com.example.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ContestCommentDTO;





@Repository
public class ContestCommentDAO {
	@Autowired
	SqlSessionTemplate session;

	public List<ContestCommentDTO> commtSelect(String postid) {
		// TODO Auto-generated method stub
		return session.selectList("commtSelect", postid);
	}

	public void Commentinsert(ContestCommentDTO insert) {
		session.insert("Commentinsert", insert);
		
	}

	public ContestCommentDTO commtInsertSelect(ContestCommentDTO insert) {
		
		return session.selectOne("commtInsertSelect", insert);
	}

	public void CommentUpdate(ContestCommentDTO dto) {
		session.update("CommentUpdate", dto);
		
	}

	public ContestCommentDTO reComment(String commetnid) {
		// TODO Auto-generated method stub
		return session.selectOne("reComment", commetnid);
	}

	public void DeleteComment(ContestCommentDTO dto) {
		session.update("DeleteComment", dto);
		
	}
}
