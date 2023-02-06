package com.itwillbs.project.mapper;

import java.util.List;

import com.itwillbs.project.vo.OutScheduleVO;
import com.itwillbs.project.vo.ProductVO;

public interface Out_ScheduleMapper {

	List<ProductVO> selectProList(String keyword);
	
	// 출고예정 목록 조회
	List<OutScheduleVO> selectOutScheduleList();
	
}
