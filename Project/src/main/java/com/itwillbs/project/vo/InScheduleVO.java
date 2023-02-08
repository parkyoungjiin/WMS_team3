package com.itwillbs.project.vo;

import java.sql.Date;

public class InScheduleVO {
	private Date IN_SCHEDULE_DATE;
	private String IN_SCHEDULE_CD;
	private String IN_TYPE_CD;
	private String BUSINESS_NO;
	private String CUST_NAME;
	private String EMP_NUM;
	private String EMP_NAME;
	private String PRODUCT_NAME;
	private Date IN_DATE;
	private String REMARKS;
	private String IN_COMPLETE;
	public Date getIN_SCHEDULE_DATE() {
		return IN_SCHEDULE_DATE;
	}
	public String getIN_SCHEDULE_CD() {
		return IN_SCHEDULE_CD;
	}
	public String getIN_TYPE_CD() {
		return IN_TYPE_CD;
	}
	public String getBUSINESS_NO() {
		return BUSINESS_NO;
	}
	public String getCUST_NAME() {
		return CUST_NAME;
	}
	public String getEMP_NUM() {
		return EMP_NUM;
	}
	public String getEMP_NAME() {
		return EMP_NAME;
	}
	public String getPRODUCT_NAME() {
		return PRODUCT_NAME;
	}
	public Date getIN_DATE() {
		return IN_DATE;
	}
	public String getREMARKS() {
		return REMARKS;
	}
	public String getIN_COMPLETE() {
		return IN_COMPLETE;
	}
	public void setIN_SCHEDULE_DATE(Date iN_SCHEDULE_DATE) {
		IN_SCHEDULE_DATE = iN_SCHEDULE_DATE;
	}
	public void setIN_SCHEDULE_CD(String iN_SCHEDULE_CD) {
		IN_SCHEDULE_CD = iN_SCHEDULE_CD;
	}
	public void setIN_TYPE_CD(String iN_TYPE_CD) {
		IN_TYPE_CD = iN_TYPE_CD;
	}
	public void setBUSINESS_NO(String bUSINESS_NO) {
		BUSINESS_NO = bUSINESS_NO;
	}
	public void setCUST_NAME(String cUST_NAME) {
		CUST_NAME = cUST_NAME;
	}
	public void setEMP_NUM(String eMP_NUM) {
		EMP_NUM = eMP_NUM;
	}
	public void setEMP_NAME(String eMP_NAME) {
		EMP_NAME = eMP_NAME;
	}
	public void setPRODUCT_NAME(String pRODUCT_NAME) {
		PRODUCT_NAME = pRODUCT_NAME;
	}
	public void setIN_DATE(Date iN_DATE) {
		IN_DATE = iN_DATE;
	}
	public void setREMARKS(String rEMARKS) {
		REMARKS = rEMARKS;
	}
	public void setIN_COMPLETE(String iN_COMPLETE) {
		IN_COMPLETE = iN_COMPLETE;
	}
	@Override
	public String toString() {
		return "InScheduleVO [IN_SCHEDULE_DATE=" + IN_SCHEDULE_DATE + ", IN_SCHEDULE_CD=" + IN_SCHEDULE_CD
				+ ", IN_TYPE_CD=" + IN_TYPE_CD + ", BUSINESS_NO=" + BUSINESS_NO + ", CUST_NAME=" + CUST_NAME
				+ ", EMP_NUM=" + EMP_NUM + ", EMP_NAME=" + EMP_NAME + ", PRODUCT_NAME=" + PRODUCT_NAME + ", IN_DATE="
				+ IN_DATE + ", REMARKS=" + REMARKS + ", IN_COMPLETE=" + IN_COMPLETE + "]";
	}
	
	
	
	}
	

