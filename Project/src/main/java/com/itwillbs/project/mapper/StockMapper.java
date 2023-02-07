package com.itwillbs.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

import com.itwillbs.project.vo.StockHistoryVo;
import com.itwillbs.project.vo.StockVo;

public interface StockMapper {
	//-----------재고 목록 (기본페이지)------------
	List<StockVo> getStockList();
	//--------재고 조정 작업---------
	int stockUpdate(@Param("update_qty") int update_qty,@Param("stock_cd") int stock_cd);
	//---------재고 이동-----------
	int stockMove(
			@Param("current_stock_cd") int current_stock_cd, 
			@Param("move_stock_cd") int move_stock_cd, 
			@Param("move_wh_loc_in_area") String move_wh_loc_in_area,
			@Param("move_stock_num") int move_stock_num);
	//-------키워드에 맞는 재고 검색목록-------
	List<StockVo> getStockListSearch(String keyword);
	//----------재고 조정 시 재고이력 등록----------
	int insertHistory(
			@Param("update_qty") int update_qty,
			@Param("stock_cd") int stock_cd, 
			@Param("product_cd") String product_cd, 
			@Param("sId") String sId);
	//----------재고 이동 시 재고이력 등록----------
	int insertHistory_mv(
			@Param("current_stock_cd") int current_stock_cd,
			@Param("move_stock_cd") int move_stock_cd, 
			@Param("move_stock_num") int move_stock_num,
			@Param("sId") String sId,
			@Param("product_cd") int product_cd);
	//---------재고 이력 목록 가져오기(stock_cd와 일치하는 목록)-------------
	List<StockHistoryVo> stockHistoryList(int stock_cd);
	
}
