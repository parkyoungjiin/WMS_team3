package com.itwillbs.project.controller;

import java.io.File;
import java.io.IOException;
import java.text.Format;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
		//파일 업로드
		
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
		//,를 기준으로 분리한 값을 telArr(배열)에 넣음.
		//개인 연락처 결합
		String [] emp_telArr = emp.getEMP_TEL().split(",");
		for(int i=0; i<emp_telArr.length; i++) {
			String EMP_TEL = emp_telArr[i].join("-", emp_telArr);
//			System.out.println(EMP_TEL);
			emp.setEMP_TEL(EMP_TEL);
			
		}
		//사무실 연락처 결합
		String [] emp_dtelArr = emp.getEMP_DTEL().split(",");
		for(int i=0; i<emp_dtelArr.length; i++) {
			String EMP_DTEL = emp_dtelArr[i].join("-", emp_dtelArr);
			emp.setEMP_DTEL(EMP_DTEL);
			
		}
		//이메일1,이메일2 결합
		String [] emp_emailArr = emp.getEMP_EMAIL().split(",");
		for(int i=0; i<emp_emailArr.length; i++) {
			String EMP_EMAIL = emp_emailArr[i].join("@", emp_emailArr);
//			System.out.println(EMP_EMAIL);
			emp.setEMP_EMAIL(EMP_EMAIL);
			
		}
		//주소, 상세주소 결합
		String [] emp_addrArr = emp.getEMP_ADDR().split(",");
		for(int i=0; i<emp_addrArr.length; i++) {
			String EMP_ADDR = emp_addrArr[i].join(" ", emp_addrArr);
//			System.out.println(EMP_ADDR);
			emp.setEMP_ADDR(EMP_ADDR);
			
		}
		//**사원 코드(EMP_NAME) 결합** 
		// -> 사원코드(EMP_NUM) = 부서코드(2)+입사년도(2)+인덱스(3)(= 총 7자리), 자동부여
		// 부서코드, 입사년도만 결합을 해서 set 저장한 뒤에 xml 파일에서 인덱스 결합
		SimpleDateFormat year_format = new SimpleDateFormat("yy");
		String year = year_format.format(emp.getHIRE_DATE());
		// idx 앞에 0을 붙이기 위해 select 후에 format 함수 사용
		int idx = service.getSelectIdx(emp) + 1;

		//fomrat을 사용하여 00x 형태로 setEMP_NUM 작업을 수행
		String EMP_IDX = String.format("%03d", idx); //00x 형태 변환
		String EMP_NUM = emp.getDEPT_CD() + year + EMP_IDX; // 부서코드(2)+입사년도(2)+인덱스(3)
		emp.setEMP_NUM(EMP_NUM); //set으로 EMP_NUM 저장
		
		
		//비밀번호 해싱 작업
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
		String securePasswd = passwdEncoder.encode(emp.getEMP_PASSWD());
		emp.setEMP_PASSWD(securePasswd);
		
		System.out.println(emp);
		//사원 등록 작업
		int InsertCount = service.InsertEmployee(emp);
		if(InsertCount > 0) {
			return "redirect:/";
		}else { // 실패
			model.addAttribute("msg", "사원 등록 실패!");
			return "fail_back";
		}
	}//EmpInsertPro 끝
	
	//-------------로그인 폼 이동----------------
	@GetMapping(value = "EmpLoginForm.em")
	public String LoginForm() {
		
		return "emp/login_form";
	}//LoginForm 끝
	
	//-------------로그인 작업-----------------
	@PostMapping(value = "EmpLoginPro.em")
	public String LoginPro(@ModelAttribute EmpVo emp, Model model, HttpSession session) {
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
		//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
		String passwd = service.getSelectPass(emp.getEMP_EMAIL());
		if(passwd == null || !passwdEncoder.matches(emp.getEMP_PASSWD(), passwd)) { // 실패
			// Model 객체에 "msg" 속성명으로 "로그인 실패!" 메세지 저장 후
			// fail_back.jsp 페이지로 포워딩
			model.addAttribute("msg", "로그인 실패!");
			return "fail_back";
		} else { // 성공
			// HttpSession 객체에 세션 아이디 저장 후 메인페이지로 리다이렉트
			//세션에 저장할 이름값 가져오기
			String emp_name = service.getSelectName(emp.getEMP_EMAIL());
			session.setAttribute("sId", emp_name); //이름 저장
			return "redirect:/";
		}
	}
	
	//-------------로그아웃 작업------------
	@GetMapping(value = "EmpLogout.me")
	public String logout(HttpSession session) {
		// 세션 초기화
		session.invalidate();
		return "redirect:/";
	}
	
	
}//EmpController 끝
