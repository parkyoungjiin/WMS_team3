package com.itwillbs.project.vo;

import java.sql.Date;
import java.util.Arrays;
import java.util.List;

public class InSchedulePerProductVO {

	
	private int IN_SCHEDULE_PER_CD;
	private int[] IN_SCHEDULE_PER_CDArr;
	private String IN_SCHEDULE_CD;
	private int PRODUCT_CD;
	private int[] PRODUCT_CDArr;
	private String PRODUCT_NAME;
	private String[] PRODUCT_NAMEArr;
	private String PRODUCT_SIZE;
	private String[] PRODUCT_SIZEArr;
	private int IN_SCHEDULE_QTY;
	private int[] IN_SCHEDULE_QTYArr;
	private int IN_QTY;
	private int[] IN_QTYArr;
	private Date IN_DATE;
	private Date[] IN_DATEArr;
	private String REMARKS;
	private String[] REMARKSArr;
	private String STOCK_CD;
	private String[] STOCK_CDArr;
	private String IN_COMPLETE;
	private String[] IN_COMPLETEArr;
	public int getIN_SCHEDULE_PER_CD() {
		return IN_SCHEDULE_PER_CD;
	}
	public int[] getIN_SCHEDULE_PER_CDArr() {
		return IN_SCHEDULE_PER_CDArr;
	}
	public String getIN_SCHEDULE_CD() {
		return IN_SCHEDULE_CD;
	}
	public int getPRODUCT_CD() {
		return PRODUCT_CD;
	}
	public int[] getPRODUCT_CDArr() {
		return PRODUCT_CDArr;
	}
	public String getPRODUCT_NAME() {
		return PRODUCT_NAME;
	}
	public String[] getPRODUCT_NAMEArr() {
		return PRODUCT_NAMEArr;
	}
	public String getPRODUCT_SIZE() {
		return PRODUCT_SIZE;
	}
	public String[] getPRODUCT_SIZEArr() {
		return PRODUCT_SIZEArr;
	}
	public int getIN_SCHEDULE_QTY() {
		return IN_SCHEDULE_QTY;
	}
	public int[] getIN_SCHEDULE_QTYArr() {
		return IN_SCHEDULE_QTYArr;
	}
	public int getIN_QTY() {
		return IN_QTY;
	}
	public int[] getIN_QTYArr() {
		return IN_QTYArr;
	}
	public Date getIN_DATE() {
		return IN_DATE;
	}
	public Date[] getIN_DATEArr() {
		return IN_DATEArr;
	}
	public String getREMARKS() {
		return REMARKS;
	}
	public String[] getREMARKSArr() {
		return REMARKSArr;
	}
	public String getSTOCK_CD() {
		return STOCK_CD;
	}
	public String[] getSTOCK_CDArr() {
		return STOCK_CDArr;
	}
	public String getIN_COMPLETE() {
		return IN_COMPLETE;
	}
	public String[] getIN_COMPLETEArr() {
		return IN_COMPLETEArr;
	}
	public void setIN_SCHEDULE_PER_CD(int iN_SCHEDULE_PER_CD) {
		IN_SCHEDULE_PER_CD = iN_SCHEDULE_PER_CD;
	}
	public void setIN_SCHEDULE_PER_CDArr(int[] iN_SCHEDULE_PER_CDArr) {
		IN_SCHEDULE_PER_CDArr = iN_SCHEDULE_PER_CDArr;
	}
	public void setIN_SCHEDULE_CD(String iN_SCHEDULE_CD) {
		IN_SCHEDULE_CD = iN_SCHEDULE_CD;
	}
	public void setPRODUCT_CD(int pRODUCT_CD) {
		PRODUCT_CD = pRODUCT_CD;
	}
	public void setPRODUCT_CDArr(int[] pRODUCT_CDArr) {
		PRODUCT_CDArr = pRODUCT_CDArr;
	}
	public void setPRODUCT_NAME(String pRODUCT_NAME) {
		PRODUCT_NAME = pRODUCT_NAME;
	}
	public void setPRODUCT_NAMEArr(String[] pRODUCT_NAMEArr) {
		PRODUCT_NAMEArr = pRODUCT_NAMEArr;
	}
	public void setPRODUCT_SIZE(String pRODUCT_SIZE) {
		PRODUCT_SIZE = pRODUCT_SIZE;
	}
	public void setPRODUCT_SIZEArr(String[] pRODUCT_SIZEArr) {
		PRODUCT_SIZEArr = pRODUCT_SIZEArr;
	}
	public void setIN_SCHEDULE_QTY(int iN_SCHEDULE_QTY) {
		IN_SCHEDULE_QTY = iN_SCHEDULE_QTY;
	}
	public void setIN_SCHEDULE_QTYArr(int[] iN_SCHEDULE_QTYArr) {
		IN_SCHEDULE_QTYArr = iN_SCHEDULE_QTYArr;
	}
	public void setIN_QTY(int iN_QTY) {
		IN_QTY = iN_QTY;
	}
	public void setIN_QTYArr(int[] iN_QTYArr) {
		IN_QTYArr = iN_QTYArr;
	}
	public void setIN_DATE(Date iN_DATE) {
		IN_DATE = iN_DATE;
	}
	public void setIN_DATEArr(Date[] iN_DATEArr) {
		IN_DATEArr = iN_DATEArr;
	}
	public void setREMARKS(String rEMARKS) {
		REMARKS = rEMARKS;
	}
	public void setREMARKSArr(String[] rEMARKSArr) {
		REMARKSArr = rEMARKSArr;
	}
	public void setSTOCK_CD(String sTOCK_CD) {
		STOCK_CD = sTOCK_CD;
	}
	public void setSTOCK_CDArr(String[] sTOCK_CDArr) {
		STOCK_CDArr = sTOCK_CDArr;
	}
	public void setIN_COMPLETE(String iN_COMPLETE) {
		IN_COMPLETE = iN_COMPLETE;
	}
	public void setIN_COMPLETEArr(String[] iN_COMPLETEArr) {
		IN_COMPLETEArr = iN_COMPLETEArr;
	}
	@Override
	public String toString() {
		return "InSchedulePerProductVO [IN_SCHEDULE_PER_CD=" + IN_SCHEDULE_PER_CD + ", IN_SCHEDULE_PER_CDArr="
				+ Arrays.toString(IN_SCHEDULE_PER_CDArr) + ", IN_SCHEDULE_CD=" + IN_SCHEDULE_CD + ", PRODUCT_CD="
				+ PRODUCT_CD + ", PRODUCT_CDArr=" + Arrays.toString(PRODUCT_CDArr) + ", PRODUCT_NAME=" + PRODUCT_NAME
				+ ", PRODUCT_NAMEArr=" + Arrays.toString(PRODUCT_NAMEArr) + ", PRODUCT_SIZE=" + PRODUCT_SIZE
				+ ", PRODUCT_SIZEArr=" + Arrays.toString(PRODUCT_SIZEArr) + ", IN_SCHEDULE_QTY=" + IN_SCHEDULE_QTY
				+ ", IN_SCHEDULE_QTYArr=" + Arrays.toString(IN_SCHEDULE_QTYArr) + ", IN_QTY=" + IN_QTY + ", IN_QTYArr="
				+ Arrays.toString(IN_QTYArr) + ", IN_DATE=" + IN_DATE + ", IN_DATEArr=" + Arrays.toString(IN_DATEArr)
				+ ", REMARKS=" + REMARKS + ", REMARKSArr=" + Arrays.toString(REMARKSArr) + ", STOCK_CD=" + STOCK_CD
				+ ", STOCK_CDArr=" + Arrays.toString(STOCK_CDArr) + ", IN_COMPLETE=" + IN_COMPLETE + ", IN_COMPLETEArr="
				+ Arrays.toString(IN_COMPLETEArr) + "]";
	}

	
}
