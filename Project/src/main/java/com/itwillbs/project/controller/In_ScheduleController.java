package com.itwillbs.project.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.lang.model.element.ModuleElement;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.itwillbs.project.service.In_scheduleService;
import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.EmpVo;
import com.itwillbs.project.vo.InSchedulePerProductVO;
import com.itwillbs.project.vo.InScheduleVO;
import com.itwillbs.project.vo.ProductVO;
import com.itwillbs.project.vo.StockVo;

@Controller
public class In_ScheduleController {

	@Autowired
	private In_scheduleService service;
	
	@Autowired
	private BuyerService buyer_service;
	
	@Autowired
	private EmpService emp_service;
	
	//--------입고예정 목록 표시 페이지 이동 -----------
	@GetMapping("/InList")
	public String islist(Model model, HttpSession session
			) {
		List<InScheduleVO> islist = service.getInscheduleList();
		model.addAttribute("islist", islist);
		
		return "in_schedule/in_list";
	} //입고예정 목록 표시 페이지 이동 끝 
	
	//-----------입고등록 폼-----------
	@GetMapping("/InRegisterForm")
	public String isinsertform(@ModelAttribute InScheduleVO inschedule, Model model) {
		
		return "in_schedule/in_register";
	}// 입고등록 폼 끝
	
	//------입고등록 PRO ------
	@PostMapping("/InscheduleRegisterPro")
	public String InscheduleRegisterPro(@ModelAttribute InScheduleVO ins
			,Model model 
			,HttpSession session,
			@ModelAttribute InSchedulePerProductVO insp) {
		
		SimpleDateFormat inDate_format = new SimpleDateFormat("yyyyMMdd");
		String inDate = inDate_format.format(ins.getIN_SCHEDULE_DATE());
		
		int in_cd = service.getSelectCode(ins) +1;
		
		String in_code = String.format("%04d", in_cd);
		String in_schedule_code = inDate+ "-" + in_code;
		ins.setIN_SCHEDULE_CD(in_schedule_code);
		int insertCount = service.registerInschedule(ins);
		if(insertCount > 0) {
			for(int i =0; i <insp.getPRODUCT_CDArr().length; i++) {
				InSchedulePerProductVO insp2 = new InSchedulePerProductVO();
				insp2.setPRODUCT_CD(insp.getPRODUCT_CDArr()[i]);
				insp2.setPRODUCT_NAME(insp.getPRODUCT_NAMEArr()[i]);
				insp2.setPRODUCT_SIZE(insp.getPRODUCT_SIZEArr()[i]);
				insp2.setIN_SCHEDULE_QTY(insp.getIN_SCHEDULE_QTYArr()[i]);
				insp2.setREMARKS(insp.getREMARKSArr()[i]);
				insp2.setIN_DATE(insp.getIN_DATEArr()[i]);
				insp2.setSTOCK_CD(insp.getSTOCK_CDArr()[i]);
				
				insp2.setIN_SCHEDULE_CD(in_schedule_code);
				System.out.println(insp);
				int insertCount2 = service.insertInProduct(insp2);
				
//				if(insertCount2 > 0) {
//					return "redirect:/InList";
//				}else {
//					model.addAttribute("msg","입고 등록 실패");
//					return "fail_back";
//				}
			}
			return "redirect:/InList";
		}else {
			model.addAttribute("msg", "입고 등록 실패");
			return "fail_back";
		}
	}
		
	
	//-----------입고 등록 PRO 끝------------
	
	//진행 상태 - 입고 예정
	@ResponseBody
	@GetMapping(value="InListProd")
	public void inListProd(Model model,@RequestParam(value="IN_SCHEDULE_CD", required=false) String IN_SCHEDULE_CD, HttpServletResponse response ) {
		
		List<InSchedulePerProductVO> inProdList = service.getInProdList(IN_SCHEDULE_CD);
		
		JSONArray jsonArray = new JSONArray();
		
		for(InSchedulePerProductVO inProd : inProdList) {
			JSONObject jsonObject = new JSONObject(inProd);
			jsonArray.put(jsonObject);
		}
		
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonArray);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	
	
	
	
	//---종결버튼-----
	@GetMapping("/InComplete")
	public String incomplete(@RequestParam(value="IN_COMPLETE") String IN_COMPLETE
			,@RequestParam(value="IN_SCHEDULE_CD", required= false) String IN_SCHEDULE_CD) {
		int updateCount = service.updateclosing(IN_COMPLETE,IN_SCHEDULE_CD);
		
		if(updateCount >0) {
			return "in_schedule/in_list";
		}else {
			return "";
		}
		
	}
	
	//----종결 끝
	
	//--입고 예정 상세정보--
	@GetMapping("/InDetail")
	public String InDetail(@ModelAttribute InScheduleVO ins,
			@ModelAttribute InSchedulePerProductVO insp,
			Model model) {
		ins = service.getINInfo(ins.getIN_SCHEDULE_CD());
		List<InSchedulePerProductVO> inspList = service.getInProductList(ins.getIN_SCHEDULE_CD());
		
		model.addAttribute("ins", ins);
		model.addAttribute("inspList", inspList);
		
		return "in_schedule/in_modify";
	}// 상세정보 끝
	
	
	
	//---------입고 수정 -----------
	
