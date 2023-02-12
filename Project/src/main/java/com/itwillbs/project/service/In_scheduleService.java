package com.itwillbs.project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.In_ScheduleMapper;
import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.InSchedulePerProductVO;
import com.itwillbs.project.vo.InScheduleVO;
import com.itwillbs.project.vo.ProductVO;
import com.itwillbs.project.vo.StockVo;
import com.itwillbs.project.vo.WareHouseVO;

@Service
public class In_scheduleService {
	@Autowired
	private In_ScheduleMapper mapper;
	
	//물품 리스트 
	public List<InScheduleVO> getInscheduleList() {
		List<InScheduleVO> inSch = mapper.selectInscheduleList();
		
		for(int i=0; i<inSch.size(); i++) {
			String inSchCd = inSch.get(i).getIN_SCHEDULE_CD();
			int extraPdCount = mapper.selectExtraPdcount(inSchCd);
			int checkCd = mapper.selectInPdName(inSchCd);
			if(extraPdCount > 1) {
				String pdInfo = mapper.selectInProduct(checkCd);
				System.out.println("pdinfo확인"+pdInfo);
				inSch.get(i).setPRODUCT_NAME(pdInfo + " 외 " + (extraPdCount-1)+"건");
				
			}else {
				String pdInfo = mapper.selectInSingle(checkCd);
				inSch.get(i).setPRODUCT_NAME(pdInfo);
			}
		}
		
		for(int i=0; i<inSch.size(); i++) {
			String schCd = inSch.get(i).getIN_SCHEDULE_CD();
			int sumIn = mapper.selectInSum(schCd);
			inSch.get(i).setSUM_COUNT(sumIn);
			System.out.println("sumcount 확인 : " + sumIn);
		}
		return inSch;
//		return mapper.selectInscheduleList();
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
	//-----------재고 번호 받아오기 (팝업창)-----------
	public List<WareHouseVO> getSerachWareHouse(String keyword) {
		return mapper.searchWarehouse(keyword);
	}
//진행상태 조회
//	public List<InSchedulePerProductVO> getInProdList(String IN_SCHEDULE_CD) {
//		return mapper.selectInProdList(IN_SCHEDULE_CD);
//	}	
	//----------재고 테이블 수량 증가----------
	public void updateStockQTY(InSchedulePerProductVO vo) {
		mapper.updateStockQTY(vo);
		
	}
	
	//----------재고 테이블에 넣는 작업(입고 처리)----------
	public int insertStock(InSchedulePerProductVO insp) {
		return mapper.insertStock(insp);
	}
	
	//----------입고 수량 변경 ----------
	public int updateInQTY(InSchedulePerProductVO insp) {
		return mapper.updateInQTY(insp);
	}
	
	//----------입고 예정 수량 - 입고 수량 = 0 일 떄 1로 변경 ----------	
	public int updateIN_COMPLETE(InSchedulePerProductVO insp) {
		return mapper.updateIN_COMPLETE(insp);
	}
	//----------입고 처리 시 재고이력 등록----------
	public int getInsertHistory(int insert_qty, String string, int product_cd, String sId) {
		return mapper.insertHistory(insert_qty, string, product_cd, sId);
	}
	//-----------------종결 버튼----------------
	public int updateclosing(String IN_COMPLETE, String IN_SCHEDULE_CD) {
		return mapper.updatecomplete(IN_COMPLETE,IN_SCHEDULE_CD);
	}
	
	//----------재고 번호 불러오기 ----------
	public int getStock_cd(int in_SCHEDULE_PER_CD) {
		
		return mapper.getStock_cd(in_SCHEDULE_PER_CD);
	}

	//--------진행상태---------- 
	public List<InSchedulePerProductVO> getInProdList(String iN_SCHEDULE_CD) {
		return mapper.selectInProductList(iN_SCHEDULE_CD);
	}

	// 입고 예정 리스트 외1건처리
	public List<InScheduleVO> getInSchedule() {
		List<InScheduleVO> inSch = mapper.selectInscheduleList();
		
		for(int i=0; i<inSch.size(); i++) {
			String inSchCd = inSch.get(i).getIN_SCHEDULE_CD();
			int extraPdCount = mapper.selectExtraPdcount(inSchCd);
			int checkCd = mapper.selectInPdName(inSchCd);
			if(extraPdCount > 1) {
				String pdInfo = mapper.selectInProduct(checkCd);
				System.out.println("pdinfo확인"+pdInfo);
				inSch.get(i).setPRODUCT_NAME(pdInfo + "외" + (extraPdCount-1)+"건");
				
			}else {
				String pdInfo = mapper.selectInSingle(checkCd);
				inSch.get(i).setPRODUCT_NAME(pdInfo);
			}
		}
		
		for(int i=0; i<inSch.size(); i++) {
			String schCd = inSch.get(i).getIN_SCHEDULE_CD();
			int sumIn = mapper.selectInSum(schCd);
			inSch.get(i).setSUM_COUNT(sumIn);
			System.out.println("sumcount 확인 : " + sumIn);
		}
		return inSch;
	}

	public List<ProductVO> getProductList1(String keyword) {
		// TODO Auto-generated method stub
		return mapper.selectProList1(keyword);
	}
}
