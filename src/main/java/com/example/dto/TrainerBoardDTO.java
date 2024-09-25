package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("BoardDTO")
public class TrainerBoardDTO {


	int postid; 
	int categoryid; 
	int userid; 
	int trainerid; 
	String title; 
	String content; 
	String crdate; 
	String updatedate; 
	
	int viewcount; //��ȸ��

	public TrainerBoardDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TrainerBoardDTO(int postid, int categoryid, int userid, int trainerid, String title, String content, String crdate,
			String updatedate, int viewcount) {
		super();
		this.postid = postid;
		this.categoryid = categoryid;
		this.userid = userid;
		this.trainerid = trainerid;
		this.title = title;
		this.content = content;
		this.crdate = crdate;
		this.updatedate = updatedate;
		this.viewcount = viewcount;
	}

	@Override
	public String toString() {
		return "BoardDTO [postid=" + postid + ", categoryid=" + categoryid + ", userid=" + userid + ", trainerid="
				+ trainerid + ", title=" + title + ", content=" + content + ", crdate=" + crdate + ", updatedate="
				+ updatedate + ", viewcount=" + viewcount + "]";
	}

	public int getPostid() {
		return postid;
	}

	public void setPostid(int postid) {
		this.postid = postid;
	}

	public int getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public int getTrainerid() {
		return trainerid;
	}

	public void setTrainerid(int trainerid) {
		this.trainerid = trainerid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCrdate() {
		return crdate;
	}

	public void setCrdate(String crdate) {
		this.crdate = crdate;
	}

	public String getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}

	public int getViewcount() {
		return viewcount;
	}

	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}
	
	
	
	
	
}
