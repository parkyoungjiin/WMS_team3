package com.itwillbs.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.vo.OutSchedulePerProductVO;
import com.itwillbs.project.vo.OutScheduleVO;
import com.itwillbs.project.vo.ProductVO;
import com.itwillbs.project.vo.StockVo;

public interface Out_ScheduleMapper {

	List<ProductVO> selectProList(String keyword);

	List<StockVo> selectStoList(String keyword);

	int selectCode(OutScheduleVO os);

	int insertSchedule(OutScheduleVO os);

	int insertOutProduct(OutSchedulePerProductVO osp2);
	
	// 출고예정 목록 조회
	List<OutScheduleVO> selectOutScheduleList();
	
	// 출고예정 목록 - 상품별
	List<OutSchedulePerProductVO> selectOutProdList(String out_schedule_cd);

	//출고예정 폼 바꾸

	int updateStatus(@Param("out_complete") String out_complete, 
					@Param("out_schedule_cd")String out_schedule_cd);

	int updateStatus(String out_complete);

	// 출고 예정 상세 정보
	OutScheduleVO selectOSInfo(String out_schedule_cd);

	// 출고 예정 수정
	int updateOS(OutScheduleVO os);

	// 출고 예정 상품별 수정
	int updateOSPro(OutSchedulePerProductVO osp2);

	// 출고 처리 목록
	List<OutSchedulePerProductVO> selectOsProList();

	// 출고 처리 품목 정보
	OutSchedulePerProductVO selectOsProInfo(OutSchedulePerProductVO vo2);

	
}
