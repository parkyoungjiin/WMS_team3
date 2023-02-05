package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.StockMapper;
import com.itwillbs.project.vo.StockVo;

@Service
public class StockService {
	@Autowired
	private StockMapper mapper;
	//-----------재고 목록 (기본페이지)------------
	public List<StockVo> getStockList() {
		return mapper.getStockList();
	}
	//--------재고 조정 작업---------
	public int stockUpdate(int update_qty, int stock_cd) {
		return mapper.stockUpdate(update_qty, stock_cd);
	}
}
