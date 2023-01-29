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
public WareHouseVO getWarehouse(String wh_ch) {
	return mapper.getWarehouse(wh_ch);
}//getWarehouse()끝
//------------창고 상세내용(이룸) 작업-----------------
public WareHouseVO getWarehouseName(String wh_ch, String wh_name) {
	return mapper.getWarehouseName(wh_ch,wh_name);
}//getWarehouseName()끝
	
}
