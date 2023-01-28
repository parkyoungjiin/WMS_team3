package com.itwillbs.project.controller;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.google.protobuf.Service;
import com.itwillbs.project.service.EmpService;
import com.itwillbs.project.vo.EmpVo;

@Controller
public class EmpController {
	
	@Autowired
	private EmpService service;
	
	//------------인사 등록 폼 이동------------
	@GetMapping(value = "EmpInsertForm.em")
	public String EmpInsertForm() {
		
		return "emp/insert_form";
	}//EmpInsertForm 끝
	
	//------------인사 등록 작업---------------
	@PostMapping(value = "EmpInserPro.em")
	public String EmpInsertPro(@ModelAttribute EmpVo emp, HttpSession session, Model model) {
		
		String uploadDir = "/resources/upload"; // 가상의 업로드 경로(루트(webapp) 기준)
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		
		// 만약, 해당 경로 상에 실제 디렉토리(폴더)가 존재하지 않을 경우 새로 생성
		File f = new File(saveDir);	
		if(!f.exists()) {
			f.mkdirs(); // 지정된 경로 상에 존재하지 않는 모든 경로를 차례대로 생성
		}
		
		MultipartFile mFile = emp.getPHOTO();
		// MultipartFile 객체의 getOriginalFilename() 메서드를 통해 파일명 꺼내기
		String originalFileName = mFile.getOriginalFilename(); //원본 파일명
		System.out.println("원본 파일명: " +originalFileName);

//		int InsertCount = service.InsertEmployee(emp);
		return "";
	}//EmpInsertPro 끝
	
	
	
	
	
	
}//EmpController 끝
