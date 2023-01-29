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
}
