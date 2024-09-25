package com.example.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

@Alias("PageDTO")
public class PageDTO {
	private List<TrainerBoardDTO> list;
	private int curPage;
	private int perPage=5;
	private int totalCount;
	
	
	public PageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public PageDTO(List<TrainerBoardDTO> list, int curPage, int perPage, int totalCount) {
		super();
		this.list = list;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalCount = totalCount;
	}


	public List<TrainerBoardDTO> getList() {
		return list;
	}


	public void setList(List<TrainerBoardDTO> list) {
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
