package com.itwillbs.project.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.vo.InSchedulePerProductVO;
import com.itwillbs.project.vo.InScheduleVO;
import com.itwillbs.project.vo.ProductVO;
import com.itwillbs.project.vo.StockVo;
import com.itwillbs.project.vo.WareHouseVO;

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
	
	//------------- -----------------
	int selectCode(InScheduleVO ins);
	//------------- -----------------
	int insertOutProduct(InSchedulePerProductVO insp2);

	InSchedulePerProductVO getInschedulePerInfo(InSchedulePerProductVO vo2);
	
	//-----------재고 번호 받아오기 (모달창)-----------
	List<StockVo> searchStockNum(String keyword);
	//-----------창고 번호 받아오기 (모달창)-----------
	List<WareHouseVO> searchWarehouse(String keyword);
	
	//-------------재고 물량 증가-----------------
	void updateStockQTY(InSchedulePerProductVO vo);
	
	//-------------입고 처리 -----------------
	int insertStock(InSchedulePerProductVO insp);
	
	//-------------입고 수량 증가 -----------------
	int updateInQTY(InSchedulePerProductVO insp);
	
	//-------------입고 진행 여부 -----------------
	int updateIN_COMPLETE(InSchedulePerProductVO insp);
	
	//입고예정 상세정보
	InScheduleVO selectINInfo(String in_SCHEDULE_CD);
	
	//입고예정 상세정보(품목별)
	List<InSchedulePerProductVO> selectInProductList(String in_SCHEDULE_CD);
	
	//입고 예정 상품별 수정 
	int updateInschedulepro(InSchedulePerProductVO insp2);
	
	//종결버튼
	int updatecomplete(@Param("IN_COMPLETE") String IN_COMPLETE,@Param("IN_SCHEDULE_CD")  String IN_SCHEDULE_CD);
	
	//-------------재고 번호 가져오기 -----------------
	int getStock_cd(int in_SCHEDULE_PER_CD);


	//------------입고 처리 시 재고이력 남기기--------------
	int insertHistory(
			@Param("insert_qty") int insert_qty,
			@Param("stock_cd") String string, 
			@Param("product_cd") int product_cd, 
			@Param("sId") String sId);
	
	//-----입고리스트 상품 갯수 ---
	int selectExtraPdcount(String inSchCd);
	//-----입고리스트 상품 갯수 가져오기 -----
	int selectInPdName(String inSchCd);
	// ----입고 리스트 외 1건 처리 ----
	String selectInProduct(int checkCd);
	//---- 외 1건처리 
	String selectInSingle(int checkCd);
	
	List<ProductVO> selectProList1(String keyword);
	//입고 예정 개수 합계
	int selectInSum(String schCd);
	
	

}
