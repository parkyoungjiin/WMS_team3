package com.itwillbs.project.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
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
	@PostMapping(value = "EmpInsertPro.em")
	public String EmpInsertPro(@ModelAttribute EmpVo emp, HttpSession session, Model model) {
		System.out.println(emp);
		//1. 경로 설정 (가상 경로, 실제 업로드 경로)
		String uploadDir = "/resources/upload"; // 가상의 업로드 경로(루트(webapp) 기준)
		String saveDir = session.getServletContext().getRealPath(uploadDir); //실제 업로드 경로
		System.out.println("실제 업로드 경로:" + saveDir);
		
		//2. 만약, 해당 경로 상에 실제 디렉토리(폴더)가 존재하지 않을 경우 새로 생성
		
		File f = new File(saveDir);	
		if(!f.exists()) {
			f.mkdirs(); // 지정된 경로 상에 존재하지 않는 모든 경로를 차례대로 생성
		}
		//3. MultipartFile 객체 생성(Vo의 file은 MutlipartFile 타입 / PHOTO는 String 타입)
		// => *** MutlipartFile 타입으로 원본 파일명을 꺼낸 후에 파일명을 String 타입으로 저장 ***
		
		MultipartFile mFile = emp.getFile();
		//4. MultipartFile 객체의 getOriginalFilename() 메서드를 통해 파일명 꺼내기
		String originalFileName = mFile.getOriginalFilename(); //원본 파일명
		System.out.println("원본 파일명: " +originalFileName);
		System.out.println("파일명: " +mFile.getName());
		//5. 원본 파일명을 empVo에 저장
		emp.setPHOTO(originalFileName);
		//6. transferTo를 통해 파일 업로드
		try {
			mFile.transferTo(
					new File(saveDir, mFile.getOriginalFilename())
				);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
//		int InsertCount = service.InsertEmployee(emp);
//		if(InsertCount > 0) {
//			return "index";
//		}else { // 실패
//			model.addAttribute("msg", "사원 등록 실패!");
//			return "fail_back";
//		}
		return "index";
	}//EmpInsertPro 끝
	
	
	
	
	
	
}//EmpController 끝
