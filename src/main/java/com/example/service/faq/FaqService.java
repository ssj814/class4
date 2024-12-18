package com.example.service.faq;

import java.util.HashMap;
import java.util.List;

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

	public List<FaqDTO> qnaList(HashMap<String, Object> map) {
		List<FaqDTO> list = null;
		if(map == null) {
			list = list();
		} else {
			list = dao.qnaList(map);
		}
		return list;
	}

	public FaqDTO selectBoardOne(int faq_qna_id) {
		return dao.selectBoardOne(faq_qna_id);
	}

	public String saveQuestion(FaqDTO faqDTO) {
		String message = null;
		int saveResult = dao.saveQuestion(faqDTO);
		if(saveResult==1) {
			message = "질문을 등록하였습니다.";
		} else {
			message = "질문 등록 실패";
		}
		return message;
	}

	public String saveAnswer(FaqDTO faqDTO) {
		String message = null;
		int saveResult = dao.saveAnswer(faqDTO);
		if(saveResult==1) {
			message = "답변을 등록하였습니다.";
		} else {
			message = "답변 등록 실패";
		}
		return message;
	}

	

}
