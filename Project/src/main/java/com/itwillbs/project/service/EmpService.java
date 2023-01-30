package com.itwillbs.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.EmpMapper;
import com.itwillbs.project.vo.EmpVo;

@Service
public class EmpService {
	@Autowired
	private EmpMapper mapper;
	//------------인사 등록 작업-----------------
	public int InsertEmployee(EmpVo emp) {
		return mapper.InsertEmployee(emp);
	}//InsertEmployee 끝
	
	//---------사원코드에 인덱스 00X 작업을 위해 IDX를 가져오는 작업------------
	public int getSelectIdx(EmpVo emp) {
		return mapper.getSelectIdx(emp);
	}//getSelectIdx 끝
	
	//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
	public String getSelectPass(String emp_EMAIL) {
		return mapper.getSelectPass(emp_EMAIL);
	}
	//세션에 저장할 이름값 가져오기
	public String getSelectName(String emp_EMAIL) {
		return mapper.getSelectName(emp_EMAIL);
	}
}
