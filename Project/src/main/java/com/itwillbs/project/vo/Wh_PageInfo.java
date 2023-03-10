package com.itwillbs.project.vo;

public class Wh_PageInfo {
	private int listCount;
	private int pageListLimit;
	private int maxPage;
	private int startPage;
	private int endPage;
	private String pageNum;
	public Wh_PageInfo() {}
	
	
	public Wh_PageInfo(int listCount, int pageListLimit, int maxPage, int startPage, int endPage, String pageNum) {
		this.listCount = listCount;
		this.pageListLimit = pageListLimit;
		this.maxPage = maxPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.pageNum = pageNum;
	}


	

	public String getPageNum() {
		return pageNum;
	}
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getPageListLimit() {
		return pageListLimit;
	}
	public void setPageListLimit(int pageListLimit) {
		this.pageListLimit = pageListLimit;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	@Override
	public String toString() {
		return "PageInfo [listCount=" + listCount + ", pageListLimit=" + pageListLimit + ", maxPage=" + maxPage
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", pageNum=" + pageNum + "]";
	}
	
}
