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
	//---------재고 이동----------
	public int stockMove(int current_stock_cd, int move_stock_cd, int move_wh_loc_in_area ,int move_stock_num) {
		
		return mapper.stockMove(current_stock_cd, move_stock_cd, move_wh_loc_in_area, move_stock_num);
	}
	//-------키워드에 맞는 재고 검색목록-------
	public List<StockVo> getStockListSearch(String keyword) {
		return mapper.getStockListSearch(keyword);
	}
}
