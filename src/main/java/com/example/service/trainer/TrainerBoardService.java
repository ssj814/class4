package com.example.service.trainer;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.trainer.TrainerBoardDAO;
import com.example.dto.BoardPostsDTO;
import com.example.dto.PageDTO;
import com.example.dto.TrainerBoardDTO;

@Service
public class TrainerBoardService {

	@Autowired
	TrainerBoardDAO dao;

	// 검색조회
	public PageDTO select(String searchName, String searchValue, int curPage) {

		HashMap<String, String> map = new HashMap<>();
		map.put("searchName", searchName);
		map.put("searchValue", searchValue);
		PageDTO pDTO = dao.select(map, curPage);
		return pDTO;
	}

	// 추가
	public int insert(BoardPostsDTO dto) {
		int n = 0;
		n = dao.insert(dto);
		return n;
	}

	// 데이터조회+글조회수 증가
	public BoardPostsDTO retrieve(int postid) {
		BoardPostsDTO dto = null;
		dto = dao.retrieve(postid);
		// 글 상세내용확인시 조회수 없어서 글 클릭 후 조회수 오르게 만듬.
		dao.increaseViewCount(postid);
		return dto;
	}

	// 수정
	public int update(BoardPostsDTO dto) {
		int n = 0;
		n = dao.update(dto);
		return n;
	}

	// 삭제
	public int delete(int postid) {
		int n = 0;
		n = dao.delete(postid);
		return n;
	}

	public List<TrainerBoardDTO> list() {
		return dao.list();
	}

	public BoardPostsDTO getPostById(int postid) {
		return dao.getPostbyId(postid);
	}

	public List<BoardPostsDTO> selectTopPosts() {
		return dao.selectTopPosts();
	}


}
