package com.example.dao.sicdan;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.SicdanDTO;

/**
 * 게시판 DAO 클래스입니다.
 * 데이터베이스와의 상호작용을 담당합니다.
 */
@Repository
public class SicdanDAO {

    @Autowired
    private SqlSessionTemplate session; // MyBatis의 SqlSessionTemplate을 사용하여 DB 작업 수행

    /**
     * 게시글을 작성하는 메서드입니다.
     *
     * @param dto 게시글 데이터
     * @return 삽입된 행의 수
     */
    public int write(SicdanDTO dto) {
        return session.insert("com.sicdan.SicdanMapper.write", dto);
    }

    /**
     * 게시글 번호로 게시글을 조회하는 메서드입니다.
     *
     * @param num 게시글 번호
     * @return 조회된 게시글 데이터
     */
    public SicdanDTO selectByNum(int num) {
        updateReadCnt(num); // 조회수 증가
        return session.selectOne("com.sicdan.SicdanMapper.selectByNum", num);
    }

    /**
     * 게시글의 조회수를 증가시키는 메서드입니다.
     *
     * @param num 게시글 번호
     */
    private void updateReadCnt(int num) {
        session.update("com.sicdan.SicdanMapper.updateReadCnt", num);
    }

    /**
     * 게시글을 수정하는 메서드입니다.
     *
     * @param dto 게시글 데이터
     * @return 수정된 행의 수
     */
    public int updateByNum(SicdanDTO dto) {
        return session.update("com.sicdan.SicdanMapper.updateByNum", dto);
    }

    /**
     * 게시글을 삭제하는 메서드입니다 (논리적 삭제).
     *
     * @param num 게시글 번호
     * @return 삭제된 행의 수
     */
    public int deleteNum(int num) {
        return session.update("com.sicdan.SicdanMapper.deleteNum", num);
    }

    /**
     * 모든 게시글 목록을 조회하는 메서드입니다.
     *
     * @param map 검색 및 페이징에 필요한 파라미터를 담은 맵
     * @return 게시글 목록
     */
    public List<SicdanDTO> listAll(HashMap<String, Object> map) {
        return session.selectList("com.sicdan.SicdanMapper.listAll", map);
    }

    /**
     * 게시글의 총 개수를 조회하는 메서드입니다 (페이징을 위한).
     *
     * @param map 검색에 필요한 파라미터를 담은 맵
     * @return 게시글의 총 개수
     */
    public int getTotalCount(HashMap<String, Object> map) {
        return session.selectOne("com.sicdan.SicdanMapper.getTotalCount", map);
    }
}
