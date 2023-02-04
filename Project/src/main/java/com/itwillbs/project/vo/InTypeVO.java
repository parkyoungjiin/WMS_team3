package com.itwillbs.project.vo;

public class InTypeVO {

	private String IN_TYPE_CD; // 입고유형코드
	private String IN_TYPE_NAME; //입고유형명
	
	public String getIN_TYPE_CD() {
		return IN_TYPE_CD;
	}
	public void setIN_TYPE_CD(String iN_TYPE_CD) {
		IN_TYPE_CD = iN_TYPE_CD;
	}
	public String getIN_TYPE_NAME() {
		return IN_TYPE_NAME;
	}
	public void setIN_TYPE_NAME(String iN_TYPE_NAME) {
		IN_TYPE_NAME = iN_TYPE_NAME;
	}
	
	@Override
	public String toString() {
		return "InTypeVO [IN_TYPE_CD=" + IN_TYPE_CD + ", IN_TYPE_NAME=" + IN_TYPE_NAME + "]";
	}
}
