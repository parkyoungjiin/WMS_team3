package com.itwillbs.project.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.server.header.XFrameOptionsServerHttpHeadersWriter.Mode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.service.BuyerService;
import com.itwillbs.project.service.StockService;
import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.StockVo;

@Controller
public class StockController {
	
	@Autowired
	private StockService service;
	
	//-----------재고 목록 이동 (기본페이지)------------
	@GetMapping(value = "StockList.st")
	public String stock(@ModelAttribute StockVo stock, Model model) {
		List<StockVo> stockList = service.getStockList();
		model.addAttribute("stockList",stockList);
		return "stock/stock_list";
	}//stock 끝
	
	//--------재고 조정 작업---------
	@PostMapping(value = "stockUpdate.st")
	public void stockUpdate(
			@RequestParam("updateStockNum") int update_qty,
			@RequestParam("stock_cd") int stock_cd,
			HttpServletResponse response
			) {
		
		int updateCount = service.stockUpdate(update_qty, stock_cd);
		if(updateCount > 0) {
			try {
				response.getWriter().print(updateCount); //emailcheck 값을 보내는 작업
			} catch (Exception e) {
				e.printStackTrace();
			}
		}//if 끝
	}//stockUpdate 끝
	
	
	//---------재고번호, 이동위치 검색----------
		
}//BuyerController 끝
