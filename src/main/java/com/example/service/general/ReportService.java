package com.example.service.general;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.general.ReportDAO;
import com.example.dto.ReportDTO;

@Service
public class ReportService {

	@Autowired
	ReportDAO dao;
	
	public List<ReportDTO> allReportType() {
		return dao.allReportType();
	}

	public void saveReport(ReportDTO dto) {
		dao.saveReport(dto);
	}
	
	

}
