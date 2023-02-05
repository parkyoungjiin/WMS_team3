package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.Out_ScheduleMapper;
import com.itwillbs.project.vo.ProductVO;

@Service
public class Out_ScheduleService {

	@Autowired
	private Out_ScheduleMapper mapper;

	// 품목 조회 (모달)
	public List<ProductVO> getProductList(String keyword) {
		return mapper.selectProList(keyword);
	}
}
