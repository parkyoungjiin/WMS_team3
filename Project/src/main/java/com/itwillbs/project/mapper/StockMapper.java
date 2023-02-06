package com.itwillbs.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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
			@Param("move_wh_loc_in_area") int move_wh_loc_in_area,
			@Param("move_stock_num") int move_stock_num);
	
}
