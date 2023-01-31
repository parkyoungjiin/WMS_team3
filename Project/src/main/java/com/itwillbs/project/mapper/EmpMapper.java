package com.itwillbs.project.mapper;

import com.itwillbs.project.vo.EmpVo;

public interface EmpMapper {
	//------------인사 등록 작업-----------------
	int InsertEmployee(EmpVo emp);
	//---------사원코드에 인덱스 00X 작업을 위해 IDX를 가져오는 작업------------
	int getSelectIdx(EmpVo emp);
	
	//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
	String getSelectPass(String emp_EMAIL);
	//세션에 저장할 이름값 가져오기
	EmpVo getSelectName(String emp_EMAIL);
	//이메일 중복 체크
	Integer getEmailCheck(String check_email);

}
