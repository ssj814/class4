package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("ReplyDTO")
public class ContestReplyDTO {
	private int replyId;
    private int parentCommentId;
    private int userId;
    private String createDate;
    private String content;
    private int postid;
	public ContestReplyDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ContestReplyDTO(int replyId, int parentCommentId, int userId, String createDate, String content, int postid) {
		super();
		this.replyId = replyId;
		this.parentCommentId = parentCommentId;
		this.userId = userId;
		this.createDate = createDate;
		this.content = content;
		this.postid = postid;
	}
	public int getReplyId() {
		return replyId;
	}
	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}
	public int getParentCommentId() {
		return parentCommentId;
	}
	public void setParentCommentId(int parentCommentId) {
		this.parentCommentId = parentCommentId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getPostid() {
		return postid;
	}
	public void setPostid(int postid) {
		this.postid = postid;
	}
	@Override
	public String toString() {
		return "ReplyDTO [replyId=" + replyId + ", parentCommentId=" + parentCommentId + ", userId=" + userId
				+ ", createDate=" + createDate + ", content=" + content + ", postid=" + postid + "]";
	}
    
    
}
