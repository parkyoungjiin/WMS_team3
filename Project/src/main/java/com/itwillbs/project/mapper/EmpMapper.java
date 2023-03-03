package com.itwillbs.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.vo.EmpVo;

public interface EmpMapper {
	//------------인사 등록 작업-----------------
	int InsertEmployee(EmpVo emp);
	//---------사원코드에 인덱스 00X 작업을 위해 IDX를 가져오는 작업------------
	int getSelectIdx(EmpVo emp);
	
	//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기(로그인 시 )
	String getSelectPass(String emp_EMAIL);
	
	//로그인 시 재직자 판별을 위해 재직코드 가져오기
	String getSelectWorkCd(String emp_EMAIL);

	//세션에 저장할 이름값,권한코드,idx값 가져오기
	EmpVo getSelectName(String emp_EMAIL);
	//이메일 중복 체크
	Integer getEmailCheck(String check_email);

	// ----------검색용 사원 목록 출력-------------- String keyword
	List<EmpVo> selectEmployeeList(String keyword);

	//----------일반 사원목록 출력------------
	List<EmpVo> selectEmpList(
			@Param("keyword") String keyword,
			@Param("startRow") int startRow,
			@Param("listLimit") int listLimit);
	
	// --------- 사원목록 : 부서명------------
	String selectEmpDept(String dept_cd);
	
	// ---------- 사원목록 : 직급명 -------------------
	String selectEmpGrd(String grade_cd);
	
	// ---------- 권한 조회 -------------
	String selectPrivCode(String sId);
	
	// ----------사원 상세 정보--------------
	EmpVo selectEmployee(String EMP_NUM);

	// ---------- 사원 수정 -------------
	int updateEmployee(EmpVo employee);
	
	//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기(마이페이지에서 비밀번호 변경 시)
	String getSelectPasswd(String emp_num);
	
	//-------비밀번호 일치 시 변경----------
	int updatePasswd(@Param("emp_num") String emp_num, @Param("securePasswd") String securePasswd);
	
	//-------------세션아이디에 저장된 emp_num에 일치하는 회원정보를 변경----------
	int updateMypageInfo(@Param("emp") EmpVo emp, @Param("emp_num") String emp_num);
	
	//---------------------- 개별 파일 삭제----------------------------------- 
	int deleteImgFile(@Param("EMP_NUM")String EMP_NUM, @Param("PHOTO") String PHOTO);
	
	// ------------------------ 사원 목록 페이징 처리-----------------------------
	int selectBoardListCount(@Param("keyword") String keyword);

	
}
