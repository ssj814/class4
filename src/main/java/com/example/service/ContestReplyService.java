package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.ContestReplyDAO;
import com.example.dto.ContestReplyDTO;

;



@Service
public class ContestReplyService {
@Autowired
ContestReplyDAO dao;

public List<ContestReplyDTO> getRepliesByCommentId(String postid) {
	// TODO Auto-generated method stub
	return dao.getRepliesByCommentId(postid);
}

public void ReplyInsert(ContestReplyDTO dto) {
	dao.ReplyInsert(dto);
	
}

public ContestReplyDTO insertRetrieve(ContestReplyDTO dto) {
	// TODO Auto-generated method stub
	return dao.insertRetrieve(dto);
}

public void Replyupdate(ContestReplyDTO dto) {
	// TODO Auto-generated method stub
	dao.Replyupdate(dto);
}

public void ReplyDelete(ContestReplyDTO dto) {
	// TODO Auto-generated method stub
	dao.ReplyDelete(dto);
}

public void commentReplyDelete(String parentCommentId) {
	// TODO Auto-generated method stub
	dao.commentReplyDelete(parentCommentId);
}


}
