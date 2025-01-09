package com.example.dao.general;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.FaqDTO;
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
	public List<ReportDTO> allReportList(RowBounds bounds) {
		return session.selectList("ReportMapper.allReportList","",bounds);
	}
	public ReportDTO getReportById(int reportId) {
	    return session.selectOne("ReportMapper.getReportById", reportId);
	}
	public void updateReport(ReportDTO report) {
	    session.update("ReportMapper.updateReport", report);
	}

}
