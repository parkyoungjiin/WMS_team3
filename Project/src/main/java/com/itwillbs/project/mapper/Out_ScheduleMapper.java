package com.itwillbs.project.mapper;

import java.util.List;

import com.itwillbs.project.vo.OutSchedulePerProductVO;
import com.itwillbs.project.vo.OutScheduleVO;
import com.itwillbs.project.vo.ProductVO;
import com.itwillbs.project.vo.StockVo;

public interface Out_ScheduleMapper {

	List<ProductVO> selectProList(String keyword);

	List<StockVo> selectStoList(String keyword);
	
	// 출고예정 목록 조회
	List<OutScheduleVO> selectOutScheduleList();
	
	// 출고예정 목록 - 상품별
	List<OutSchedulePerProductVO> selectOutProdList();
	
}