	@PostMapping("/InModifyPro")
	public String modifyPro(@ModelAttribute InScheduleVO ins, 
			@ModelAttribute InSchedulePerProductVO insp, Model model
			) {
		int updateCount = service.modifyPro(ins);
		
		if(updateCount >0) {
			for(int i=0; i < insp.getPRODUCT_CDArr().length; i++) {
				InSchedulePerProductVO insp2 = new InSchedulePerProductVO();
				insp2.setPRODUCT_CD(insp.getPRODUCT_CDArr()[i]);
				insp2.setPRODUCT_NAME(insp.getPRODUCT_NAMEArr()[i]);
				insp2.setPRODUCT_SIZE(insp.getPRODUCT_SIZEArr()[i]);
				insp2.setIN_SCHEDULE_QTY(insp.getIN_SCHEDULE_QTYArr()[i]);
				if(insp.getREMARKSArr()[i] == null) {
					insp2.setREMARKS("");
				}else {
					insp2.setREMARKS(insp.getREMARKSArr()[i]);
				}
				insp2.setIN_DATE(insp2.getIN_DATEArr()[i]);
				insp2.setSTOCK_CD(insp.getSTOCK_CDArr()[i]);
				insp2.setIN_SCHEDULE_CD(insp.getIN_SCHEDULE_CD());
				
				int updateCount2= service.modifyPro2(insp2);
			}
			return "redirect:/InList";
		}else {
			model.addAttribute("msg","수정 실패");
			return "fail_back";
			
		}
		
	}
	
	// ---------- 출고 관리 - 출고 예정 등록 폼 - 거래처 조회 ----------
		@GetMapping(value ="/BuyerJson", produces = "application/json; charset=utf-8")
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
		// ---------- 출고 관리 - 출고 예정 등록 폼 - 사원 조회 ----------
		@GetMapping(value ="/EmpJson", produces = "application/json; charset=utf-8")
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
//			// ---------- 출고 관리 - 출고 예정 등록 폼 - 품목 조회 ----------
//			@GetMapping(value ="/ProJson", produces = "application/json; charset=utf-8")
//			@ResponseBody
//			public void listJson_pro(
//					@RequestParam(defaultValue = "") String keyword,
//					Model model,
//					HttpServletResponse response) {
//				
////				List<ProductVO> proList = service.getProductList(keyword);
//				// ---------------------------------------------------------------------------
//				// 자바 데이터를 JSON 형식으로 변환하기
//				// => org.json 패키지의 JSONObject 클래스를 활용하여 JSON 객체 1개를 생성하고
//				//    JSONArray 클래스를 활용하여 JSONObject 객체 복수개에 대한 배열 생성
//				// 0. JSONObject 객체 복수개를 저장할 JSONArray 클래스 인스턴스 생성
//				JSONArray jsonArray = new JSONArray();
//				
//				// 1. List 객체 크기만큼 반복
//				for(ProductVO pro : proList) {
//					// 2. JSONObject 클래스 인스턴스 생성
//					// => 파라미터 : VO(Bean) 객체(멤버변수 및 Getter/Setter, 기본생성자 포함)
//					JSONObject jsonObject = new JSONObject(pro);
////					System.out.println(jsonObject);
//					
//					// 3. JSONArray 객체의 put() 메서드를 호출하여 JSONObject 객체 추가
//					jsonArray.put(jsonObject);
//				}
//				
//				try {
//					// 생성된 JSON 객체를 활용하여 응답 데이터를 직접 생성 후 웹페이지에 출력
//					// response 객체의 setCharacterEncoding() 메서드로 출력 데이터 인코딩 지정 후
//					// response 객체의 getWriter() 메서드로 PrintWriter 객체를 리턴받아
//					// PrintWriter 객체의 print() 메서드를 호출하여 응답데이터 출력
//					response.setCharacterEncoding("UTF-8");
//					response.getWriter().print(jsonArray); // toString() 생략됨
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//				
//			}
			// ===============================================================================
	
	
	
	
	
//	//----------진행중 리스트----------
//	@GetMapping("/InProgressList")
//	public String progress(Model model, HttpSession session) {
//		List<InScheduleVO> progress = service.getInprogressList();
//		
//		model.addAttribute("progress", progress);
//		
//		return "in_schedule/in_progresslist";
//	}
	
	//--------입고예정 목록 표시 페이지 이동 -----------

	@GetMapping("/In_Per_List")
	public String in_per_list(Model model) {
		List<InSchedulePerProductVO>list = service.getInschedulePerList();
		System.out.println(list);
		model.addAttribute("list",list);
		return "in_schedule/in_schedule_per_list";
	}//입고예정 목록 표시 페이지 이동 끝
	
	//-------------입고처리 팝업창-----------
	@GetMapping(value = "/In_Per_List_popup")
	public String in_per_list_popup(@ModelAttribute InSchedulePerProductVO vo,Model model) {
//		List<InSchedulePerProductVO> list = service.getInschedulePerList();
		System.out.println(vo.getIN_SCHEDULE_PER_CDArr().length);
		System.out.println(vo);

		try {
			List<InSchedulePerProductVO> list = new ArrayList<InSchedulePerProductVO>();
				for(int i=0;i<=vo.getIN_SCHEDULE_PER_CDArr().length-1;i++) {
					InSchedulePerProductVO vo2 = new InSchedulePerProductVO();
					vo2.setIN_SCHEDULE_PER_CD(vo.getIN_SCHEDULE_PER_CDArr()[i]);
					vo2 = service.getInschedulePerInfo(vo2); 
					list.add(vo2);
					
				}
				System.out.println(list);
				model.addAttribute("list",list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "in_schedule/in_schedule_per_list_popup";
	}//입고예정 목록 표시 페이지 이동 끝
	
	//------------입고처리 팝업창에서 검색---------
	@GetMapping(value ="/StockNumListJson", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void stock_num_search(
			@RequestParam(defaultValue = "") String keyword,
			Model model,
			HttpServletResponse response
			) {
		//키워드에 맞는 재고번호 리스트 받아오기
		List<StockVo> stockList = service.getSerachStockNum(keyword);
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
//					System.out.println(jsonObject);
					
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
				
	}//stock_num_search 끝
	
}
