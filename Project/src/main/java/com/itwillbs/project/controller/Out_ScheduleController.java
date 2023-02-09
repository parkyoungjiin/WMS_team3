package com.itwillbs.project.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.itwillbs.project.vo.InSchedulePerProductVO;
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
	public String outList(Model model) { 
		List<OutScheduleVO> outList = service.getOutScheduleList();
		model.addAttribute("outList", outList);
//		String perName = service.concatName();
//		System.out.println(perName);
//		model.addAttribute("perName",perName);
		
		return "out_schedule/out_list";
	} // outList 끝

	// ---------- 출고 예정 목록 - 품목별(진행상태) --------------
	@ResponseBody
	@GetMapping(value="OutListProd.os")
	public void outListProd(Model model, @RequestParam(value="out_schedule_cd", required=false) String out_schedule_cd, HttpServletResponse response) {
//		System.out.println("품목별조회"+out_schedule_cd);
		List<OutSchedulePerProductVO> outProdList = service.getOutProdList(out_schedule_cd);
		
		JSONArray jsonArray = new JSONArray();
		
		for(OutSchedulePerProductVO outProd : outProdList) {
			JSONObject jsonObject = new JSONObject(outProd);
			
			jsonArray.put(jsonObject);
		}
		
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonArray); // toString() 생략됨
			System.out.println(jsonArray);
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // outListProd() 끝
	
	//------------- 출고예정목록 - 종결버튼 변경--------------------
	@GetMapping(value="/OutComplete.os")
	public String changeComplete(@RequestParam(value="out_complete") String out_complete, @RequestParam(value="out_schedule_cd", required=false) String out_schedule_cd) {
		System.out.println("종결값:" + out_complete);
		System.out.println("");
		int updateCount = service.updateComplete(out_complete,out_schedule_cd);
		
		if(updateCount > 0) {
			return "out_schedule/out_list";
		} else {
			return "";
		}
	}
	
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
		
		
		
		// ---------- 출고 관리 - 출고 예정 등록  ----------
		@PostMapping(value = "/OutRegisterPro")
		public String outResiterPro(
				@ModelAttribute OutScheduleVO os, @ModelAttribute OutSchedulePerProductVO osp,
				Model model) {
			
			
			// 출고 예정 번호 등록
			SimpleDateFormat outDate_format = new SimpleDateFormat("yyyyMMdd");
			String outDate = outDate_format.format(os.getOut_schedule_date());
			
			// 뒷자리 일련번호 가져와서 + 1
			int out_cd = service.getSelectCode(os) + 1;

			String out_code = String.format("%04d", out_cd); //00x 형태 변환
			String out_schedule_code = outDate + "-" + out_code; // 작성일자(6) + - +예정번호
			os.setOut_schedule_cd(out_schedule_code); // 공통 출고 예정 번호
			
			// 출고 예정 등록
			int insertCount = service.insertOutSchedule(os);
			
			if(insertCount > 0) {
				
				// 출고 예정 품목 등록
				for(int i = 0; i < osp.getProduct_cdArr().length; i++) {
					
					OutSchedulePerProductVO osp2 = new OutSchedulePerProductVO();
					// 여러값으로 저장해야 할 항목들
					osp2.setProduct_cd(osp.getProduct_cdArr()[i]); // 품목코드
					osp2.setProduct_name(osp.getProduct_nameArr()[i]); // 품목명
					osp2.setProduct_size(osp.getProduct_sizeArr()[i]); // 품목 규격
					osp2.setOut_schedule_qty(osp.getOut_schedule_qtyArr()[i]); // 출고 예정 수량
					
					for(int r = 0; r < osp.getRemarks_proArr().length; r++) {
						
					    System.out.println(osp.getRemarks_proArr()[r] + "/");
						
					    if(osp.getRemarks_proArr()[r] == null || osp.getRemarks_proArr()[r].length() == 0) {
					    	osp2.setRemarks_pro("");
					    } else {
					    	osp2.setRemarks_pro(osp.getRemarks_proArr()[r]); // 비고
					    }
					}
					
					osp2.setOut_date(osp.getOut_dateArr()[i]); // 납기일자
					osp2.setStock_cd(osp.getStock_cdArr()[i]); // 재고번호
					
					System.out.println(osp2);
					// 단일값으로 저장해야 할 항목들
					osp2.setOut_schedule_cd(out_schedule_code); // 공통 출고 예정 번호
					
					int insertCount2 = service.insertOutProduct(osp2);
					
					if(insertCount2 > 0) {
						return "redirect:/OutList.os";
					} else {
						model.addAttribute("msg", "출고 예정 등록 실패!");
						return "fail_back";
					}
					
				}
				return "redirect:/OutList.os";
			}else { // 실패
				model.addAttribute("msg", "출고 예정 등록 실패!");
				return "fail_back";
			}
			
		} //outResiterPro 끝

		
		
		// ---------- 출고 관리 - 출고 상세정보  ----------
		@GetMapping(value = "/OutDetail")
		public String OutDetail(
				@ModelAttribute OutScheduleVO os, @ModelAttribute OutSchedulePerProductVO osp,
				Model model) {
			
			os = service.getOSInfo(os.getOut_schedule_cd());
			List<OutSchedulePerProductVO> ospList = service.getOutProdList(os.getOut_schedule_cd());
			
			
//			System.out.println("ospList : " + ospList);
			
			model.addAttribute("os",os);
			model.addAttribute("ospList",ospList);
			
			return "out_schedule/out_modify";
		}
		
		
		// ---------- 출고 관리 - 출고예정 수정  ----------
		@PostMapping(value = "/OutModifyPro")
		public String OutUpdate(@ModelAttribute OutScheduleVO os, @ModelAttribute OutSchedulePerProductVO osp,
				Model model) {
			
//			System.out.println("거래처번호 " + os.getBusiness_no());
			int updateCount = service.updateOutSchedule(os);
			
			
				if(updateCount > 0) {
				
				// 품목별 수정
				for(int i = 0; i < osp.getProduct_cdArr().length; i++) {
					
					OutSchedulePerProductVO osp2 = new OutSchedulePerProductVO();
					// 여러값으로 저장해야 할 항목들
					osp2.setProduct_cd(osp.getProduct_cdArr()[i]); // 품목코드
					osp2.setProduct_name(osp.getProduct_nameArr()[i]); // 품목명
					osp2.setProduct_size(osp.getProduct_sizeArr()[i]); // 품목 규격
					osp2.setOut_schedule_qty(osp.getOut_schedule_qtyArr()[i]); // 출고 예정 수량
					
					if(osp.getRemarks_proArr()[i] == null) {
						osp2.setRemarks_pro("");
					} else {
						osp2.setRemarks_pro(osp.getRemarks_proArr()[i]); // 비고
					}
					osp2.setOut_date(osp.getOut_dateArr()[i]); // 납기일자
					osp2.setStock_cd(osp.getStock_cdArr()[i]); // 재고번호
					
					osp2.setOut_schedule_cd(os.getOut_schedule_cd());
					
					System.out.println("osp2 : " + osp2);
					
					int updateCount2 = service.updateOutSchedulePro(osp2);
					
				}
				return "redirect:/OutList.os";
			}else { // 실패
				model.addAttribute("msg", "출고 예정 수정 실패!");
				return "fail_back";
			}
			
		}
		
		
		//--------출고처리 목록 표시 페이지 이동 -----------
		@GetMapping("/Out_Per_List")
		public String out_per_list(Model model) {
			List<OutSchedulePerProductVO> ospList = service.getOutschedulePerList();
//			System.out.println("처리리스트 : " + ospList);
			model.addAttribute("list",ospList);
			return "out_schedule/out_schedule_per_list";
		}// 출고 처리 목록 표시 페이지 이동 끝
		
		
		//-------------출고처리 팝업창-----------
		@GetMapping(value = "/Out_Per_List_popup")
		public String out_per_list_popup(@ModelAttribute OutSchedulePerProductVO vo,Model model) {
//			System.out.println(vo.getOut_schedule_per_cdArr().length);
			System.out.println(vo);

			try {
				List<OutSchedulePerProductVO> list = new ArrayList<OutSchedulePerProductVO>();
					for(int i=0;i<=vo.getOut_schedule_per_cdArr().length-1;i++) {
						OutSchedulePerProductVO vo2 = new OutSchedulePerProductVO();
						vo2.setOut_schedule_per_cd(vo.getOut_schedule_per_cdArr()[i]);
						vo2 = service.getOutschedulePerInfo(vo2); 
						list.add(vo2);
						
					}
					System.out.println(list);
					model.addAttribute("list",list);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "out_schedule/out_schedule_per_list_popup";
		}//출고처리 팝업창 끝

}
