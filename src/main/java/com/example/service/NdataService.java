package com.example.service;

import com.example.dao.NdataDAO;
import com.example.dto.NdataDTO;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * NdataService 클래스는 서비스 계층으로, 비즈니스 로직을 처리하고 데이터 매퍼와 상호 작용합니다.
 */
@Service
public class NdataService {

    // NdataDAO를 주입받아 사용하기 위한 필드
    private final NdataDAO ndataDAO;

    // 생성자를 통해 NdataDAO를 주입받습니다. 의존성 주입을 사용합니다.
    public NdataService(NdataDAO ndataDAO) {
        this.ndataDAO = ndataDAO;
    }

    // 모든 NdataDTO 객체의 리스트를 가져오는 메서드
    public List<NdataDTO> list() {
        // 데이터 DAO를 호출하여 데이터 리스트를 반환합니다.
        return ndataDAO.list();
    }

    // 특정 성별 ID에 해당하는 NdataDTO 객체를 가져오는 메서드
    public NdataDTO genderNum(int genderId) {
        // 데이터 DAO를 호출하여 특정 성별에 해당하는 데이터를 반환합니다.
        return ndataDAO.genderNum(genderId);
    }
}
