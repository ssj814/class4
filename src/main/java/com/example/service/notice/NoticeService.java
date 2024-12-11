package com.example.service.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.notice.NoticeDAO;
import com.example.dto.BoardPostsDTO;

@Service
public class NoticeService {
	@Autowired
	NoticeDAO dao;

	// 게시판 리스트 불러오기
    public List<BoardPostsDTO> selectBoardList(HashMap<String, Object> map) {
        return dao.selectBoardList(map);
    }

    // 게시글 하나 불러오기
    public BoardPostsDTO selectBoardOne(int postId) {
        dao.increaseViewCount(postId);
        return dao.selectBoardOne(postId);
    }

    // 게시글 작성
    public int insertContent(BoardPostsDTO dto) {
        return dao.insertContent(dto);
    }

    // 게시글 삭제
    public int boardDelete(int postId) {
        return dao.boardDelete(postId);
    }

    // 게시글 수정
    public int updateContent(BoardPostsDTO dto) {
        return dao.updateContent(dto);
    }

    // 게시글 전체 수 가져오기
    public int getTotalCount(HashMap<String, Object> map) {
        return dao.getTotalCount(map);
    }

    // 팝업 공지 가져오기
    public List<BoardPostsDTO> getPopupPosts() {
        return dao.selectPopupPosts();
    }

    // 오래된 팝업 공지 비활성화
    public void updatePopupToN(BoardPostsDTO post) {
        dao.updatePopupToN(post);
    }
}
