package com.itwillbs.project.vo;

import java.sql.Date;

public class InScheduleVO {

	private String IN_SCHEDULE_CD;  //입고예정코드
	private String IN_TYPE_CD; //입고유형코드
	private String BUSINESS_NO; //거래처코드
	private String EMP_NUM; //담당자(사원번호)
	private Date IN_DATE; //납기일자
	private String REMARKS; //적요
	private String IN_COMPLETE; //진행상태
	
	public String getIN_SCHEDULE_CD() {
		return IN_SCHEDULE_CD;
	}
	public void setIN_SCHEDULE_CD(String iN_SCHEDULE_CD) {
		IN_SCHEDULE_CD = iN_SCHEDULE_CD;
	}
	public String getIN_TYPE_CD() {
		return IN_TYPE_CD;
	}
	public void setIN_TYPE_CD(String iN_TYPE_CD) {
		IN_TYPE_CD = iN_TYPE_CD;
	}
	public String getBUSINESS_NO() {
		return BUSINESS_NO;
	}
	public void setBUSINESS_NO(String bUSINESS_NO) {
		BUSINESS_NO = bUSINESS_NO;
	}
	public String getEMP_NUM() {
		return EMP_NUM;
	}
	public void setEMP_NUM(String eMP_NUM) {
		EMP_NUM = eMP_NUM;
	}
	public Date getIN_DATE() {
		return IN_DATE;
	}
	public void setIN_DATE(Date iN_DATE) {
		IN_DATE = iN_DATE;
	}
	public String getREMARKS() {
		return REMARKS;
	}
	public void setREMARKS(String rEMARKS) {
		REMARKS = rEMARKS;
	}
	public String getIN_COMPLETE() {
		return IN_COMPLETE;
	}
	public void setIN_COMPLETE(String iN_COMPLETE) {
		IN_COMPLETE = iN_COMPLETE;
	}
	@Override
	public String toString() {
		return "InScheduleVO [IN_SCHEDULE_CD=" + IN_SCHEDULE_CD + ", IN_TYPE_CD=" + IN_TYPE_CD + ", BUSINESS_NO="
				+ BUSINESS_NO + ", EMP_NUM=" + EMP_NUM + ", IN_DATE=" + IN_DATE + ", REMARKS=" + REMARKS
				+ ", IN_COMPLETE=" + IN_COMPLETE + "]";
	}
	
}
