package com.example.service.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.notice.NoticeDAO;
import com.example.dto.NoticeDTO;

@Service
public class NoticeService {
	@Autowired
	NoticeDAO dao;

	//공지사항 전체 리스트 불러오기
	public List<NoticeDTO> selectBoardList(HashMap<String, Object> map) {
		List<NoticeDTO> list = null;
		list = dao.selectBoardList(map);
		return list;
	}

	//공지사항 글 하나 불러오기
	public NoticeDTO selectBoardOne(int postid) {
		NoticeDTO dto = null;
		dao.increaseViewCount(postid);
		dto = dao.selectBoardOne(postid);
		return dto;
	}

	//공지사항 글쓰기
	public int insertContent(NoticeDTO dto) {
		int count = 0;
		count = dao.insertContent(dto);
		return count;
	}

	//공지사항 글 삭제
	public int boardDelete(int postid) {
		int num = 0;
		num = dao.boardDelete(postid);
		return num;
	}

	//공지사항 글 수정
	public int updateContent(NoticeDTO dto) {
		int num = 0;
		num = dao.updateContent(dto);
		return num;
	}

	//공지사항 조회수
	public int getTotalCount(HashMap<String, Object> map) {
		int total = 0;
		total = dao.getTotalCount(map);
		return total;
	}
}
