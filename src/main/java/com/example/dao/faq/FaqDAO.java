package com.example.dao.faq;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.FaqDTO;
import com.example.service.faq.FaqService;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class FaqDAO {
	
	private final SqlSessionTemplate session;

	public List<FaqDTO> list() {
		return session.selectList("FaqMapper.list");
	}

	public List<FaqDTO> qnaList(HashMap<String, Object> map, RowBounds bounds) {
		return session.selectList("FaqMapper.qnaList",map,bounds);
	}

	public FaqDTO selectBoardOne(int faq_qna_id) {
		return session.selectOne("FaqMapper.selectBoardOne",faq_qna_id);
	}

	public int saveQuestion(FaqDTO faqDTO) {
		return session.insert("FaqMapper.saveQuestion",faqDTO);
	}

	public int saveAnswer(FaqDTO faqDTO) {
		return session.update("FaqMapper.saveAnswer",faqDTO);
	}

	public int getTotalCount(HashMap<String, Object> map) {
		return session.selectOne("FaqMapper.getTotalCount",map);
	}

	public int deleteQuestion(int faq_qna_id) {
		return session.delete("FaqMapper.deleteQuestion",faq_qna_id);
	}

	public List<FaqDTO> AllAskList(RowBounds bounds) {
		return session.selectList("FaqMapper.AllAskList","",bounds);
	}
	
}
