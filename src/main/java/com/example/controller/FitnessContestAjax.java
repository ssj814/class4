package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.dto.ContestCommentDTO;
import com.example.dto.ContestReplyDTO;
import com.example.service.ContestCommentService;
import com.example.service.ContestPostService;
import com.example.service.ContestReplyService;



	

@RestController
public class FitnessContestAjax {
	@Autowired
	ContestPostService service;
	@Autowired
	ContestCommentService service2;
	@Autowired
	ContestReplyService service3;
	@RequestMapping("/insert")
	public ContestCommentDTO insert(@RequestBody ContestCommentDTO insert) {
		service2.Commentinsert(insert);
		System.out.println("댓글 insert: "+insert);
	ContestCommentDTO dto= service2.commtInsertSelect(insert);
	System.out.println("댓글 콜백"+dto);
		return dto;
	}
	@RequestMapping(value = "/ReplyInsert")
	public ContestReplyDTO ReplyInsert(@RequestBody ContestReplyDTO dto) {
		System.out.println(dto);
		service3.ReplyInsert(dto);
		ContestReplyDTO result= service3.insertRetrieve(dto);
		System.out.println(result);
		return result;
	}
	@RequestMapping(value = "CommentUpdate")
	public ContestCommentDTO CommentUpdate(ContestCommentDTO dto) {
		
		service2.CommentUpdate(dto);
		String commetnid=dto.getCommentId();
		ContestCommentDTO result= service2.reComment(commetnid);
		return result;
	}
	@RequestMapping(value = "DeleteComment")
		public String DeleteComment(ContestCommentDTO dto) {
		service2.DeleteComment(dto);
		String parentCommentId= dto.getCommentId();
		service3.commentReplyDelete(parentCommentId);
		return "success";
	}
	@RequestMapping(value = "Replyupdate")
	public ContestReplyDTO Replyupdate(ContestReplyDTO dto) {
		ContestReplyDTO result=service3.insertRetrieve(dto);
		return result;
	}
	@RequestMapping(value = "ReplyDelete")
	public String ReplyDelete(ContestReplyDTO dto) {
		System.out.println("delete : "+dto);
		service3.ReplyDelete(dto);
		return "success";
	}
	
	
}
