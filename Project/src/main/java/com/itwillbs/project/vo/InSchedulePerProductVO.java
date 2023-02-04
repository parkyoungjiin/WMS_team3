package com.itwillbs.project.vo;

import java.sql.Date;

public class InSchedulePerProductVO {

	private String IN_SCHEDULE_CD; //입고예정코드
	private Number PRODUCT_CD; //품목코드
	private String PRODUCT_NAME; //품목명
	private String SIZE_DES; //규격
	private Number IN_SCHEDULE_QTY; //입고예정수량
	private Number IN_QTY; //입고수량
	private Date IN_DATE; //납기일자
	private String REMARKS; //적요
	private Number WH_LOC_IN_AREA_CD; //창고구역 내 위치코드
	private String IN_COMPLETE; //진행상태
	
	public String getIN_SCHEDULE_CD() {
		return IN_SCHEDULE_CD;
	}
	public void setIN_SCHEDULE_CD(String iN_SCHEDULE_CD) {
		IN_SCHEDULE_CD = iN_SCHEDULE_CD;
	}
	public Number getPRODUCT_CD() {
		return PRODUCT_CD;
	}
	public void setPRODUCT_CD(Number pRODUCT_CD) {
		PRODUCT_CD = pRODUCT_CD;
	}
	public String getPRODUCT_NAME() {
		return PRODUCT_NAME;
	}
	public void setPRODUCT_NAME(String pRODUCT_NAME) {
		PRODUCT_NAME = pRODUCT_NAME;
	}
	public String getSIZE_DES() {
		return SIZE_DES;
	}
	public void setSIZE_DES(String sIZE_DES) {
		SIZE_DES = sIZE_DES;
	}
	public Number getIN_SCHEDULE_QTY() {
		return IN_SCHEDULE_QTY;
	}
	public void setIN_SCHEDULE_QTY(Number iN_SCHEDULE_QTY) {
		IN_SCHEDULE_QTY = iN_SCHEDULE_QTY;
	}
	public Number getIN_QTY() {
		return IN_QTY;
	}
	public void setIN_QTY(Number iN_QTY) {
		IN_QTY = iN_QTY;
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
	public Number getWH_LOC_IN_AREA_CD() {
		return WH_LOC_IN_AREA_CD;
	}
	public void setWH_LOC_IN_AREA_CD(Number wH_LOC_IN_AREA_CD) {
		WH_LOC_IN_AREA_CD = wH_LOC_IN_AREA_CD;
	}
	public String getIN_COMPLETE() {
		return IN_COMPLETE;
	}
	public void setIN_COMPLETE(String iN_COMPLETE) {
		IN_COMPLETE = iN_COMPLETE;
	}
	@Override
	public String toString() {
		return "InSchedulePerProductVO [IN_SCHEDULE_CD=" + IN_SCHEDULE_CD + ", PRODUCT_CD=" + PRODUCT_CD
				+ ", PRODUCT_NAME=" + PRODUCT_NAME + ", SIZE_DES=" + SIZE_DES + ", IN_SCHEDULE_QTY=" + IN_SCHEDULE_QTY
				+ ", IN_QTY=" + IN_QTY + ", IN_DATE=" + IN_DATE + ", REMARKS=" + REMARKS + ", WH_LOC_IN_AREA_CD="
				+ WH_LOC_IN_AREA_CD + ", IN_COMPLETE=" + IN_COMPLETE + "]";
	}
	
}
