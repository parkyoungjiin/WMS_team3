package com.itwillbs.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.itwillbs.project.service.WareHouseService;
import com.itwillbs.project.vo.WareHouseVO;


@Controller
public class WareHouseController {
	
	@Autowired
	private WareHouseService service;
	
	
	//------------창고 리스트 작업---------------
	@ResponseBody
	@GetMapping(value = "WareHouseListJsonPro.wh")
	public void whlist(Model model,HttpServletResponse response) {
		List<WareHouseVO> whlist = service.getwhList();
		JSONArray jsonArray = new JSONArray();
		
		// 1. List 객체 크기만큼 반복
		for(WareHouseVO list: whlist) {
			// 2. JSONObject 클래스 인스턴스 생성
			// => 파라미터 : VO(Bean) 객체(멤버변수 및 Getter/Setter, 기본생성자 포함)
			JSONObject jsonObject = new JSONObject(list);
			System.out.println(jsonObject);
			
			// 참고. 저장되어 있는 JSON 데이터를 꺼낼 수도 있다! - get() 메서드 활용
//			System.out.println(jsonObject.get("board_pass"));
			
			// 3. JSONArray 객체의 put() 메서드를 호출하여 JSONObject 객체 추가
			jsonArray.put(jsonObject);
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonArray); // toString() 생략됨
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
		//------------창고 구역 리스 작업---------------
		@ResponseBody
		@GetMapping(value = "WareHouseAreaListJsonPro.wh")
		public void wharealist(Model model,HttpServletResponse response) {
			List<WareHouseVO> wharealist = service.getwhAreaList();
			JSONArray jsonArray = new JSONArray();
			System.out.println(wharealist);
			for(WareHouseVO list: wharealist) {
				JSONObject jsonObject = new JSONObject(list);
				System.out.println(jsonObject);
				jsonArray.put(jsonObject);
			}
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonArray); // toString() 생략됨
		} catch (IOException e) {
			e.printStackTrace();
		}
	}//whlist 끝
		//------------창고 구역 리스 작업---------------
		@ResponseBody
		@GetMapping(value = "WareHouseLocInListJsonPro.wh")
		public void whareainlist(Model model,HttpServletResponse response) {
			List<WareHouseVO> whareainlist = service.getwhAreaLocInList();
			JSONArray jsonArray = new JSONArray();
			System.out.println(whareainlist);
			for(WareHouseVO list: whareainlist) {
				JSONObject jsonObject = new JSONObject(list);
				System.out.println(jsonObject);
				jsonArray.put(jsonObject);
			}
			try {
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(jsonArray); // toString() 생략됨
			} catch (IOException e) {
				e.printStackTrace();
			}
		}//whlist 끝
	
		
		
		
	//------------창고 리스트 작업---------------
	
	@GetMapping(value = "WareHouseListPro.wh")
	public String whlistPro(Model model) {
		List<WareHouseVO> whlist = service.getwhList();
		
		model.addAttribute("whlist",whlist);
		return "warehouse/wh_list";
	}//whlist 끝
	
	
	//------------창고 등록 작업---------------
	@GetMapping(value = "WareHouseInsertForm.wh")
	public String whinsert() {
		return "warehouse/wh_insert";
	}//whinert 끝
	
	//------------창고 등록 작업---------------
	@PostMapping(value = "WareHouseInserPro.wh")
	public String whinsertPro(@ModelAttribute WareHouseVO vo,HttpServletResponse response) {
		System.out.println(vo);
		System.out.println(vo.getWh_tel());
		boolean insertResult = service.insertWh(vo);
		   System.out.println(insertResult);
		   response.setContentType("text/html; charset=UTF-8");
         try {
        	PrintWriter out = response.getWriter();
        	if(insertResult) {
            out.println("<script>");
            out.println("alert('등록 완료!')");
            out.println("</script>");
         } else {
               out.println("<script>");
               out.println("alert('등록 실패')");
               out.println("history.back()");
               out.println("</script>");
         }
      } catch (IOException e) {
         e.printStackTrace();
      }
		return "redirect:/WareHouseListPro.wh";
	}//whinsertPro 끝
	
	//------------창고 상세페이지 작업---------------
	@GetMapping(value = "WareHouseInfo.wh")
	public String whInfo(@RequestParam(defaultValue = "1")String wh_cd,Model model) {
		WareHouseVO vo = service.getWarehouse(wh_cd);
	         vo.setWh_tel1(vo.getWh_tel().substring(0,3));
	         vo.setWh_tel2(vo.getWh_tel().substring(4,7));
	         vo.setWh_tel3(vo.getWh_tel().substring(8,12));
	         
	         if(vo.getWh_addr().equals(",")){
	 			 vo.setWh_addr("");
	 		 }else if(!vo.getWh_addr().equals("")) {
	 			 String[] arr = vo.getWh_addr().split(",");
	 			 vo.setWh_addr(arr[0]);
	 		 	 vo.setWh_addr_detail(arr[1]);
	 		 }
		System.out.println(vo);
		model.addAttribute("wh",vo);
		return "warehouse/wh_info";
	}//whInfo 끝
	
	//------------창고 상세페이지 작업---------------
	@ResponseBody
	@GetMapping(value = "WareHouseInfoJson.wh")
	public void whInfoJson(@RequestParam(defaultValue = "1")String wh_cd,Model model,HttpServletResponse response) {
		WareHouseVO vo = service.getWarehouse(wh_cd);
		System.out.println(vo);
		vo.setWh_tel1(vo.getWh_tel().substring(0,3));
		vo.setWh_tel2(vo.getWh_tel().substring(4,7));
		vo.setWh_tel3(vo.getWh_tel().substring(8,12));
		
		if(vo.getWh_addr().equals(",")){
			vo.setWh_addr("");
		}else if(!vo.getWh_addr().equals("")) {
			String[] arr = vo.getWh_addr().split(",");
			vo.setWh_addr(arr[0]);
//	 		 	System.out.println(arr[0]);
			vo.setWh_addr_detail(arr[1]);
		}
		System.out.println(vo);
		JSONObject jsonObject = new JSONObject(vo);
		
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonObject); // toString() 생략됨
		} catch (IOException e) {
			e.printStackTrace();
		}
	}//whInfo 끝
	
	
	//------------창고 상세페이지 작업(이름 클릭 시)---------------
	@GetMapping(value = "WareHouseInfoName.wh")
	public String whInfoName(
			@RequestParam(defaultValue = "1")String wh_cd,
			@RequestParam(defaultValue = "1")String wh_name,Model model) {
		WareHouseVO vo = service.getWarehouseName(wh_cd,wh_name);
		vo.setWh_tel1(vo.getWh_tel().substring(0,3));
		vo.setWh_tel2(vo.getWh_tel().substring(4,7));
		vo.setWh_tel3(vo.getWh_tel().substring(8,12));
//		vo.setWh_addr_detail(vo.getWh_addr_detail().substring(0));
//		System.out.println(vo.getWh_addr_detail().split(","));
		System.out.println(vo.getWh_addr());
		if(vo.getWh_addr().equals(",")){
			vo.setWh_addr("");
		}else if(!vo.getWh_addr().equals("")) {
			String[] arr = vo.getWh_addr().split(",");
			vo.setWh_addr(arr[0]);
//			System.out.println(arr[0]);
			vo.setWh_addr_detail(arr[1]);
		}
		
		System.out.println(vo);
		model.addAttribute("wh",vo);
		return "warehouse/wh_info";
	}//whInfo 끝
	
	//------------창고 수정 작업---------------
	@ResponseBody
	@PostMapping(value = "WhModify.wh")
	public void whModify(WareHouseVO vo,@RequestParam(defaultValue = "1")String wh_cd) {
		System.out.println("WhModify.wh: "+vo);
		service.whModify(vo,wh_cd);
	}//whModify 끝

	//------------창고 상세페이지 작업(이름 클릭 시)---------------
	@ResponseBody
	@GetMapping(value = "WhCodeCheck.wh")
	public void WhCodeCheck(@RequestParam(defaultValue = "1")String wh_cd,HttpServletResponse response ) {
		System.out.println(wh_cd);
		int count = service.getDB_wh_cd(wh_cd);
		try {
			response.getWriter().print(count);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("COUNT:"+count);
	}//WhCodeCheck 끝
	
	//------------창고 지역 목록 조회 작업---------------
	@GetMapping(value = "WareHouseManage.wh")
	public String manage(Model model) {
		List<WareHouseVO> whlist = service.getwhList();
		
		model.addAttribute("whlist",whlist);
		return "warehouse/wh_manage";
	}//창고 목록 조회 끝
	//------------창고 지역 등록 작업---------------
	@GetMapping(value = "WareHouseAreaInsertPro.wh")
	public String manage(@ModelAttribute WareHouseVO vo,@RequestParam(defaultValue = "1")int wh_cd ) {
		System.out.println(vo);
		service.WhAreaInsert(vo);
		return "redirect:/WareHouseManage.wh";
	}//등록 작업 끝
	
	//------------창고 선반 등록 작업---------------
	@GetMapping(value = "WareHouseLocAreaInsertPro.wh")
	public String manageLoc(@ModelAttribute WareHouseVO vo,@RequestParam(defaultValue = "1")int wh_cd ) {
		System.out.println(vo);
		service.WhLocAreaInsert(vo);
		return "redirect:/WareHouseManage.wh";
	}//선반 등록 끝
	
	//------------창고 지역 삭제 작업---------------
	@GetMapping(value = "WareHouseAreadeletePro.wh")
	public String managedelete(@RequestParam(defaultValue = "1")int wh_area_cd ) {
		System.out.println(wh_area_cd);
		service.WhAreaDelte(wh_area_cd);
		return "redirect:/WareHouseManage.wh";
	}//창고 지역 끝
	
	
	//------------창고 선반 삭제 작업---------------
	@GetMapping(value = "WareHouseLocAreadeletePro.wh")
	public String manlocagedelete(@RequestParam(defaultValue = "1")int wh_loc_in_area_cd ) {
		System.out.println(wh_loc_in_area_cd);
		service.WhLocAreaDelte(wh_loc_in_area_cd);
		return "redirect:/WareHouseManage.wh";
	}//창고 지역 끝
	
	//------------창고 지역 수정 작업---------------
	@GetMapping(value = "WareHouseAreaUpdatePro.wh")
	public String manageupdate(@ModelAttribute WareHouseVO vo) {
		System.out.println(vo);
		service.WhAreaupdate(vo);
		return "redirect:/WareHouseManage.wh";
	}//창고 지역 끝
	//------------창고 지역 수정 작업---------------
	@GetMapping(value = "WareHouseLocAreaUpdatePro.wh")
	public String manlocageupdate(@ModelAttribute WareHouseVO vo) {
		System.out.println(vo);
		service.WhAreaLocupdate(vo);
		return "redirect:/WareHouseManage.wh";
	}//창고 지역 끝
	
	//------------창고 상세페이지 작업---------------
		@ResponseBody
		@GetMapping(value = "WareHouseStockListJsonPro.wh")
		public void stocklistJson(@ModelAttribute WareHouseVO vo,Model model,HttpServletResponse response) {
			System.out.println(vo);
			List<WareHouseVO> stocklist = null;
				stocklist = service.getStockList(vo);
				JSONArray jsonArray = new JSONArray();
			
			for(WareHouseVO list: stocklist) {
				JSONObject jsonObject = new JSONObject(list);
				System.out.println(jsonObject);
				jsonArray.put(jsonObject);
			}
			try {
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(jsonArray); // toString() 생략됨
			} catch (IOException e) {
				e.printStackTrace();
			}
		}//whInfo 끝
}//WareHouseController 끝
