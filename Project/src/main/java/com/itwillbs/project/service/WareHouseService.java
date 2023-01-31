package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.WareHouseMapper;
import com.itwillbs.project.vo.WareHouseVO;

@Service
public class WareHouseService {
@Autowired
private WareHouseMapper mapper;

//------------창고 등록 작업-----------------
public boolean insertWh(WareHouseVO vo) {
	return mapper.insertWh(vo);
}//insertWh()끝
//------------창고 목록 작업-----------------
public List<WareHouseVO> getwhList() {
	return mapper.getwhList();
}//getwhList()끝
//------------창고 상세내용 작업-----------------
public WareHouseVO getWarehouse(String wh_cd) {
	return mapper.getWarehouse(wh_cd);
}//getWarehouse()끝
//------------창고 상세내용(이룸) 작업-----------------
public WareHouseVO getWarehouseName(String wh_cd, String wh_name) {
	return mapper.getWarehouseName(wh_cd,wh_name);
}//getWarehouseName()끝
//------------창고 수정 작업-----------------
public void whModify(WareHouseVO vo,String wh_cd) {
	mapper.whModify(vo,wh_cd);
}
public int getDB_wh_cd(String wh_cd) {
	return mapper.getDB_wh_cd(wh_cd);
}
	
}