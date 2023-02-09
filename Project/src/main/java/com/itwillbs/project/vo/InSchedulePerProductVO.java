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
	private String PRODUCT_SIZE;
	private String[] PRODUCT_SIZEArr
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
	private String[] IN_COMPLETEArr;
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
	
	public void setPRODUCT_SIZE(String pRODUCT_SIZE) {
		PRODUCT_SIZE = pRODUCT_SIZE;
	}
	public void setPRODUCT_SIZEArr(String[] pRODUCT_SIZEArr) {
		PRODUCT_SIZEArr = pRODUCT_SIZEArr;
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
