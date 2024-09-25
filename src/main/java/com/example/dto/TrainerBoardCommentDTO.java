package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("TrainerBoardCommentDTO")
public class TrainerBoardCommentDTO {

	
	int Postid;
	int Commid;
	int userid;
	String commcontent;
	String comcrdate;
	String comupdate;
	
	public TrainerBoardCommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TrainerBoardCommentDTO(int postid, int commid, int userid, String commcontent, String comcrdate, String comupdate) {
		super();
		Postid = postid;
		Commid = commid;
		this.userid = userid;
		this.commcontent = commcontent;
		this.comcrdate = comcrdate;
		this.comupdate = comupdate;
	}

	@Override
	public String toString() {
		return "CommentDTO [Postid=" + Postid + ", Commid=" + Commid + ", userid=" + userid + ", commcontent="
				+ commcontent + ", comcrdate=" + comcrdate + ", comupdate=" + comupdate + "]";
	}

	public int getPostid() {
		return Postid;
	}

	public void setPostid(int postid) {
		Postid = postid;
	}

	public int getCommid() {
		return Commid;
	}

	public void setCommid(int commid) {
		Commid = commid;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getCommcontent() {
		return commcontent;
	}

	public void setCommcontent(String commcontent) {
		this.commcontent = commcontent;
	}

	public String getComcrdate() {
		return comcrdate;
	}

	public void setComcrdate(String comcrdate) {
		this.comcrdate = comcrdate;
	}

	public String getComupdate() {
		return comupdate;
	}

	public void setComupdate(String comupdate) {
		this.comupdate = comupdate;
	}
	
	
	
}
