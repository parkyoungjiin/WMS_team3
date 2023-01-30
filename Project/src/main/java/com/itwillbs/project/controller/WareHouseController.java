package com.itwillbs.project.controller;

import java.io.File;
import java.io.IOException;
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

import com.itwillbs.project.service.WareHouseService;
import com.itwillbs.project.vo.WareHouseVO;


@Controller
public class WareHouseController {
	
	@Autowired
	private WareHouseService service;
	
	//------------창고 리스트 작업---------------
	@GetMapping(value = "WareHouseListPro.wh")
	public String whlist(Model model) {
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
	@GetMapping(value = "WareHouseInserPro.wh")
	public String whinsertPro(@ModelAttribute WareHouseVO vo) {
		System.out.println(vo);
		System.out.println(vo.getWh_tel());
		
		boolean insertResult = service.insertWh(vo);
		return "warehouse/wh_list";
	}//whinsertPro 끝
	
		//------------창고 상세페이지 작업---------------
		@GetMapping(value = "WareHouseInfo.wh")
		public String whInfo(@RequestParam(defaultValue = "1")String wh_cd,Model model) {
			WareHouseVO vo = service.getWarehouse(wh_cd);
		         vo.setWh_tel1(vo.getWh_tel().substring(0,3));
		         vo.setWh_tel2(vo.getWh_tel().substring(4,7));
		         vo.setWh_tel3(vo.getWh_tel().substring(8,12));
		         
			System.out.println(vo);
			model.addAttribute("wh",vo);
			return "warehouse/wh_info";
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
			
			System.out.println(vo);
			model.addAttribute("wh",vo);
			return "warehouse/wh_info";
		}//whInfo 끝
		
		//------------창고 수정 작업---------------
		@ResponseBody
		@PostMapping(value = "WhModify.wh")
		public void whModify(WareHouseVO vo,	@RequestParam(defaultValue = "1")String wh_cd) {
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
}//WareHouseController 끝
