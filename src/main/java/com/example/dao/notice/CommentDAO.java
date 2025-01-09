package com.example.dao.notice;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.CommentDTO;

@Repository
public class CommentDAO {
	@Autowired
	SqlSessionTemplate session;

	 // 특정 게시물의 댓글 목록 가져오기
    public List<CommentDTO> selectCommentsByPostId(int postId) {
        return session.selectList("CommentMapper.selectCommentsByPostId", postId);
    }

    // 댓글 삽입
    public void insertComment(CommentDTO commentDTO) {
    	session.insert("CommentMapper.insertComment", commentDTO);
    }
    
    // 댓글 수정
    public void updateComment(CommentDTO commentDTO) {
    	session.update("CommentMapper.updateComment", commentDTO);
    }

    // 댓글 삭제
    public void deleteComment(int id) {
    	session.delete("CommentMapper.deleteComment", id);
    }

	public CommentDTO getCommentbyId(int id) {
		return session.selectOne("CommentMapper.getCommentbyId", id);
	}
}
