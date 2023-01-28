package com.itwillbs.project.vo;
/*
 * mvc_board5 데이터베이스 생성 및 board 테이블 정의
    CREATE DATABASE mvc_board5;
    use mvc_board5
    
	CREATE TABLE board (
		board_num INT PRIMARY KEY,
		board_name VARCHAR(20) NOT NULL,
		board_pass VARCHAR(16) NOT NULL,
		board_subject VARCHAR(50) NOT NULL,
		board_content VARCHAR(2000) NOT NULL,
		board_file VARCHAR(200) NOT NULL,
		board_real_file VARCHAR(200) NOT NULL,
		board_re_ref INT NOT NULL,
		board_re_lev INT NOT NULL,
		board_re_seq INT NOT NULL,
		board_readcount INT DEFAULT 0,
		board_date DATETIME
	);
 * 
 * mvc_board3 데이터베이스의 board 테이블(게시판) 1개 레코드(= 1개 게시물) 정보를 저장하는
 * Bean 클래스(DTO or VO) 정의
 * 
 */

import java.sql.Timestamp;
import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class EmpVo {
	// board 테이블 컬럼에 대응하는 멤버변수 선언
	private int IDX;
	private String EMP_NUM;
	private String EMP_NAME;
	private String DEPT_CD;
	private String GRADE_CD;
	private String EMP_TEL; // 원본 파일명
	private String EMP_DTEL; // 실제 업로드 될 파일명(중복 처리된 파일명)
	private int EMP_EMAIL; // 원본글 번호
	private int EMP_PASSWD; // 들여쓰기 레벨
	private int EMP_POST_NO; // 순서번호
	private int EMP_ADDR;
	private Timestamp HIRE_DATE; // java.sql.TimeStamp
	private String WORK_CD;
	private String PRIV_CD;
	private MultipartFile PHOTO;
	
	
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
	public int getEMP_EMAIL() {
		return EMP_EMAIL;
	}
	public void setEMP_EMAIL(int eMP_EMAIL) {
		EMP_EMAIL = eMP_EMAIL;
	}
	public int getEMP_PASSWD() {
		return EMP_PASSWD;
	}
	public void setEMP_PASSWD(int eMP_PASSWD) {
		EMP_PASSWD = eMP_PASSWD;
	}
	public int getEMP_POST_NO() {
		return EMP_POST_NO;
	}
	public void setEMP_POST_NO(int eMP_POST_NO) {
		EMP_POST_NO = eMP_POST_NO;
	}
	public int getEMP_ADDR() {
		return EMP_ADDR;
	}
	public void setEMP_ADDR(int eMP_ADDR) {
		EMP_ADDR = eMP_ADDR;
	}
	public Timestamp getHIRE_DATE() {
		return HIRE_DATE;
	}
	public void setHIRE_DATE(Timestamp hIRE_DATE) {
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
	public MultipartFile getPHOTO() {
		return PHOTO;
	}
	public void setPHOTO(MultipartFile pHOTO) {
		PHOTO = pHOTO;
	}
	//-----------toString
	@Override
	public String toString() {
		return "BoardVO [IDX=" + IDX + ", EMP_NUM=" + EMP_NUM + ", EMP_NAME=" + EMP_NAME + ", DEPT_CD=" + DEPT_CD
				+ ", GRADE_CD=" + GRADE_CD + ", EMP_TEL=" + EMP_TEL + ", EMP_DTEL=" + EMP_DTEL + ", EMP_EMAIL="
				+ EMP_EMAIL + ", EMP_PASSWD=" + EMP_PASSWD + ", EMP_POST_NO=" + EMP_POST_NO + ", EMP_ADDR=" + EMP_ADDR
				+ ", HIRE_DATE=" + HIRE_DATE + ", WORK_CD=" + WORK_CD + ", PRIV_CD=" + PRIV_CD + ", PHOTO=" + PHOTO
				+ "]";
	}//toString 끝
	
	
	
	
	
	
}














