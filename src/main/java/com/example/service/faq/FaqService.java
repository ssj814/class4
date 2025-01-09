package com.example.service.faq;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.faq.FaqDAO;
import com.example.dto.FaqDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FaqService {
	
	private final FaqDAO dao;

	public List<FaqDTO> list() {
		return dao.list();
	}

	public List<FaqDTO> qnaList(HashMap<String, Object> map, RowBounds bounds) {
		List<FaqDTO> list = map == null ? list = list() : dao.qnaList(map,bounds);		
		return list;
	}

	public FaqDTO selectBoardOne(int faq_qna_id) {
		return dao.selectBoardOne(faq_qna_id);
	}

	public String saveQuestion(FaqDTO faqDTO) {
		int saveResult = dao.saveQuestion(faqDTO);
		String message = saveResult==1 ? "질문을 등록하였습니다." : "질문 등록 실패";
		return message;
	}

	public String saveAnswer(FaqDTO faqDTO) {
		int saveResult = dao.saveAnswer(faqDTO);
		String message = saveResult==1 ? "답변을 등록하였습니다." : "답변 등록 실패";
		return message;
	}

	public int getTotalCount(HashMap<String, Object> map) {
		return dao.getTotalCount(map);
	}

	public String deleteQuestion(int faq_qna_id) {
		int deleteResult = dao.deleteQuestion(faq_qna_id);
		String message = deleteResult == 1 ? "삭제하였습니다." : "삭제 실패.";
		return message;
	}
	
	public List<FaqDTO> AllAskList(RowBounds bounds){
		List<FaqDTO> askList = dao.AllAskList(bounds);
		return askList;
	}
	
}
