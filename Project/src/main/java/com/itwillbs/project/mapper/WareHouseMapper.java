package com.itwillbs.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.vo.EmpVo;
import com.itwillbs.project.vo.WareHouseVO;

public interface WareHouseMapper {
	//------------창고 등록 작업-----------------
	boolean insertWh(WareHouseVO vo);
	//------------창고 목록 조회 작업-----------------
	List<WareHouseVO> getwhList();
	//------------창고 상세 내용 작업-----------------
	WareHouseVO getWarehouse(String wh_ch);
	//------------창고 상세 내용(이름) 작업-----------------
	WareHouseVO getWarehouseName(@Param("wh_cd") String wh_cd,
								@Param("wh_name")String wh_name
								);
	void whModify(String wh_cd);

}
