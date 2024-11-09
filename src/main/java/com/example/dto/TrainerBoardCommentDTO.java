package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("TrainerBoardCommentDTO")
public class TrainerBoardCommentDTO {

//TrainerBoardCommentDTO 수정 10.29
	
	private int postid; //글고유번호
	private int commId; //댓글고유번호
	private String userId; //댓글작성자
	private String commContent; //댓글내용
	private String comCrdate; //댓글작성일
	private String comUpdate; //댓글수정일
	private Integer tr_ParentId = 0; //부모댓글
	private int tr_RepIndent; //댓글들여쓰기기준
	private String realUsername;
	
	public TrainerBoardCommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public TrainerBoardCommentDTO(int postid, int commId, String userId, String commContent, String comCrdate,
			String comUpdate, Integer tr_ParentId, int tr_RepIndent, String realUsername) {

		super();
		this.postid = postid;
		this.commId = commId;
		this.userId = userId;
		this.commContent = commContent;
		this.comCrdate = comCrdate;
		this.comUpdate = comUpdate;
		this.tr_ParentId = tr_ParentId;
		this.tr_RepIndent = tr_RepIndent;
		this.realUsername = realUsername;
	}


	public int getPostid() {
		return postid;
	}


	public void setPostid(int postid) {
		this.postid = postid;
	}


	public int getCommId() {
		return commId;
	}


	public void setCommId(int commId) {
		this.commId = commId;
	}
  
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getCommContent() {
		return commContent;
	}


	public void setCommContent(String commContent) {
		this.commContent = commContent;
	}


	public String getComCrdate() {
		return comCrdate;
	}


	public void setComCrdate(String comCrdate) {
		this.comCrdate = comCrdate;
	}


	public String getComUpdate() {
		return comUpdate;
	}


	public void setComUpdate(String comUpdate) {
		this.comUpdate = comUpdate;
	}


	public Integer getTr_ParentId() {
		return tr_ParentId;
	}


	public void setTr_ParentId(Integer tr_ParentId) {
		this.tr_ParentId = tr_ParentId;
	}


	public int getTr_RepIndent() {
		return tr_RepIndent;
	}


	public void setTr_RepIndent(int tr_RepIndent) {
		this.tr_RepIndent = tr_RepIndent;
	}


	public String getRealUsername() {
		return realUsername;
	}


	public void setRealUsername(String realUsername) {
		this.realUsername = realUsername;
	}


	@Override
	public String toString() {
		return "TrainerBoardCommentDTO [postid=" + postid + ", commId=" + commId + ", userId=" + userId
				+ ", commContent=" + commContent + ", comCrdate=" + comCrdate + ", comUpdate=" + comUpdate
				+ ", tr_ParentId=" + tr_ParentId + ", tr_RepIndent=" + tr_RepIndent + ", realUsername=" + realUsername
				+ "]";
	}
	
	
	
	
}
