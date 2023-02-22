package com.itwillbs.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
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
import com.itwillbs.project.vo.EmpVo;
import com.itwillbs.project.vo.StockHistoryVo;
import com.itwillbs.project.vo.StockVo;
import com.mysql.cj.xdevapi.JsonArray;

@Controller
public class StockController {
	
	@Autowired
	private StockService service;
	
	//-----------재고 목록 이동 (기본페이지)------------
	@GetMapping(value = "StockList.st")
	public String stock(@ModelAttribute StockVo stock, Model model) {
		//뷰 테이블에 저장된 재고 목록 가져오기
		List<StockVo> stockList = service.getStockList();
		//뷰 테이블에 저장된 재고 목록 저장
		model.addAttribute("stockList",stockList);
		
		
		return "stock/stock_list";
	}//stock 끝
//	//------------재고번호 클릭 시 재고번호와 일치하는 history 목록 가져오기 ajax 사용-------------------
//	@PostMapping(value = "StockHistoryList.st")
//	public void stockHistory(Model model, @RequestParam() int stock_cd, HttpServletResponse response) {
//		List<StockHistoryVo> stockHistoryList = service.getStockHistoryList(stock_cd);
//		
//		JSONArray jsonArray = new JSONArray();
//		
//		// 1. List 객체 크기만큼 반복
//		for(StockHistoryVo stockhistory : stockHistoryList) {
//			// 2. JSONObject 클래스 인스턴스 생성
//			// => 파라미터 : VO(Bean) 객체(멤버변수 및 Getter/Setter, 기본생성자 포함)
//			JSONObject jsonObject = new JSONObject(stockhistory);
//	//		System.out.println(jsonObject);
//			
//			// 3. JSONArray 객체의 put() 메서드를 호출하여 JSONObject 객체 추가
//			jsonArray.put(jsonObject);
//		}
//		try {
//			// 생성된 JSON 객체를 활용하여 응답 데이터를 직접 생성 후 웹페이지에 출력
//			// response 객체의 setCharacterEncoding() 메서드로 출력 데이터 인코딩 지정 후
//			// response 객체의 getWriter() 메서드로 PrintWriter 객체를 리턴받아
//			// PrintWriter 객체의 print() 메서드를 호출하여 응답데이터 출력
//			response.setCharacterEncoding("UTF-8");
//			response.getWriter().print(jsonArray); // toString() 생략됨
//			System.out.println(jsonArray);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	//------------재고번호 클릭 시 재고번호와 일치하는 history 목록 가져오기 팝업창 사용-------------------
	@GetMapping(value = "StockHistoryList.st")
	public String stockHistory(Model model, 
			@RequestParam() int stock_cd, 
			HttpServletResponse response) {
		List<StockHistoryVo> stockHistoryList = service.getStockHistoryList(stock_cd);
		model.addAttribute("stockHistoryList", stockHistoryList);
		model.addAttribute("stock_cd", stock_cd);
		
		return "stock/stock_history_popup";
	}
	//------------재고번호 클릭 시 재고번호, control_type과 일치하는 history 목록 가져오기 팝업창 사용 :ajax 사용 -------------------
	@PostMapping(value = "StockHistoryListAjax.st", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void stockHistory(Model model, 
			@RequestParam() int stock_cd,
			@RequestParam() int control_type,
			HttpServletResponse response) {
		System.out.println(stock_cd);
		System.out.println(control_type);
		//stock_cd, control_type에 맞는 리스트 가져오기
		List<StockHistoryVo> stockHistoryList = service.getStockHistoryListAjax(stock_cd, control_type);
		//-------JSON 형식으로 변환
		// 1. JSONObject 클래스 활용하여 JSON 객체 1개를 생성하고, 
		// JSONArray 클래스를 활용하여 JSONObject 객체 복수개에 대한 배열을 생성
		JSONArray jsonArray = new JSONArray();
		//리스트 크기만큼 반복 
		for(StockHistoryVo stockHistory: stockHistoryList) {
			JSONObject jsonObject = new JSONObject(stockHistory);
			jsonArray.put(jsonObject);
			//object에다가 list를 하나씩 넣고, array에다가 하나씩 넣는 반복문!
			
		}//for 끝
		
		try {
			// 생성된 JSON 객체를 활용하여 응답 데이터를 직접 생성 후 웹페이지에 출력
			// response 객체의 setCharacterEncoding() 메서드로 출력 데이터 인코딩 지정 후
			// response 객체의 getWriter() 메서드로 PrintWriter 객체를 리턴받아
			// PrintWriter 객체의 print() 메서드를 호출하여 응답데이터 출력
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonArray); // toString() 생략됨
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	
	
	
	
	//----------재고 키워드 조회------------
	@GetMapping(value = "StockListJson", produces = "application/json; charset=utf-8")
	public void listJson_stock(
			@RequestParam(defaultValue = "") String keyword,
			Model model,
			HttpServletResponse response){
	
		List<StockVo> stockList = service.getStockListSearch(keyword);
		// ---------------------------------------------------------------------------
		// 자바 데이터를 JSON 형식으로 변환하기
		// => org.json 패키지의 JSONObject 클래스를 활용하여 JSON 객체 1개를 생성하고
		//    JSONArray 클래스를 활용하여 JSONObject 객체 복수개에 대한 배열 생성
		// 0. JSONObject 객체 복수개를 저장할 JSONArray 클래스 인스턴스 생성
		JSONArray jsonArray = new JSONArray();
		
		// 1. List 객체 크기만큼 반복
		for(StockVo stock : stockList) {
			// 2. JSONObject 클래스 인스턴스 생성
			// => 파라미터 : VO(Bean) 객체(멤버변수 및 Getter/Setter, 기본생성자 포함)
			JSONObject jsonObject = new JSONObject(stock);
	//		System.out.println(jsonObject);
			
			// 3. JSONArray 객체의 put() 메서드를 호출하여 JSONObject 객체 추가
			jsonArray.put(jsonObject);
		}
		
		try {
			// 생성된 JSON 객체를 활용하여 응답 데이터를 직접 생성 후 웹페이지에 출력
			// response 객체의 setCharacterEncoding() 메서드로 출력 데이터 인코딩 지정 후
			// response 객체의 getWriter() 메서드로 PrintWriter 객체를 리턴받아
			// PrintWriter 객체의 print() 메서드를 호출하여 응답데이터 출력
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonArray); // toString() 생략됨
			System.out.println(jsonArray);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}//listJson_stock 끝
	
	//재고 복수개 처리
	@GetMapping(value = "stockWork.st")
	public String stockWork(@ModelAttribute StockVo stock, Model model) {
		System.out.println(stock.getStock_cdArr().length);
		//arr로 저장한 stock_cd를 
		
		List<StockVo> stolist = new ArrayList<StockVo>();
		for(int i=0; i<=stock.getStock_cdArr().length-1;i++) {
			StockVo stock2 = new StockVo();
			stock2.setStock_cd(stock.getStock_cdArr()[i]);
			stock2 = service.getStockWork(stock2);
			stolist.add(stock2);
			
		}
		System.out.println(stolist);
		model.addAttribute("stolist", stolist);
		return "stock/stock_work_popup";
	}//stockWork 끝
	
	//재고 이동, 조정 처리 메서드
	@GetMapping(value = "stockMoveUpdate.st")
	public String stockMoveUpdate(@ModelAttribute StockVo stock, Model model, HttpSession session) {
		//세션 아이디가 없는 경우 작업 불가 ! 
		String sId = (String)session.getAttribute("emp_num"); 
		if(sId == "") {
			model.addAttribute("msg","로그인 상태를 확인해주세요.");
		}else {
//			stock_control_length 길이 계산 후 반복문에 사용 
			int stock_control_length = stock.getStock_controlArr().length;
			for(int i=0; i<stock_control_length; i++) {
				int stock_control  = stock.getStock_controlArr()[i];
				System.out.println(i + "번째 control : " + stock_control);
				System.out.println(stock);

				//1. 작업구분 코드 = 2(조정) 일 경우 조정 작업처리 
					if(stock_control == 2) {
	//					(조정)필요한 값 : 업데이트 수량, 재고번호, 품목코드
						int updateCountNum = stock.getUpdate_qtyArr()[i];
						int stockCd = stock.getStock_cdArr()[i];
						int productCd = stock.getProduct_cdArr()[i];
						//재고 조정 작업 
						int updateCount = service.stockUpdate(updateCountNum, stockCd);
						//조정 성공 시 재고이력 저장 
						if(updateCount > 0) {
							int historyInsertCount = service.getInsertHistory(updateCountNum, stockCd, productCd, sId);
							if(historyInsertCount > 0) {
								model.addAttribute("msg","재고작업 성공");
							}else {
								model.addAttribute("msg","재고조정 후 이력 저장 실패");
							}
						}else {
							model.addAttribute("msg", "재고조정 실패");
						}

				//2. 작업구분 코드 = 3(이동) 일 경우 이동 작업처리
					}else if(stock_control == 3) {
	//					(이동)필요한 값 : 현재 재고번호, 이동할 재고번호, 이동할 구역, 이동할 개수, 품목코드 
						int stockCd = stock.getStock_cdArr()[i];
						int moveStockCd = stock.getMove_stock_cdArr()[i];
//						int moveWhAreatCd = stock.getMove_wh_loc_in_area_cdArr()[i];
						int moveNum = stock.getUpdate_qtyArr()[i];
						int productCd = stock.getProduct_cdArr()[i];
						//재고 이동 작업 
						int moveCount = service.stockMove(stockCd, moveStockCd, moveNum);
						//조정 성공 시 재고이력 저장  
						if(moveCount > 0) {
							int historyInsertCount = service.getInsertHistory(stockCd, moveStockCd, moveNum, sId, productCd);
							if(historyInsertCount > 0) {
								model.addAttribute("msg","재고작업 성공");
							}else {
								model.addAttribute("msg","재고조정 후 이력 저장 실패");
							}
						}else {
							model.addAttribute("msg", "재고이동 실패");
						}

						
					}// else if 끝 
			}//for 끝

		}//else 끝 
		return "reload_stock";
		
	}//stockMoveUpdate

	
		
}//BuyerController 끝
