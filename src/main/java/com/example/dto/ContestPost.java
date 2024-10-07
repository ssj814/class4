package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("Post")
public class ContestPost {
	 private String postid;
	    private String title;
	    private String content;
	    private String writer;
	    private String createdate;
	    private int viewcount;
		public ContestPost() {
			super();
			// TODO Auto-generated constructor stub
		}
		public ContestPost(String postid, String title, String content, String writer, String createdate, int viewcount) {
			super();
			this.postid = postid;
			this.title = title;
			this.content = content;
			this.writer = writer;
			this.createdate = createdate;
			this.viewcount = viewcount;
		}
		public String getPostid() {
			return postid;
		}
		public void setPostid(String postid) {
			this.postid = postid;
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
		public String getWriter() {
			return writer;
		}
		public void setWriter(String writer) {
			this.writer = writer;
		}
		public String getCreatedate() {
			return createdate;
		}
		public void setCreatedate(String createdate) {
			this.createdate = createdate;
		}
		public int getViewcount() {
			return viewcount;
		}
		public void setViewcount(int viewcount) {
			this.viewcount = viewcount;
		}
		@Override
		public String toString() {
			return "Post [postid=" + postid + ", title=" + title + ", content=" + content + ", writer=" + writer
					+ ", createdate=" + createdate + ", viewcount=" + viewcount + "]";
		}
	    
}
