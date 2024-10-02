package com.example.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.ContestReplyDTO;




@Repository
public class ContestReplyDAO {
@Autowired
SqlSessionTemplate session;

public List<ContestReplyDTO> getRepliesByCommentId(String postid) {
	// TODO Auto-generated method stub
	return session.selectList("getRepliesByCommentId", postid);
}

public void ReplyInsert(ContestReplyDTO dto) {
	session.insert("insertReply", dto);
	
}

public ContestReplyDTO insertRetrieve(ContestReplyDTO dto) {
	// TODO Auto-generated method stub
	return session.selectOne("ReplayMapper.insertRetrieve", dto);
}

public void Replyupdate(ContestReplyDTO dto) {
	// TODO Auto-generated method stub
	session.update("replyUpdate", dto);
}

public void ReplyDelete(ContestReplyDTO dto) {
	// TODO Auto-generated method stub
	session.delete("replyDelete",dto);
}

public void commentReplyDelete(String parentCommentId) {
	// TODO Auto-generated method stub
	session.delete("commentReplyDelete", parentCommentId);
}


}
