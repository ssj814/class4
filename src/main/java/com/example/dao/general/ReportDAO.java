package com.example.dao.general;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ReportDTO;

@Repository
public class ReportDAO {

	@Autowired
	SqlSessionTemplate session;
	
	public List<ReportDTO> allReportType() {
		return session.selectList("ReportMapper.allReportType");
	}

	public void saveReport(ReportDTO dto) {
		session.insert("ReportMapper.saveReport", dto);
	}

}
