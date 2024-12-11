package com.example.dao.notice;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.BoardPostsDTO;

@Repository
public class NoticeDAO {
	@Autowired
	SqlSessionTemplate session;

	// 게시판 리스트 가져오기
    public List<BoardPostsDTO> selectBoardList(HashMap<String, Object> map) {
        return session.selectList("NoticeMapper.selectBoardList", map);
    }

    // 게시글 하나 가져오기
    public BoardPostsDTO selectBoardOne(int postId) {
        return session.selectOne("NoticeMapper.selectBoardOne", postId);
    }

    // 게시글 작성
    public int insertContent(BoardPostsDTO dto) {
        return session.insert("NoticeMapper.insertContent", dto);
    }

    // 게시글 삭제
    public int boardDelete(int postId) {
        return session.delete("NoticeMapper.boardDelete", postId);
    }

    // 게시글 수정
    public int updateContent(BoardPostsDTO dto) {
        return session.update("NoticeMapper.updateContent", dto);
    }

    // 게시글 총 수 가져오기
    public int getTotalCount(HashMap<String, Object> map) {
        return session.selectOne("NoticeMapper.getTotalCount", map);
    }

    // 조회수 증가
    public void increaseViewCount(int postId) {
        session.update("NoticeMapper.increaseViewCount", postId);
    }

    // 팝업 공지 가져오기 (CATEGORY_ID = 1 필터링)
    public List<BoardPostsDTO> selectPopupPosts() {
        return session.selectList("NoticeMapper.selectPopupPosts");
    }

    // 팝업 비활성화 업데이트
    public void updatePopupToN(BoardPostsDTO post) {
        session.update("NoticeMapper.updatePopupToN", post);
    }

}
