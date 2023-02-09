package com.itwillbs.project.mapper;

import java.util.ArrayList;
import java.util.List;

import com.itwillbs.project.vo.InSchedulePerProductVO;
import com.itwillbs.project.vo.InScheduleVO;
import com.itwillbs.project.vo.StockVo;

public interface In_ScheduleMapper {
	
	//입고 물품 목록 조회
	List<InScheduleVO> selectInscheduleList();
	// 입고 등록
	int insertInschedule(InScheduleVO ins);
	//입고예정 리스트
	List<InSchedulePerProductVO> getInschedulePerList();
	//진행 중 목록 조회
	List<InScheduleVO> selectInprogressList();
	//입고 수정 
	int updateInschedule(InScheduleVO ins);
	//진행 중 목록 조회
//	List<InScheduleVO> selectProcessingList();
	//
	int selectCode(InScheduleVO ins);
	int insertOutProduct(InSchedulePerProductVO insp2);

	InSchedulePerProductVO getInschedulePerInfo(InSchedulePerProductVO vo2);
	//-----------재고 번호 받아오기 (팝업창)-----------
	List<StockVo> searchStockNum(String keyword);
	void updateStockQTY(InSchedulePerProductVO vo);
	int insertStock(InSchedulePerProductVO insp);
	void updateInQTY(InSchedulePerProductVO insp);
	void updateIN_COMPLETE(InSchedulePerProductVO insp);
}
