package com.itwillbs.project.vo;

import java.sql.Date;
import java.util.Arrays;
import java.util.List;

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
	private int STOCK_CD;
	private int[] STOCK_CDArr;
	private String IN_COMPLETE;
	private int IN_SCHEDULE_PER_CD;
	private int[] IN_SCHEDULE_PER_CDArr;
	private String WH_AREA_WH_LOC;
	private String[] WH_AREA_WH_LOCArr;
	private String WH_AREA;
	private String[] WH_AREAArr;
	private String WH_LOC_IN_AREA;
	private String[] WH_LOC_IN_AREAArr;
	private int WH_LOC_IN_AREA_CD;
	private int[] WH_LOC_IN_AREA_CDArr;
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
	public int getSTOCK_CD() {
		return STOCK_CD;
	}
	public void setSTOCK_CD(int sTOCK_CD) {
		STOCK_CD = sTOCK_CD;
	}
	public int[] getSTOCK_CDArr() {
		return STOCK_CDArr;
	}
	public void setSTOCK_CDArr(int[] sTOCK_CDArr) {
		STOCK_CDArr = sTOCK_CDArr;
	}
	public String getIN_COMPLETE() {
		return IN_COMPLETE;
	}
	public void setIN_COMPLETE(String iN_COMPLETE) {
		IN_COMPLETE = iN_COMPLETE;
	}
	public int getIN_SCHEDULE_PER_CD() {
		return IN_SCHEDULE_PER_CD;
	}
	public void setIN_SCHEDULE_PER_CD(int iN_SCHEDULE_PER_CD) {
		IN_SCHEDULE_PER_CD = iN_SCHEDULE_PER_CD;
	}
	public int[] getIN_SCHEDULE_PER_CDArr() {
		return IN_SCHEDULE_PER_CDArr;
	}
	public void setIN_SCHEDULE_PER_CDArr(int[] iN_SCHEDULE_PER_CDArr) {
		IN_SCHEDULE_PER_CDArr = iN_SCHEDULE_PER_CDArr;
	}
	public String getWH_AREA_WH_LOC() {
		return WH_AREA_WH_LOC;
	}
	public void setWH_AREA_WH_LOC(String wH_AREA_WH_LOC) {
		WH_AREA_WH_LOC = wH_AREA_WH_LOC;
	}
	public String[] getWH_AREA_WH_LOCArr() {
		return WH_AREA_WH_LOCArr;
	}
	public void setWH_AREA_WH_LOCArr(String[] wH_AREA_WH_LOCArr) {
		WH_AREA_WH_LOCArr = wH_AREA_WH_LOCArr;
	}
	public String getWH_AREA() {
		return WH_AREA;
	}
	public void setWH_AREA(String wH_AREA) {
		WH_AREA = wH_AREA;
	}
	public String[] getWH_AREAArr() {
		return WH_AREAArr;
	}
	public void setWH_AREAArr(String[] wH_AREAArr) {
		WH_AREAArr = wH_AREAArr;
	}
	public String getWH_LOC_IN_AREA() {
		return WH_LOC_IN_AREA;
	}
	public void setWH_LOC_IN_AREA(String wH_LOC_IN_AREA) {
		WH_LOC_IN_AREA = wH_LOC_IN_AREA;
	}
	public String[] getWH_LOC_IN_AREAArr() {
		return WH_LOC_IN_AREAArr;
	}
	public void setWH_LOC_IN_AREAArr(String[] wH_LOC_IN_AREAArr) {
		WH_LOC_IN_AREAArr = wH_LOC_IN_AREAArr;
	}
	public int getWH_LOC_IN_AREA_CD() {
		return WH_LOC_IN_AREA_CD;
	}
	public void setWH_LOC_IN_AREA_CD(int wH_LOC_IN_AREA_CD) {
		WH_LOC_IN_AREA_CD = wH_LOC_IN_AREA_CD;
	}
	public int[] getWH_LOC_IN_AREA_CDArr() {
		return WH_LOC_IN_AREA_CDArr;
	}
	public void setWH_LOC_IN_AREA_CDArr(int[] wH_LOC_IN_AREA_CDArr) {
		WH_LOC_IN_AREA_CDArr = wH_LOC_IN_AREA_CDArr;
	}
	@Override
	public String toString() {
		return "InSchedulePerProductVO [IN_SCHEDULE_CD=" + IN_SCHEDULE_CD + ", IN_SCHEDULE_CDArr="
				+ Arrays.toString(IN_SCHEDULE_CDArr) + ", PRODUCT_CD=" + PRODUCT_CD + ", PRODUCT_CDArr="
				+ Arrays.toString(PRODUCT_CDArr) + ", PRODUCT_NAME=" + PRODUCT_NAME + ", PRODUCT_NAMEArr="
				+ Arrays.toString(PRODUCT_NAMEArr) + ", SIZE_DES=" + SIZE_DES + ", SIZE_DESArr="
				+ Arrays.toString(SIZE_DESArr) + ", IN_SCHEDULE_QTY=" + IN_SCHEDULE_QTY + ", IN_SCHEDULE_QTYArr="
				+ Arrays.toString(IN_SCHEDULE_QTYArr) + ", IN_QTY=" + IN_QTY + ", IN_QTYArr="
				+ Arrays.toString(IN_QTYArr) + ", IN_DATE=" + IN_DATE + ", IN_DATEArr=" + Arrays.toString(IN_DATEArr)
				+ ", REMARKS=" + REMARKS + ", REMARKS_Arr=" + Arrays.toString(REMARKS_Arr) + ", STOCK_CD=" + STOCK_CD
				+ ", STOCK_CDArr=" + Arrays.toString(STOCK_CDArr) + ", IN_COMPLETE=" + IN_COMPLETE
				+ ", IN_SCHEDULE_PER_CD=" + IN_SCHEDULE_PER_CD + ", IN_SCHEDULE_PER_CDArr="
				+ Arrays.toString(IN_SCHEDULE_PER_CDArr) + ", WH_AREA_WH_LOC=" + WH_AREA_WH_LOC + ", WH_AREA_WH_LOCArr="
				+ Arrays.toString(WH_AREA_WH_LOCArr) + ", WH_AREA=" + WH_AREA + ", WH_AREAArr="
				+ Arrays.toString(WH_AREAArr) + ", WH_LOC_IN_AREA=" + WH_LOC_IN_AREA + ", WH_LOC_IN_AREAArr="
				+ Arrays.toString(WH_LOC_IN_AREAArr) + ", WH_LOC_IN_AREA_CD=" + WH_LOC_IN_AREA_CD
				+ ", WH_LOC_IN_AREA_CDArr=" + Arrays.toString(WH_LOC_IN_AREA_CDArr) + "]";
	}
}
