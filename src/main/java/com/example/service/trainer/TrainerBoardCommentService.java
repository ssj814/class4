package com.example.service.trainer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.trainer.TrainerBoardCommentDAO;
import com.example.dto.TrainerBoardCommentDTO;

@Service
public class TrainerBoardCommentService {
	
	@Autowired
	TrainerBoardCommentDAO dao;

		public List<TrainerBoardCommentDTO> getCommentsByPostId(int postid) {
		List<TrainerBoardCommentDTO> allTrainerboardComments = dao.selectCommentsByPostId(postid);
		return buildCommentHierarchy(allTrainerboardComments); 
		}

		private List<TrainerBoardCommentDTO> buildCommentHierarchy(
				List<TrainerBoardCommentDTO> allTrainerboardComments) {
			Map<Integer, List<TrainerBoardCommentDTO>> parentChildMap = new HashMap<>();
			List<TrainerBoardCommentDTO> rootComments = new ArrayList<>();

			// 댓글을 parentId로 분류
			for (TrainerBoardCommentDTO comment : allTrainerboardComments) {
				if (comment.getTr_ParentId() == 0) { // 부모가 없으면 최상위 댓글
					rootComments.add(comment);
				} else {
					parentChildMap.computeIfAbsent(comment.getTr_ParentId(), k -> new ArrayList<>()).add(comment);
				}
			}

			// 댓글을 계층적으로 구성
			List<TrainerBoardCommentDTO> result = new ArrayList<>();
			for (TrainerBoardCommentDTO rootComment : rootComments) {
				result.add(rootComment);
				addChildComments(rootComment, parentChildMap, result, 1); // 1레벨부터 시작
			}

			return result;
		}

		private void addChildComments(TrainerBoardCommentDTO parent,
				Map<Integer, List<TrainerBoardCommentDTO>> parentChildMap, List<TrainerBoardCommentDTO> result, int indentLevel) {
			List<TrainerBoardCommentDTO> childComments = parentChildMap.get(parent.getCommId());
			if (childComments != null) {
				for (TrainerBoardCommentDTO child : childComments) {
					child.setTr_RepIndent(indentLevel); // 들여쓰기 수준 설정
					result.add(child);
					addChildComments(child, parentChildMap, result, indentLevel + 1);
				}
			}
		}
		
		public void addComment(TrainerBoardCommentDTO commentDTO) {
			System.out.println("commentService=======");
			dao.addComment(commentDTO);
		}
	
		// 댓글 수정
	    public void updateTrainerboardComment(TrainerBoardCommentDTO commentDTO) {
	        dao.updateTrainerboardComment(commentDTO);
	    }

	    // 댓글 삭제
	    @Transactional
	    public void deleteTrainerboardComment(int commid) {
	        dao.deleteTrainerboardComment(commid);
	    }

		public TrainerBoardCommentDTO getCommentByPostId(int commId) {
			 return dao.selectCommentByPostId(commId);
		}

		

	
	
	
		
		

}
