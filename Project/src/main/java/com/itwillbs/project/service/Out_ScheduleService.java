package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.Out_ScheduleMapper;
import com.itwillbs.project.vo.OutSchedulePerProductVO;
import com.itwillbs.project.vo.OutScheduleVO;
import com.itwillbs.project.vo.ProductVO;
import com.itwillbs.project.vo.StockVo;

@Service
public class Out_ScheduleService {

	@Autowired
	private Out_ScheduleMapper mapper;

	// 품목 조회 (모달)
	public List<ProductVO> getProductList(String keyword) {
		return mapper.selectProList(keyword);
	}

	// 출고 예정 리스트
	public List<OutScheduleVO> getOutScheduleList() {
		return mapper.selectOutScheduleList();
	}	

	// 출고 예정 리스트 - 품목별
	public List<OutSchedulePerProductVO> getOutProdList(String out_schedule_cd) {
		return mapper.selectOutProdList(out_schedule_cd);
	}

	// 재고 조회 (모달)
	public List<StockVo> getStockList(String keyword) {
		return mapper.selectStoList(keyword);

	}

	public int getSelectCode(OutScheduleVO os) {
		return mapper.selectCode(os);
	}

	// 출고 예정 등록
	public int insertOutSchedule(OutScheduleVO os) {
		return mapper.insertSchedule(os);
	}

	// 출고 예정 품목 등록
	public int insertOutProduct(OutSchedulePerProductVO osp2) {
		return mapper.insertOutProduct(osp2);
	}
	
	// 출고 예정의  종결상태 변
	public int updateComplete(String out_complete) {
		return mapper.updateStatus(out_complete);
	}
}
