package com.example.service.sicdan;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.sicdan.SicdanDAO;
import com.example.dto.BoardPostsDTO;
import com.example.dto.SicdanDTO;
import com.example.util.BadWordFilter;

@Service
public class SicdanService {

    @Autowired
    private SicdanDAO sicdanDAO;

    // 게시글 작성
    public int write(BoardPostsDTO dto) {
        // 제목과 내용 필터링
        String filteredTitle = BadWordFilter.filterBadWords(dto.getTitle());
        String filteredContent = BadWordFilter.filterBadWords(dto.getContent());
        dto.setTitle(filteredTitle);
        dto.setContent(filteredContent);
        
        return sicdanDAO.write(dto);
    }

    // 게시글 번호로 조회
    public BoardPostsDTO selectByNum(int postId) {
        return sicdanDAO.selectByNum(postId);
    }

    // 게시글 수정
    public int updateByNum(BoardPostsDTO dto) {
        // 제목과 내용 필터링
        String filteredTitle = BadWordFilter.filterBadWords(dto.getTitle());
        String filteredContent = BadWordFilter.filterBadWords(dto.getContent());
        dto.setTitle(filteredTitle);
        dto.setContent(filteredContent);
        
        return sicdanDAO.updateByNum(dto);
    }

    // 게시글 삭제
    public int deleteNum(int postId) {
        return sicdanDAO.deleteNum(postId);
    }

    // 게시글 목록 조회
    public List<BoardPostsDTO> listAll(HashMap<String, Object> map) {
        return sicdanDAO.listAll(map);
    }

    // 게시글 총 개수 조회
    public int getTotalCount(HashMap<String, Object> map) {
        return sicdanDAO.getTotalCount(map);
    }
}
