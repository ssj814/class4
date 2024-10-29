package com.example.dao.notice;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.NoticeDTO;

@Repository
public class NoticeDAO {
	@Autowired
	SqlSessionTemplate session;

	public List<NoticeDTO> selectBoardList(HashMap<String, Object> map) {
		List<NoticeDTO> list = session.selectList("NoticeMapper.selectBoardList", map);
		return list;
	}

	public NoticeDTO selectBoardOne(int postid) {
		NoticeDTO dto = session.selectOne("NoticeMapper.selectBoardOne", postid);
		return dto;
	}

	public int insertContent(NoticeDTO dto) {
		int count = session.insert("NoticeMapper.insertContent", dto);
		return count;
	}

	public int boardDelete(int postid) {
		int num = session.delete("NoticeMapper.boardDelete", postid);
		return num;
	}

	public int updateContent(NoticeDTO dto) {
		int num = session.update("NoticeMapper.updateContent", dto);
		return num;
	}

	public int getTotalCount(HashMap<String, Object> map) {
		int total = session.selectOne("NoticeMapper.getTotalCount", map);
		return total;
	}

	public void increaseViewCount(int postid) {
		session.update("NoticeMapper.increaseViewCount", postid);
	}
}
