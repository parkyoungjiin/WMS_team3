package com.itwillbs.project.mapper;

import java.util.List;

import com.itwillbs.project.vo.ProductVO;
import com.itwillbs.project.vo.StockVo;

public interface Out_ScheduleMapper {

	List<ProductVO> selectProList(String keyword);

	List<StockVo> selectStoList(String keyword);
	
}
