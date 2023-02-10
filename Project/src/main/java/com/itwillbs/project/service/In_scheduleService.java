package com.itwillbs.project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.In_ScheduleMapper;
import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.InSchedulePerProductVO;
import com.itwillbs.project.vo.InScheduleVO;
import com.itwillbs.project.vo.StockVo;

@Service
public class In_scheduleService {
	@Autowired
	private In_ScheduleMapper mapper;
	
	//물품 리스트 
	public List<InScheduleVO> getInscheduleList() {
		return mapper.selectInscheduleList();
	}
	
	//입고 등록 
	public int registerInschedule(InScheduleVO ins) {
		return mapper.insertInschedule(ins);
	}
	//----------입고 예정 리스트----------
	public List<InSchedulePerProductVO> getInschedulePerList() {
		return mapper.getInschedulePerList();
	}//입고 예정 리스트 끝
	//
//	public List<InScheduleVO> getInprogressList() {
//		return mapper.selectInprogressList();
//	}
	//입고 수정pro
	public int modifyPro(InScheduleVO ins) {
		return mapper.updateInschedule(ins);
	}
	public int getSelectCode(InScheduleVO ins) {
		return mapper.selectCode(ins);
	}
	public int insertInProduct(InSchedulePerProductVO insp2) {
		return mapper.insertOutProduct(insp2);
	}
//	public List<InScheduleVO> getProcessingList() {
//		return mapper.selectProcessingList();
//	}
	public InScheduleVO getINInfo(String in_SCHEDULE_CD) {
		return mapper.selectINInfo(in_SCHEDULE_CD);
	}

	public List<InSchedulePerProductVO> getInProductList(String in_SCHEDULE_CD) {
		return mapper.selectInProductList(in_SCHEDULE_CD);
	}
// 품목별 수정 
	public int modifyPro2(InSchedulePerProductVO insp2) {
		return mapper.updateInschedulepro(insp2);
	}

	public InSchedulePerProductVO getInschedulePerInfo(InSchedulePerProductVO vo2) {
		return mapper.getInschedulePerInfo(vo2);
	}
//-----------재고 번호 받아오기 (팝업창)-----------
	public List<StockVo> getSerachStockNum(String keyword) {
		return mapper.searchStockNum(keyword);
	}

	public int updateclosing(String IN_COMPLETE, String IN_SCHEDULE_CD) {
		return mapper.updatecomplete(IN_COMPLETE,IN_SCHEDULE_CD);
	}
//진행상태 조회
	public List<InSchedulePerProductVO> getInProdList(String IN_SCHEDULE_CD) {
		return mapper.selectInProdList(IN_SCHEDULE_CD);
	}
}
