package com.example.dao.trainer;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.TrainerBoardDTO;
import com.example.dto.BoardPostsDTO;
import com.example.dto.PageDTO;

@Repository
public class TrainerBoardDAO {

	@Autowired
	SqlSessionTemplate template;

	public PageDTO select(HashMap<String, String> map, int curPage) {
		PageDTO pDTO = new PageDTO();
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		System.out.println(map);
		List<BoardPostsDTO> list = template.selectList("BoardMapper.selectAll", map, new RowBounds(offset, perPage));

		pDTO.setCurPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(totalCount(map));

		return pDTO;
	}

	private int totalCount(HashMap<String, String> map) {
		return template.selectOne("BoardMapper.totalCount", map);
	}

	public int insert(BoardPostsDTO dto) {
		int n = template.insert("BoardMapper.insert", dto);
		return n;
	}

	public BoardPostsDTO retrieve(int postid) {
		BoardPostsDTO dto = template.selectOne("BoardMapper.selectBytitle", postid);

		return dto;
	}

	public int update(BoardPostsDTO dto) {
		int n = template.update("BoardMapper.update", dto);
		return n;
	}

	public int delete(int postid) {
		int n = template.delete("BoardMapper.delete", postid);
		return n;
	}

	public void increaseViewCount(int postid) {
		template.update("BoardMapper.increaseViewCount", postid);
	}

	public List<TrainerBoardDTO> list() {
		return template.selectList("BoardMapper.list");
	}

	public List<BoardPostsDTO> selectTopPosts() {
		return template.selectList("BoardMapper.selectTopPosts");
	}

	public BoardPostsDTO getPostbyId(int postid) {
		return template.selectOne("BoardMapper.getPostbyId", postid);
	}

}
