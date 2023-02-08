package com.itwillbs.project.mapper;

import java.util.List;

import com.itwillbs.project.vo.InSchedulePerProductVO;
import com.itwillbs.project.vo.InScheduleVO;

public interface In_ScheduleMapper {
	
	//입고 물품 목록 조회
	List<InScheduleVO> selectInscheduleList();
	// 입고 등록
	int insertInschedule(InScheduleVO ins);
	//입고예정 리스트
	List<InSchedulePerProductVO> getInschedulePerList();

}
