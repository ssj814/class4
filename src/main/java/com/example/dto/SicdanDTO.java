package com.example.dto;


import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("SicdanDTO")
public class SicdanDTO {
	
	private int sic_num;
	private String sic_title;
	private String content;
	private String writeday;
	private int readCnt;
	private int user_id;
	private char is_del;
	private int is_admin;
	private Date updateed_at;
	private String fileName;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public SicdanDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public SicdanDTO(int sic_num, String sic_title, String content, String writeday, int readCnt, int user_id,
			char is_del, int is_admin, Date updateed_at, String fileName) {
		super();
		this.sic_num = sic_num;
		this.sic_title = sic_title;
		this.content = content;
		this.writeday = writeday;
		this.readCnt = readCnt;
		this.user_id = user_id;
		this.is_del = is_del;
		this.is_admin = is_admin;
		this.updateed_at = updateed_at;
		this.fileName = fileName;
	}
	public int getSic_num() {
		return sic_num;
	}
	public void setSic_num(int sic_num) {
		this.sic_num = sic_num;
	}
	public String getSic_title() {
		return sic_title;
	}
	public void setSic_title(String sic_title) {
		this.sic_title = sic_title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public int getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public char getIs_del() {
		return is_del;
	}
	public void setIs_del(char is_del) {
		this.is_del = is_del;
	}
	public int getIs_admin() {
		return is_admin;
	}
	public void setIs_admin(int is_admin) {
		this.is_admin = is_admin;
	}
	public Date getUpdateed_at() {
		return updateed_at;
	}
	public void setUpdateed_at(Date updateed_at) {
		this.updateed_at = updateed_at;
	}
	@Override
	public String toString() {
		return "SicdanDTO [sic_num=" + sic_num + ", sic_title=" + sic_title + ", content=" + content + ", writeday="
				+ writeday + ", readCnt=" + readCnt + ", user_id=" + user_id + ", is_del=" + is_del + ", is_admin="
				+ is_admin + ", updateed_at=" + updateed_at + ", fileName=" + fileName + "]";
	}

	
}
