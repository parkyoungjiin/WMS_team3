package com.itwillbs.project.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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

@Controller
public class StockController {
	
	@Autowired
	private StockService service;
	
	//재고 목록 이동 (기본페이지)
	@GetMapping(value = "StockList.st")
	public String stock() { 
		return "stock/stock_list";
	}//stock 끝
}//BuyerController 끝
