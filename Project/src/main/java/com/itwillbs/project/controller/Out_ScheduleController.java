package com.itwillbs.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.service.BuyerService;
import com.itwillbs.project.service.EmpService;
import com.itwillbs.project.service.Out_ScheduleService;
import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.EmpVo;
import com.itwillbs.project.vo.OutSchedulePerProductVO;
import com.itwillbs.project.vo.OutScheduleVO;
import com.itwillbs.project.vo.ProductVO;
import com.itwillbs.project.vo.StockVo;

@Controller
public class Out_ScheduleController {

	@Autowired
	private Out_ScheduleService service;
	
	@Autowired
	private BuyerService buyer_service;
	
	@Autowired
	private EmpService emp_service;
	
	
	// ---------- 출고 관리 - 출고 예정 목록 ----------
	@GetMapping(value = "OutList.os")
	public String outList(Model model,@ModelAttribute OutScheduleVO outList) {
		
		model.addAttribute("outList", outList);
		return "out_schedule/out_list";
	} // outList 끝

	
	
	// ---------- 출고 관리 - 출고 예정 등록 폼 ----------
	@GetMapping(value = "OutRegisterForm")
	public String outResiterForm() {
		return "out_schedule/out_register";
	} // outResiterForm
	
	
	
	// ---------- 출고 관리 - 출고 예정 등록 폼 - 거래처 조회 ----------
	@GetMapping(value ="/BuyerListJson", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void listJson_buyer(
			@RequestParam(defaultValue = "") String keyword,
			Model model,
			HttpServletResponse response) {
		
		List<BuyerVo> buyerList = buyer_service.getBuyerList(keyword);
		// ---------------------------------------------------------------------------
		// 자바 데이터를 JSON 형식으로 변환하기
		// => org.json 패키지의 JSONObject 클래스를 활용하여 JSON 객체 1개를 생성하고
		//    JSONArray 클래스를 활용하여 JSONObject 객체 복수개에 대한 배열 생성
		// 0. JSONObject 객체 복수개를 저장할 JSONArray 클래스 인스턴스 생성
		JSONArray jsonArray = new JSONArray();
		
		// 1. List 객체 크기만큼 반복
		for(BuyerVo buyer : buyerList) {
			// 2. JSONObject 클래스 인스턴스 생성
			// => 파라미터 : VO(Bean) 객체(멤버변수 및 Getter/Setter, 기본생성자 포함)
			JSONObject jsonObject = new JSONObject(buyer);
//			System.out.println(jsonObject);
			
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
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	// ===============================================================================
	// ---------- 출고 관리 - 출고 예정 등록 폼 - 사원 조회 ----------
	@GetMapping(value ="/EmpListJson", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void listJson_emp(
			@RequestParam(defaultValue = "") String keyword,
			Model model,
			HttpServletResponse response) {
		
		List<EmpVo> empList = emp_service.getEmployeeList(keyword);
		// ---------------------------------------------------------------------------
		// 자바 데이터를 JSON 형식으로 변환하기
		// => org.json 패키지의 JSONObject 클래스를 활용하여 JSON 객체 1개를 생성하고
		//    JSONArray 클래스를 활용하여 JSONObject 객체 복수개에 대한 배열 생성
		// 0. JSONObject 객체 복수개를 저장할 JSONArray 클래스 인스턴스 생성
		JSONArray jsonArray = new JSONArray();
		
		// 1. List 객체 크기만큼 반복
		for(EmpVo emp : empList) {
			// 2. JSONObject 클래스 인스턴스 생성
			// => 파라미터 : VO(Bean) 객체(멤버변수 및 Getter/Setter, 기본생성자 포함)
			JSONObject jsonObject = new JSONObject(emp);
//			System.out.println(jsonObject);
			
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
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	// ===============================================================================
	
	// ===============================================================================
		// ---------- 출고 관리 - 출고 예정 등록 폼 - 품목 조회 ----------
		@GetMapping(value ="/ProListJson", produces = "application/json; charset=utf-8")
		@ResponseBody
		public void listJson_pro(
				@RequestParam(defaultValue = "") String keyword,
				Model model,
				HttpServletResponse response) {
			
			List<ProductVO> proList = service.getProductList(keyword);
			// ---------------------------------------------------------------------------
			// 자바 데이터를 JSON 형식으로 변환하기
			// => org.json 패키지의 JSONObject 클래스를 활용하여 JSON 객체 1개를 생성하고
			//    JSONArray 클래스를 활용하여 JSONObject 객체 복수개에 대한 배열 생성
			// 0. JSONObject 객체 복수개를 저장할 JSONArray 클래스 인스턴스 생성
			JSONArray jsonArray = new JSONArray();
			
			// 1. List 객체 크기만큼 반복
			for(ProductVO pro : proList) {
				// 2. JSONObject 클래스 인스턴스 생성
				// => 파라미터 : VO(Bean) 객체(멤버변수 및 Getter/Setter, 기본생성자 포함)
				JSONObject jsonObject = new JSONObject(pro);
//				System.out.println(jsonObject);
				
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
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		// ===============================================================================
		
		// ===============================================================================
		// ---------- 출고 관리 - 출고 예정 등록 폼 - 재고 조회 ----------
		@GetMapping(value ="/StoListJson", produces = "application/json; charset=utf-8")
		@ResponseBody
		public void listJson_sto(
				@RequestParam(defaultValue = "") String keyword,
				Model model,
				HttpServletResponse response) {
			
			List<StockVo> stoList = service.getStockList(keyword);
			JSONArray jsonArray = new JSONArray();
			
			for(StockVo sto : stoList) {
				JSONObject jsonObject = new JSONObject(sto);
				
				jsonArray.put(jsonObject);
			}
			
			try {
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(jsonArray); // toString() 생략됨
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		// ===============================================================================
		
		
		@PostMapping(value = "/OutRegisterPro")
		public String outResiterPro(
				@ModelAttribute OutScheduleVO os, @ModelAttribute OutSchedulePerProductVO osp,
				Model model) {
			
			System.out.println(os);
			System.out.println(osp);
			
			
//			return "redirect:/OutList.os";
			return "";
		}
		
}
