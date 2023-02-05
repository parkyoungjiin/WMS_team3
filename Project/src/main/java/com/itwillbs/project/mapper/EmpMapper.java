package com.itwillbs.project.mapper;

import java.util.List;

import com.itwillbs.project.vo.EmpVo;

public interface EmpMapper {
	//------------인사 등록 작업-----------------
	int InsertEmployee(EmpVo emp);
	//---------사원코드에 인덱스 00X 작업을 위해 IDX를 가져오는 작업------------
	int getSelectIdx(EmpVo emp);
	
	//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
	String getSelectPass(String emp_EMAIL);
	//세션에 저장할 이름값,권한코드,idx값 가져오기
	EmpVo getSelectName(String emp_EMAIL);
	//이메일 중복 체크
	Integer getEmailCheck(String check_email);

	// ----------사원 목록 출력--------------
	List<EmpVo> selectEmployeeList(String keyword);

	// ---------- 권한 조회 -------------
	String selectPrivCode(String sId);
	
	// ----------사원 상세 정보--------------
	EmpVo selectEmployee(String EMP_NUM);

	// ---------- 사원 수정 -------------
	int updateEmployee(EmpVo employee);
	
}
