package com.itwillbs.project.mapper;

import com.itwillbs.project.vo.EmpVo;

public interface EmpMapper {
	//------------인사 등록 작업-----------------
	int InsertEmployee(EmpVo emp);
	//---------사원코드에 인덱스 00X 작업을 위해 IDX를 가져오는 작업------------
	int getSelectIdx(EmpVo emp);

}
