package com.example.service;

import java.util.List;
import java.util.Map;

import com.example.dto.TrainerDTO;

public interface TrainerService {

	public abstract int getTotalLists(Map<String, Object> params);
	public abstract List<TrainerDTO> getlistsByPage(Map<String, Object> params);
	
	public abstract int insertTrainer(TrainerDTO dto);
//	public abstract TrainerDTO select(Map<String, String> params); 없어도될듯
	public abstract TrainerDTO selectTrainer(int idx);
	public abstract int updateTrainer(TrainerDTO dto);
	public abstract int deleteTrainer(int id);
}
