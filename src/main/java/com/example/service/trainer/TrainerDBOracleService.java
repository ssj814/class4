package com.example.service.trainer;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.TrainerDBDao;
import com.example.dto.TrainerDTO;

@Service
public class TrainerDBOracleService {

    @Autowired
    private TrainerDBDao dao;

    public int getTotalLists(Map<String, Object> params) {
        return dao.getTotalLists(params);
    }

    public List<TrainerDTO> getlistsByPage(Map<String, Object> params) {
        return dao.getlistsByPage(params);
    }

    public int insertTrainer(TrainerDTO dto) {
        return dao.insertTrainer(dto);
    }

    public TrainerDTO selectTrainer(int idx) {
        return dao.selectTrainer(idx);
    }

    public int updateTrainer(TrainerDTO dto) {
        return dao.updateTrainer(dto);
    }

    public int deleteTrainer(int id) {
        return dao.deleteTrainer(id);
    }
}
