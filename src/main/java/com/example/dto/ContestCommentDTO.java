package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("ContestCommentDTO")
public class ContestCommentDTO {
	private String postid;
	private String userid;
	private String createdate;
	private String content;
	private String commentId;
	public ContestCommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ContestCommentDTO(String postid, String userid, String createdate, String content, String commentId) {
		super();
		this.postid = postid;
		this.userid = userid;
		this.createdate = createdate;
		this.content = content;
		this.commentId = commentId;
	}
	public String getPostid() {
		return postid;
	}
	public void setPostid(String postid) {
		this.postid = postid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCommentId() {
		return commentId;
	}
	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}
	@Override
	public String toString() {
		return "CommentDTO [postid=" + postid + ", userid=" + userid + ", createdate=" + createdate + ", content="
				+ content + ", commentId=" + commentId + "]";
	}
	
	
}
