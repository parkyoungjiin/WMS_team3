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
	}//InsertEmployee
}
