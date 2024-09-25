package com.example.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.TrainerDBDao;
import com.example.dto.TrainerDTO;

@Service
public class TrainerDBOracleService implements TrainerService {

	@Autowired
	TrainerDBDao dao;
	//sqlsessionTemplate는 @mapper 사용시 사용됨

	@Override
	public int getTotalLists(Map<String, Object> params) {
		return dao.getTotalLists(params);
	}

	@Override
	public List<TrainerDTO> getlistsByPage(Map<String, Object> params) {
		return dao.getlistsByPage(params);
	}

	@Override
	public int insertTrainer(TrainerDTO dto) {
		return dao.insertTrainer(dto);
	}

	@Override
	public TrainerDTO selectTrainer(int idx) {
		return dao.selectTrainer(idx);
	}

	@Override
	public int updateTrainer(TrainerDTO dto) {
		return dao.updateTrainer(dto);
	}

	@Override
	public int deleteTrainer(int id) {
		return dao.deleteTrainer(id);
	}
	
	

}
