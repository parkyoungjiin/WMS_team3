package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.In_ScheduleMapper;
import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.InSchedulePerProductVO;
import com.itwillbs.project.vo.InScheduleVO;

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
}
