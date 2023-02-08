package com.itwillbs.project.vo;

import java.sql.Date;
import java.util.Arrays;

public class InSchedulePerProductVO {

	private String IN_SCHEDULE_CD; //입고예정코드

	private String[] IN_SCHEDULE_CDArr; //입고예정코드
	private int PRODUCT_CD; //품목코드
	private int[] PRODUCT_CDArr; //품목코드
	private String PRODUCT_NAME; //품목명
	private String[] PRODUCT_NAMEArr; //품목명
	private String SIZE_DES; //규격
	private String[] SIZE_DESArr; //규격
	private int IN_SCHEDULE_QTY; //입고예정수량
	private int[] IN_SCHEDULE_QTYArr; //입고예정수량
	private int IN_QTY; //입고수량
	private int[] IN_QTYArr; //입고수량
	private Date IN_DATE; //납기일자
	private String[] IN_DATEArr; //납기일자
	private String REMARKS; //적요
	private String[] REMARKS_Arr; //적요
	private String STOCK_CD;
	private String[] STOCK_CDArr;
	private String IN_COMPLETE;
	public String getIN_SCHEDULE_CD() {
		return IN_SCHEDULE_CD;
	}

	public void setIN_SCHEDULE_CD(String iN_SCHEDULE_CD) {
		IN_SCHEDULE_CD = iN_SCHEDULE_CD;
	}
	public String[] getIN_SCHEDULE_CDArr() {
		return IN_SCHEDULE_CDArr;
	}
	public void setIN_SCHEDULE_CDArr(String[] iN_SCHEDULE_CDArr) {
		IN_SCHEDULE_CDArr = iN_SCHEDULE_CDArr;
	}
	public int getPRODUCT_CD() {
		return PRODUCT_CD;
	}
	public void setPRODUCT_CD(int pRODUCT_CD) {
		PRODUCT_CD = pRODUCT_CD;
	}

	public int[] getPRODUCT_CDArr() {
		return PRODUCT_CDArr;
	}
	public void setPRODUCT_CDArr(int[] pRODUCT_CDArr) {
		PRODUCT_CDArr = pRODUCT_CDArr;
	}
	public String getPRODUCT_NAME() {
		return PRODUCT_NAME;
	}
	public void setPRODUCT_NAME(String pRODUCT_NAME) {
		PRODUCT_NAME = pRODUCT_NAME;
	}
	public String[] getPRODUCT_NAMEArr() {
		return PRODUCT_NAMEArr;
	}

	public void setPRODUCT_NAMEArr(String[] pRODUCT_NAMEArr) {
		PRODUCT_NAMEArr = pRODUCT_NAMEArr;
	}
	public String getSIZE_DES() {
		return SIZE_DES;
	}
	public void setSIZE_DES(String sIZE_DES) {
		SIZE_DES = sIZE_DES;
	}
	public String[] getSIZE_DESArr() {
		return SIZE_DESArr;
	}
	public void setSIZE_DESArr(String[] sIZE_DESArr) {
		SIZE_DESArr = sIZE_DESArr;
	}
	public int getIN_SCHEDULE_QTY() {
		return IN_SCHEDULE_QTY;
	}
	public void setIN_SCHEDULE_QTY(int iN_SCHEDULE_QTY) {
		IN_SCHEDULE_QTY = iN_SCHEDULE_QTY;
	}
	public int[] getIN_SCHEDULE_QTYArr() {
		return IN_SCHEDULE_QTYArr;
	}
	public void setIN_SCHEDULE_QTYArr(int[] iN_SCHEDULE_QTYArr) {
		IN_SCHEDULE_QTYArr = iN_SCHEDULE_QTYArr;
	}
	public int getIN_QTY() {
		return IN_QTY;
	}
	public void setIN_QTY(int iN_QTY) {
		IN_QTY = iN_QTY;
	}
	public int[] getIN_QTYArr() {
		return IN_QTYArr;
	}
	public void setIN_QTYArr(int[] iN_QTYArr) {
		IN_QTYArr = iN_QTYArr;
	}
	public Date getIN_DATE() {
		return IN_DATE;
	}
	public void setIN_DATE(Date iN_DATE) {
		IN_DATE = iN_DATE;
	}
	public String[] getIN_DATEArr() {
		return IN_DATEArr;
	}
	public void setIN_DATEArr(String[] iN_DATEArr) {
		IN_DATEArr = iN_DATEArr;
	}
	public String getREMARKS() {
		return REMARKS;
	}
	public void setREMARKS(String rEMARKS) {
		REMARKS = rEMARKS;
	}
	public String[] getREMARKS_Arr() {
		return REMARKS_Arr;
	}
	public void setREMARKS_Arr(String[] rEMARKS_Arr) {
		REMARKS_Arr = rEMARKS_Arr;
	}
	public String getSTOCK_CD() {
		return STOCK_CD;
	}
	public void setSTOCK_CD(String sTOCK_CD) {
		STOCK_CD = sTOCK_CD;
	}
	public String[] getSTOCK_CDArr() {
		return STOCK_CDArr;
	}
	public void setSTOCK_CDArr(String[] sTOCK_CDArr) {
		STOCK_CDArr = sTOCK_CDArr;
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
				+ ", PRODUCT_CDArr=" + Arrays.toString(PRODUCT_CDArr) + ", PRODUCT_NAME=" + PRODUCT_NAME
				+ ", PRODUCT_NAMEArr=" + Arrays.toString(PRODUCT_NAMEArr) + ", PRODUCT_SIZE=" + PRODUCT_SIZE
				+ ", PRODUCT_SIZEArr=" + Arrays.toString(PRODUCT_SIZEArr) + ", IN_SCHEDULE_QTY=" + IN_SCHEDULE_QTY
				+ ", IN_SCHEDULE_QTYArr=" + Arrays.toString(IN_SCHEDULE_QTYArr) + ", IN_QTY=" + IN_QTY + ", IN_QTYArr="
				+ Arrays.toString(IN_QTYArr) + ", IN_DATE=" + IN_DATE + ", IN_DATEArr=" + Arrays.toString(IN_DATEArr)
				+ ", REMARKS=" + REMARKS + ", REMARKS_Arr=" + Arrays.toString(REMARKS_Arr) + ", STOCK_CD=" + STOCK_CD
				+ ", STOCK_CDArr=" + Arrays.toString(STOCK_CDArr) + ", IN_COMPLETE=" + IN_COMPLETE + ", IN_COMPLETEArr="
				+ Arrays.toString(IN_COMPLETEArr) + "]";

	}
	
	
	
}
