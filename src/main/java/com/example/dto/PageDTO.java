package com.example.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

@Alias("PageDTO")
public class PageDTO {
	private List<BoardPostsDTO> list;
	private int curPage; //현재페이지
	private int perPage=10; //페이징되는 갯수
	private int totalCount; //총페이지
	
	
	public PageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public PageDTO(List<BoardPostsDTO> list, int curPage, int perPage, int totalCount) {
		super();
		this.list = list;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalCount = totalCount;
	}


	public List<BoardPostsDTO> getList() {
		return list;
	}


	public void setList(List<BoardPostsDTO> list) {
		this.list = list;
	}


	public int getCurPage() {
		return curPage;
	}


	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}


	public int getPerPage() {
		return perPage;
	}


	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}


	public int getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}


	@Override
	public String toString() {
		return "pageDTO [list=" + list + ", curPage=" + curPage + ", perPage=" + perPage + ", totalCount=" + totalCount
				+ "]";
	}
	
	
    public int getTotalPages() {
        return (int) Math.ceil((double) totalCount / perPage);
    }
	
	
	
}
