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
	
	////---------- ----------
	public int getSelectCode(InScheduleVO ins) {
		return mapper.selectCode(ins);
	}
	
	//---------- ----------
	public int insertInProduct(InSchedulePerProductVO insp2) {
		return mapper.insertOutProduct(insp2);
	}
//	public List<InScheduleVO> getProcessingList() {
//		return mapper.selectProcessingList();
//	}
	//---------- ----------
	
	public InScheduleVO getINInfo(String in_SCHEDULE_CD) {
		return mapper.selectINInfo(in_SCHEDULE_CD);
	}
	
	////---------- ----------
	public List<InSchedulePerProductVO> getInProductList(String in_SCHEDULE_CD) {
		return mapper.selectInProductList(in_SCHEDULE_CD);
	}
	
	//----------입고 품목 수정----------
	public int modifyPro2(InSchedulePerProductVO insp2) {
		return mapper.updateInschedulepro(insp2);
	}
	
	//----------선택 된 항목 불러오기----------
	public InSchedulePerProductVO getInschedulePerInfo(InSchedulePerProductVO vo2) {
		return mapper.getInschedulePerInfo(vo2);
	}
	
	//-----------재고 번호 받아오기 (팝업창)-----------
	public List<StockVo> getSerachStockNum(String keyword) {
		return mapper.searchStockNum(keyword);
	}
	
	//----------재고 테이블 수량 증가----------
	public void updateStockQTY(InSchedulePerProductVO vo) {
		mapper.updateStockQTY(vo);
		
	}
	
	//----------재고 테이블에 넣는 작업(입고 처리)----------
	public int insertStock(InSchedulePerProductVO insp) {
		return mapper.insertStock(insp);
	}
	
	//----------입고 수량 변경 ----------
	public void updateInQTY(InSchedulePerProductVO insp) {
		mapper.updateInQTY(insp);
	}
	
	//----------입고 예정 수량 - 입고 수량 = 0 일 떄 1로 변경 ----------	
	public void updateIN_COMPLETE(InSchedulePerProductVO insp) {
		mapper.updateIN_COMPLETE(insp);
	}
	
	//-----------------종결 버튼----------------
	public int updateclosing(String iN_COMPLETE, String iN_SCHEDULE_CD) {
		return mapper.updatecomplete(iN_COMPLETE,iN_SCHEDULE_CD);
	}
	
	//----------재고 번호 불러오기 ----------
	public int getStock_cd(int in_SCHEDULE_PER_CD) {
		// TODO Auto-generated method stub
		return mapper.getStock_cd(in_SCHEDULE_PER_CD);
	}
}
