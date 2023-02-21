package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.StockMapper;
import com.itwillbs.project.vo.StockHistoryVo;
import com.itwillbs.project.vo.StockVo;

@Service
public class StockService {
	@Autowired
	private StockMapper mapper;
//	-----------재고 이력 목록 (기본페이지)------------
	public List<StockVo> getStockList() {
		return mapper.getStockList();
	}
	//--------재고 조정 작업---------
	public int stockUpdate(int update_qty, int stock_cd) {
		return mapper.stockUpdate(update_qty, stock_cd);
	}
	//---------재고 이동----------
	public int stockMove(int current_stock_cd, int move_stock_cd ,int move_stock_num) {
		
		return mapper.stockMove(current_stock_cd, move_stock_cd, move_stock_num);
	}
	//-------키워드에 맞는 재고 검색목록-------
	public List<StockVo> getStockListSearch(String keyword) {
		return mapper.getStockListSearch(keyword);
	}
	
	//----------재고 조정 시 재고이력 등록----------
	public int getInsertHistory(int update_qty, int stock_cd, int product_cd, String sId) {
		return mapper.insertHistory(update_qty, stock_cd, product_cd, sId);
	}
	//----------재고 이동 시 재고이력 등록----------
	public int getInsertHistory(int current_stock_cd, int move_stock_cd, int move_stock_num, String sId, int product_cd) {
		return mapper.insertHistory_mv(current_stock_cd, move_stock_cd, move_stock_num, sId, product_cd);
	}
	//---------재고 이력 목록 가져오기(stock_cd와 일치하는 목록)
	public List<StockHistoryVo> getStockHistoryList(int stock_cd) {
		return mapper.stockHistoryList(stock_cd);
	}
	//---------체크 된 항목 팝업창 넘기기---------
	public StockVo getStockWork(StockVo stock2) {
		return mapper.getStockWork(stock2);
	}
}
