package com.example.dao.trainer;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.CommentDTO;
import com.example.dto.TrainerBoardCommentDTO;

@Repository
public class TrainerBoardCommentDAO {
	
	@Autowired
	SqlSessionTemplate template;
	
	 // 특정 게시물의 댓글 목록 가져오기
    public List<TrainerBoardCommentDTO> selectCommentsByPostId(int postId) {
        return template.selectList("TrainerBoardCommentMapper.selectCommentsByPostId", postId);
    }
    
    //댓글등록
    public void addComment(TrainerBoardCommentDTO commentDTO) {
		template.insert("TrainerBoardCommentMapper.insertComment", commentDTO);
		
	}
    
    // 댓글 수정
    public void updateTrainerboardComment(TrainerBoardCommentDTO commentDTO) {
    	template.update("TrainerBoardCommentMapper.updateComment", commentDTO);
    }

    // 댓글 삭제
    public void deleteTrainerboardComment(int postId) {
    	template.delete("TrainerBoardCommentMapper.deleteComment", postId);
    }





	
	
	
	
}
