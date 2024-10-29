package com.example.dao.trainer;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.TrainerBoardDTO;
import com.example.dto.PageDTO;

@Repository
public class TrainerBoardDAO {
	
	@Autowired
	SqlSessionTemplate template;

	
	public PageDTO select( HashMap<String, String> map, int curPage) {
		PageDTO pDTO = new PageDTO();
		int perPage=pDTO.getPerPage();
		int offset=(curPage-1)*perPage;
		System.out.println(map);
		List<TrainerBoardDTO> list=template.selectList("com.dao.BoardMapper.selectAll", map, new RowBounds(offset, perPage));
		
		pDTO.setCurPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(totalCount(map));
		
		return pDTO;
	}

	private int totalCount( HashMap<String, String> map) {
		return template.selectOne("com.dao.BoardMapper.totalCount", map);
	}

	public int insert( TrainerBoardDTO dto) {
		int n=template.insert("com.dao.BoardMapper.insert", dto);
		return n;
	}

	public TrainerBoardDTO retrieve( int postid) {
		TrainerBoardDTO dto=template.selectOne("com.dao.BoardMapper.selectBytitle", postid);
	
		return dto;
	}

	public int update( TrainerBoardDTO dto) {
		int n=template.update("com.dao.BoardMapper.update", dto);
		return n;
	}

	public int delete( int postid) {
		int n= template.delete("com.dao.BoardMapper.delete", postid);
		 return n;
	}
	
	public void increaseViewCount( int postid) {
		template.update("com.dao.BoardMapper.increaseViewCount", postid);
	}

	public List<TrainerBoardDTO> list() {
		return template.selectList("BoardMapper.list");
	}


	public List<TrainerBoardDTO> selectTopPosts() {
       return template.selectList("com.dao.BoardMapper.selectTopPosts");
   }
	
}
