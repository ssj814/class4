package com.example.service.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.notice.CommentDAO;
import com.example.dto.CommentDTO;

@Service
public class CommentService {
	@Autowired
	CommentDAO dao;

	// 특정 게시물의 댓글을 계층형으로 가져오기
	public List<CommentDTO> getCommentsByPostId(int postId) {
		List<CommentDTO> allComments = dao.selectCommentsByPostId(postId);
		return buildCommentHierarchy(allComments);
	}

	// 댓글 계층 구조 빌드
	private List<CommentDTO> buildCommentHierarchy(List<CommentDTO> comments) {
		Map<Integer, List<CommentDTO>> parentChildMap = new HashMap<>();
		List<CommentDTO> rootComments = new ArrayList<>();

		// 댓글을 parentId로 분류
		for (CommentDTO comment : comments) {
			if (comment.getParentId() == 0) { // 부모가 없으면 최상위 댓글
				rootComments.add(comment);
			} else {
				parentChildMap.computeIfAbsent(comment.getParentId(), k -> new ArrayList<>()).add(comment);
			}
		}

		// 댓글을 계층적으로 구성
		List<CommentDTO> result = new ArrayList<>();
		for (CommentDTO rootComment : rootComments) {
			result.add(rootComment);
			addChildComments(rootComment, parentChildMap, result, 1); // 1레벨부터 시작
		}

		return result;
	}

	// 재귀적으로 대댓글 추가
	private void addChildComments(CommentDTO parent, Map<Integer, List<CommentDTO>> parentChildMap,
			List<CommentDTO> result, int indentLevel) {
		List<CommentDTO> childComments = parentChildMap.get(parent.getId());
		if (childComments != null) {
			for (CommentDTO child : childComments) {
				child.setRepIndent(indentLevel); // 들여쓰기 수준 설정
				result.add(child);
				addChildComments(child, parentChildMap, result, indentLevel + 1);
			}
		}
	}

	// 댓글 저장
	public void addComment(CommentDTO commentDTO) {
		dao.insertComment(commentDTO);
	}
	
	// 댓글 수정
    public void updateComment(CommentDTO commentDTO) {
        dao.updateComment(commentDTO);
    }

    // 댓글 삭제
    @Transactional
    public void deleteComment(int id) {
        dao.deleteComment(id);
    }
	
}
