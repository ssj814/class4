package com.example.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.NdataDTO;

/**
 * Ndata DAO 클래스입니다.
 * 데이터베이스와의 상호작용을 담당합니다.
 */
@Repository
public class NdataDAO {

    @Autowired
    private SqlSessionTemplate session; // MyBatis의 SqlSessionTemplate을 사용하여 DB 작업 수행

    /**
     * NdataDTO 객체의 리스트를 가져오는 메서드입니다.
     *
     * @return NdataDTO 객체의 리스트
     */
    public List<NdataDTO> list() {
        return session.selectList("com.example.NdataMapper.list");
    }

    /**
     * 주어진 ID를 기반으로 NdataDTO 객체를 가져오는 메서드입니다.
     *
     * @param id 조회할 NdataDTO의 ID
     * @return 조회된 NdataDTO 객체
     */
    public NdataDTO genderNum(int id) {
        return session.selectOne("com.example.NdataMapper.genderNum", id);
    }
}
