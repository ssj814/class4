package com.example.service.sicdan;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.sicdan.SicdanDAO;
import com.example.dto.SicdanDTO;
import com.example.util.BadWordFilter;

@Service
public class SicdanService {

    @Autowired
    private SicdanDAO sicdanDAO;

    // 게시글 작성
    public int write(SicdanDTO dto) {
        // 제목과 내용 필터링
        String filteredTitle = BadWordFilter.filterBadWords(dto.getSic_title());
        String filteredContent = BadWordFilter.filterBadWords(dto.getContent());
        dto.setSic_title(filteredTitle);
        dto.setContent(filteredContent);
        
        return sicdanDAO.write(dto);
    }

    // 게시글 번호로 조회
    public SicdanDTO selectByNum(int num) {
        return sicdanDAO.selectByNum(num);
    }

    // 게시글 수정
    public int updateByNum(SicdanDTO dto) {
        // 제목과 내용 필터링
        String filteredTitle = BadWordFilter.filterBadWords(dto.getSic_title());
        String filteredContent = BadWordFilter.filterBadWords(dto.getContent());
        dto.setSic_title(filteredTitle);
        dto.setContent(filteredContent);
        
        return sicdanDAO.updateByNum(dto);
    }

    // 게시글 삭제
    public int deleteNum(int num) {
        return sicdanDAO.deleteNum(num);
    }

    // 게시글 목록 조회
    public List<SicdanDTO> listAll(HashMap<String, Object> map) {
        return sicdanDAO.listAll(map);
    }

    // 게시글 총 개수 조회
    public int getTotalCount(HashMap<String, Object> map) {
        return sicdanDAO.getTotalCount(map);
    }
}
