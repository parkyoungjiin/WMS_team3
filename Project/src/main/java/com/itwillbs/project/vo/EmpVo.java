package com.itwillbs.project.vo;


import java.sql.Date;
import java.sql.Timestamp;
import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class EmpVo {
	// board 테이블 컬럼에 대응하는 멤버변수 선언
	private int IDX; //Auto Increment
	private String EMP_NUM;
	private String EMP_NAME;
	private String DEPT_CD; //부서코드
	private String DEPT_NAME; //부서명
	private String GRADE_CD; //직급코드
	private String EMP_TEL; //연락처(개인)
	private String EMP_DTEL; //연락처(사무실) 
	private String EMP_EMAIL; 
	private String EMP_PASSWD; 
	private String EMP_POST_NO; //우편번호 
	private String EMP_ADDR;//주소
	private Date HIRE_DATE; //입사일
	private String WORK_CD; //재직코드
	private String PRIV_CD; //권한코드
	private String PHOTO;
	private MultipartFile file;
	

	public int getIDX() {
		return IDX;
	}
	public void setIDX(int iDX) {
		IDX = iDX;
	}
	public String getEMP_NUM() {
		return EMP_NUM;
	}
	public void setEMP_NUM(String eMP_NUM) {
		EMP_NUM = eMP_NUM;
	}
	public String getEMP_NAME() {
		return EMP_NAME;
	}
	public void setEMP_NAME(String eMP_NAME) {
		EMP_NAME = eMP_NAME;
	}
	public String getDEPT_CD() {
		return DEPT_CD;
	}
	public void setDEPT_CD(String dEPT_CD) {
		DEPT_CD = dEPT_CD;
	}
	public String getDEPT_NAME() {
		return DEPT_NAME;
	}
	public void setDEPT_NAME(String dEPT_NAME) {
		DEPT_NAME = dEPT_NAME;
	}
	public String getGRADE_CD() {
		return GRADE_CD;
	}
	public void setGRADE_CD(String gRADE_CD) {
		GRADE_CD = gRADE_CD;
	}
	public String getEMP_TEL() {
		return EMP_TEL;
	}
	public void setEMP_TEL(String eMP_TEL) {
		EMP_TEL = eMP_TEL;
	}
	public String getEMP_DTEL() {
		return EMP_DTEL;
	}
	public void setEMP_DTEL(String eMP_DTEL) {
		EMP_DTEL = eMP_DTEL;
	}
	public String getEMP_EMAIL() {
		return EMP_EMAIL;
	}
	public void setEMP_EMAIL(String eMP_EMAIL) {
		EMP_EMAIL = eMP_EMAIL;
	}
	public String getEMP_PASSWD() {
		return EMP_PASSWD;
	}
	public void setEMP_PASSWD(String eMP_PASSWD) {
		EMP_PASSWD = eMP_PASSWD;
	}
	public String getEMP_POST_NO() {
		return EMP_POST_NO;
	}
	public void setEMP_POST_NO(String eMP_POST_NO) {
		EMP_POST_NO = eMP_POST_NO;
	}
	public String getEMP_ADDR() {
		return EMP_ADDR;
	}
	public void setEMP_ADDR(String eMP_ADDR) {
		EMP_ADDR = eMP_ADDR;
	}
	public Date getHIRE_DATE() {
		return HIRE_DATE;
	}
	public void setHIRE_DATE(Date hIRE_DATE) {
		HIRE_DATE = hIRE_DATE;
	}
	public String getWORK_CD() {
		return WORK_CD;
	}
	public void setWORK_CD(String wORK_CD) {
		WORK_CD = wORK_CD;
	}
	public String getPRIV_CD() {
		return PRIV_CD;
	}
	public void setPRIV_CD(String pRIV_CD) {
		PRIV_CD = pRIV_CD;
	}
	public String getPHOTO() {
		return PHOTO;
	}
	public void setPHOTO(String pHOTO) {
		PHOTO = pHOTO;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	@Override
	public String toString() {
		return "EmpVo [IDX=" + IDX + ", EMP_NUM=" + EMP_NUM + ", EMP_NAME=" + EMP_NAME + ", DEPT_CD=" + DEPT_CD
				+ ", DEPT_NAME=" + DEPT_NAME + ", GRADE_CD=" + GRADE_CD + ", EMP_TEL=" + EMP_TEL + ", EMP_DTEL="
				+ EMP_DTEL + ", EMP_EMAIL=" + EMP_EMAIL + ", EMP_PASSWD=" + EMP_PASSWD + ", EMP_POST_NO=" + EMP_POST_NO
				+ ", EMP_ADDR=" + EMP_ADDR + ", HIRE_DATE=" + HIRE_DATE + ", WORK_CD=" + WORK_CD + ", PRIV_CD="
				+ PRIV_CD + ", PHOTO=" + PHOTO + ", file=" + file + "]";
	}
	

	
	
	
	
	
	
}














