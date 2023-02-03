package com.itwillbs.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.project.service.Out_ScheduleService;

@Controller
public class Out_ScheduleController {

	@Autowired
	private Out_ScheduleService service;
	
	
	// ---------- 출고 관리 - 출고 예정 목록 ----------
	@GetMapping(value = "OutList")
	public String outList() {
		return "out_schedule/out_list";
	} // outList 끝

	
	
	// ---------- 출고 관리 - 출고 예정 등록 폼 ----------
	@GetMapping(value = "OutRegisterForm")
	public String outResiterForm() {
		return "out_schedule/out_register";
	} // outResiterForm
	
}
