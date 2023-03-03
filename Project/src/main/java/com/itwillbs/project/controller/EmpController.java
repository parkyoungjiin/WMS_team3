package com.itwillbs.project.controller;

import java.io.File;
import java.io.IOException;

import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.Format;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project.service.EmpService;
import com.itwillbs.project.vo.EmpVo;
import com.itwillbs.project.vo.PageInfo;

@Controller
public class EmpController {
	
	@Autowired
	private EmpService service;
	//===================================== 인사 파트 1 : 영진 ================================================

	//------------인사 등록 폼 이동------------
	@GetMapping(value = "EmpInsertForm.em")
	public String EmpInsertForm() {
		
		return "emp/employee_insert_form";
	}//EmpInsertForm 끝
	
	//------------인사 등록 작업---------------
	@PostMapping(value = "EmpInsertPro.em")
	public String EmpInsertPro(@ModelAttribute EmpVo emp, HttpSession session, Model model) {
		System.out.println(emp);
		
		//---------------------------------- 파일 업로드 ------------------------------------
		// 1. 경로 설정 (가상 경로, 실제 업로드 경로)
		String uploadDir = "/resources/upload"; // 가상의 업로드 경로(루트(webapp) 기준)
		String saveDir = session.getServletContext().getRealPath(uploadDir); //실제 업로드 경로
		System.out.println("실제 업로드 경로:" + saveDir);
		
		// 2. 만약, 해당 경로 상에 실제 디렉토리(폴더)가 존재하지 않을 경우 새로 생성
		
		File f = new File(saveDir);	
		if(!f.exists()) {
			f.mkdirs(); // 지정된 경로 상에 존재하지 않는 모든 경로를 차례대로 생성
		}
		// 3. MultipartFile 객체 생성(Vo의 file은 MutlipartFile 타입 / PHOTO는 String 타입)
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
			
			
			
		}//-------------------------------------------------------------------------
		
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
			String EMP_ADDR = emp_addrArr[i].join(",", emp_addrArr);
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
		System.out.println("EMP_IDX : " + EMP_IDX);
		String EMP_NUM = emp.getDEPT_CD() + year + EMP_IDX; // 부서코드(2)+입사년도(2)+인덱스(3)
		emp.setEMP_NUM(EMP_NUM); //set으로 EMP_NUM 저장
		//임시 비밀번호 생성 작업 (service에서 정의한 메서드 가져오기)
		String tempPasswd = service.getTempPassWd(8);
		//생성 한 비밀번호 vo에 담기 
		emp.setEMP_PASSWD(tempPasswd);
		System.out.println("임시비밀번호 : " + emp.getEMP_PASSWD());
		//비밀번호 해싱 작업
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
		String securePasswd = passwdEncoder.encode(emp.getEMP_PASSWD());
		emp.setEMP_PASSWD(securePasswd);
		
		//권한 결합 작업
		String [] emp_priv_arr = emp.getPRIV_CD().split(",");
		for(int i=0; i<emp_priv_arr.length; i++) {
			String PRIV_CD = emp_priv_arr[i].join("", emp_priv_arr);
//			System.out.println(EMP_EMAIL);
			emp.setPRIV_CD(PRIV_CD);
			
		}
		
		System.out.println(emp);
		//사원 등록 작업
		int InsertCount = service.InsertEmployee(emp);
		if(InsertCount > 0) {
			//등록 성공 시 이메일 전송(임시비밀번호)
			emp.setEMP_PASSWD(tempPasswd);
			System.out.println("전송되는 비밀번호 :" + tempPasswd);
			service.sendTempLoginPwToEmail(emp);
			return "redirect:/EmployeeList.em";
		}else { // 실패
			model.addAttribute("msg", "사원 등록 실패!");
			return "fail_back";
		}
	}//EmpInsertPro 끝
	
	//-------------로그인 폼 이동----------------
	@GetMapping(value = "EmpLoginForm.em")
	public String LoginForm() {
		
		return "emp/employee_login_form";
	}//LoginForm 끝
	
	//-------------로그인 작업-----------------
	@PostMapping(value = "EmpLoginPro.em")
	public String LoginPro(@ModelAttribute EmpVo emp, Model model, HttpSession session) {
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
		//판별 작업 전 @로 구분 되어 있는 email값 @ 문자열 결합 작업
		//이메일1,이메일2 결합
		String [] emp_emailArr = emp.getEMP_EMAIL().split(",");
		for(int i=0; i<emp_emailArr.length; i++) {
			String EMP_EMAIL = emp_emailArr[i].join("@", emp_emailArr);
			emp.setEMP_EMAIL(EMP_EMAIL);
		}
		//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
		
		String passwd = service.getSelectPass(emp.getEMP_EMAIL()); // DB에 저장된 pass가져오기
		String work_cd = service.getSelectWorkCd(emp.getEMP_EMAIL()); //DB에 저장된 work_cd 가져오기
		System.out.println("work_cd : " + work_cd);
		//로그인 작업(비밀번호 일치여부 판별)
		if(passwd == null || !passwdEncoder.matches(emp.getEMP_PASSWD(), passwd)) { // 실패
			// Model 객체에 "msg" 속성명으로 "로그인 실패!" 메세지 저장 후
			// fail_back.jsp 페이지로 포워딩
				model.addAttribute("msg", "로그인 실패(아이디 또는 비밀번호를 확인해주세요.)");
				return "fail_back";
		}else { // 성공
			if(!work_cd.equals("C1")) {
				model.addAttribute("msg", "로그인 실패(휴직자 및 퇴직자는 로그인할 수 없습니다.)");
				return "fail_back";
			}else {
				
				// HttpSession 객체에 세션 아이디 저장 후 메인페이지로 리다이렉트
				//세션에 저장할 이름값,권한코드,idx값 가져오기
				emp = service.getSelectName(emp.getEMP_EMAIL());
				session.setAttribute("sId", emp.getEMP_NAME()); //이름 저장
				session.setAttribute("priv_cd", emp.getPRIV_CD()); //권한코드 저장
				session.setAttribute("emp_num", emp.getEMP_NUM()); //사원코드 저장
				session.setAttribute("idx", emp.getIDX()); //idx 저장
				session.setAttribute("PHOTO", emp.getPHOTO()); // PHOTO 저장
				
				System.out.println("#####################################################################33");
				System.out.println("emp ; "+emp);
				return "redirect:/";
			}
			
		}
	}//LoginPro 끝 
	
	//-------------로그아웃 작업------------
	@GetMapping(value = "EmpLogout.em")
	public String logout(HttpSession session) {
		// 세션 초기화
		session.invalidate();
		return "redirect:/";
	}//logout 끝
	
	//------------이메일 중복 확인------------
	@ResponseBody
	@PostMapping(value = "EmpEmailCheck.em")
	public void emailCheck(@RequestParam(defaultValue = "") String check_email, @ModelAttribute EmpVo emp, HttpServletResponse response) {
		System.out.println(check_email);
		//check_email로 넘긴 이메일과 일치하는 emp 레코드를 vo에 저장한다.
		Integer selectResult = service.getEmailCheck(check_email);
		// 만약 selectResult 값이 null인 경우(중복이 아닌 경우) null값을 0으로 변환
		if(selectResult == null) {
			selectResult = 0;
		}
			try {
				response.getWriter().print(selectResult); //emailcheck 값을 보내는 작업
			} catch (Exception e) {
				e.printStackTrace();
			}
		//emp에 값이 없을 경우 이메일 미중복 => true
		
	}

	//===================================== 인사 파트 2 : 채원 ================================================
		//-------------- 사원 목록 출력------------
		@GetMapping("/EmployeeList.em")
		public String emplList(Model model, HttpSession session,
				@RequestParam(defaultValue = "") String keyword,
				@RequestParam(defaultValue = "1") int pageNum) {
	
			int listLimit = 10;
			int startRow = (pageNum-1) * listLimit;
			
			
			List<EmpVo> employeeList = service.getEmployeeList(keyword); // 검색 모달용
			List<EmpVo> empList = service.getEmpList(keyword,startRow,listLimit); // 인사 목록용
			
			int listCount = service.getEmpListCount(keyword);
			int pageListLimit = 10;
			int maxPage = listCount / listLimit + (listCount % listLimit == 0 ? 0:1);
			int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
			int endPage = startPage + pageListLimit - 1;
			if(endPage > maxPage) {
				endPage = maxPage;
			}
			// PageInfo 객체 생성 후 페이징 처리 정보 저장
			PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
			model.addAttribute("pageInfo", pageInfo);
			
			model.addAttribute("empList",empList);
			return "emp/employee_list";			
		} // 사원 목록 끝 
		
		// --------- 사원목록 json -------------
//		@ResponseBody
//		@GetMapping(value="EmployeeListJson.em")
//		public void listJson(Model model, HttpServletResponse response,@RequestParam(defaultValue = "") String WORK_CD, @RequestParam(defaultValue = "") String keyword) {
//			List<EmpVo> employeeList = service.getEmployeeList(WORK_CD);
//			System.out.println("리스트 워크코드" + WORK_CD);
//			
//			JSONArray jsonArray = new JSONArray();
//			
//			for(EmpVo employee : employeeList) { 
//				JSONObject jsonObject = new JSONObject(employee);
//				jsonArray.put(jsonObject);
//			}
//			
//			try {
//				response.setCharacterEncoding("UTF-8");
//				response.getWriter().print(jsonArray); // toString() 생략
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//			
//			
//		}// 사원 목록 json 끝
		
		// ------------ 사원 상세정보 조회 ------------------
		@GetMapping(value="/EmployeeDetail.em")
		public String empDetail(@RequestParam String EMP_NUM
				, HttpSession session
				, @ModelAttribute EmpVo employee
				, Model model) {
			String sId = (String)session.getAttribute("sId");
//			String PRIV_CD = service.getPrivCode(sId);
			employee = service.getEmployee(EMP_NUM);
			
			String dTelArr[] = employee.getEMP_DTEL().split("-");
//			System.out.println(dTelArr[0] + ", " + dTelArr[2]);
			String dTel1 = dTelArr[1];
			String dTel2 = dTelArr[2];
			model.addAttribute("dTel1",dTel1);
			model.addAttribute("dTel2",dTel2);
			
			// 전화번호 분리하기
			String telArr[] = employee.getEMP_TEL().split("-");
			String tel1 = telArr[1];
			String tel2 = telArr[2];
			model.addAttribute("tel1",tel1);
			model.addAttribute("tel2",tel2);
			
			// email 분리하기
			String emailArr[] = employee.getEMP_EMAIL().split("@");
			String email1 = emailArr[0];
			String email2 = emailArr[1];
			model.addAttribute("email1", email1);
			model.addAttribute("email2",email2);
			
			String addrArr[] = employee.getEMP_ADDR().split(",");
			String addr1 = addrArr[0];
			String addr2 = addrArr[1];
			model.addAttribute("addr1",addr1);
			model.addAttribute("addr2",addr2);
			
			String privArr[] = employee.getPRIV_CD().split("");
			String prCd1 = privArr[0];
			String prCd2 = privArr[1];
			String prCd3 = privArr[2];
			String prCd4 = privArr[3];
			String prCd5 = privArr[4];
//			System.out.println("권한 array 확인 : " + prCd1 + ", " + prCd2 + ", " + prCd3 + ", " + prCd4 + ", " + prCd5);
			model.addAttribute("prCd1",prCd1);
			model.addAttribute("prCd2",prCd2);
			model.addAttribute("prCd3",prCd3);
			model.addAttribute("prCd4",prCd4);
			model.addAttribute("prCd5",prCd5);
			
			model.addAttribute("employee", employee);

			return "emp/employee_detail";
		
		} // 사원 상세정보 조회 끝
			
		// ------------ 사원 정보 수정 폼 --------------------
		@GetMapping(value="/EmployeeModifyForm.em")
		public String empModifyForm(@RequestParam String EMP_NUM, Model model) {
			EmpVo employee = service.getEmployee(EMP_NUM);
			// 사무실 전화번호 분리하기
			String dTel1 = employee.getEMP_DTEL().substring(4, 7);
			String dTel2 = employee.getEMP_DTEL().substring(8, 12);
			System.out.println("전화번호 분리" + dTel1 + "," + dTel2);
			model.addAttribute("dTel1",dTel1);
			model.addAttribute("dTel2",dTel2);
			
			// 전화번호 분리하기
			String telArr[] = employee.getEMP_TEL().split("-");
			System.out.println(telArr[1] + ", 두번째는" + telArr[2]);
			String tel1 = telArr[1];
			String tel2 = telArr[2];
			model.addAttribute("tel1",tel1);
			model.addAttribute("tel2",tel2);
			
			// email 분리하기
			String emailArr[] = employee.getEMP_EMAIL().split("@");
			String email1 = emailArr[0];
			String email2 = emailArr[1];
			model.addAttribute("email1", email1);
			model.addAttribute("email2",email2);
			
			// 
			String addrArr[] = employee.getEMP_ADDR().split(",");
			String addr1 = addrArr[0];
			String addr2 = addrArr[1];
			model.addAttribute("addr1",addr1);
			model.addAttribute("addr2",addr2);
			System.out.println( "주소 "+employee.getEMP_ADDR());
			
			String privArr[] = employee.getPRIV_CD().split("");
			String prCd1 = privArr[0];
			String prCd2 = privArr[1];
			String prCd3 = privArr[2];
			String prCd4 = privArr[3];
			String prCd5 = privArr[4];
//			System.out.println("권한 array 확인 : " + prCd1 + ", " + prCd2 + ", " + prCd3 + ", " + prCd4 + ", " + prCd5);
			model.addAttribute("prCd1",prCd1);
			model.addAttribute("prCd2",prCd2);
			model.addAttribute("prCd3",prCd3);
			model.addAttribute("prCd4",prCd4);
			model.addAttribute("prCd5",prCd5);
			
			model.addAttribute("employee", employee);
			return "emp/employee_modify_form";
		} // 사원 정보 폼 끝
		
		// ----------- 사원 정보 수정 비즈니스 로직 -------------------
		@PostMapping(value="/EmployeeModifyPro.em")
		public String empModify(Model model, HttpSession session
							, @ModelAttribute EmpVo employee
							, @RequestParam(value = "file",required = false) MultipartFile file) {
			
			//------------- 이미지 수정 -------------------------------
			
			String uploadDir = "/resources/upload"; // 가상의 업로드 경로(루트(webapp) 기준)
			String saveDir = session.getServletContext().getRealPath(uploadDir); //실제 업로드 경로
			System.out.println("실제 업로드 경로:" + saveDir);

			String PHOTO = employee.getPHOTO(); // 기존 파일명을 설정
			 
//			if (file != null && !file.isEmpty()) { // 파일을 선택한 경우
			if (file != null) { // file 객체가 null이 아닌 경우에만 처리
			    if (!file.isEmpty()) { // 파일을 선택한 경우    
			    	PHOTO = file.getOriginalFilename().toString(); // 파일명을 설정
			    	System.out.println("PHOTO 파일명 : " + PHOTO);
			        // 파일 생성
			        File f = new File(saveDir,PHOTO); 	
			    	
					if(!f.exists()) {
						f.mkdirs(); // 지정된 경로 상에 존재하지 않는 모든 경로를 차례대로 생성
					}
					// MultipartFile 객체의 getOriginalFilename() 메서드를 통해 파일명 꺼내기
					try {
						// transferTo를 통해 파일 이동
						file.transferTo(f);
						
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
			    
			    } else { // 파일을 선택하지 않은 경우
			    	PHOTO = employee.getPHOTO(); // 기존 파일명을 설정
			    }
			} else { // file 객체가 null인 경우
				PHOTO = employee.getPHOTO(); // 기존 파일명을 설정
				System.out.println("파일명 :: "+ employee.getPHOTO());
			}
				employee.setPHOTO(PHOTO);	
//			employee.setPHOTO(PHOTO == null ? "" : PHOTO);
			//--------------------- 이미지 수정 끝 ------------------------
			
			//,를 기준으로 분리한 값을 telArr(배열)에 넣음.
			//개인 연락처 결합
			String [] emp_telArr = employee.getEMP_TEL().split(",");
			for(int i=0; i<emp_telArr.length; i++) {
				String EMP_TEL = emp_telArr[i].join("-", emp_telArr);
//				System.out.println(EMP_TEL);
				employee.setEMP_TEL(EMP_TEL);
				
			}
			System.out.println(employee);
			//사무실 연락처 결합
			String [] emp_dtelArr = employee.getEMP_DTEL().split(",");
			for(int i=0; i<emp_dtelArr.length; i++) {
				System.out.println("미친"+emp_dtelArr[i]);
				System.out.println("getEMP_DTEL : " + employee.getEMP_DTEL());
				String EMP_DTEL = emp_dtelArr[i].join("-", emp_dtelArr);
				employee.setEMP_DTEL(EMP_DTEL);
				
			}
			//이메일1,이메일2 결합
			String [] emp_emailArr = employee.getEMP_EMAIL().split(",");
			for(int i=0; i<emp_emailArr.length; i++) {
				String EMP_EMAIL = emp_emailArr[i].join("@", emp_emailArr);
//				System.out.println(EMP_EMAIL);
				employee.setEMP_EMAIL(EMP_EMAIL);
				
			}
			//주소, 상세주소 결합
			String [] emp_addrArr = employee.getEMP_ADDR().split(",");
			for(int i=0; i<emp_addrArr.length; i++) {
				String EMP_ADDR = emp_addrArr[i].join(",", emp_addrArr);
//				System.out.println(EMP_ADDR);
				employee.setEMP_ADDR(EMP_ADDR);
				
			}
			//**사원 코드(EMP_NAME) 결합** 
			// -> 사원코드(EMP_NUM) = 부서코드(2)+입사년도(2)+인덱스(3)(= 총 7자리), 자동부여
			// 부서코드, 입사년도만 결합을 해서 set 저장한 뒤에 xml 파일에서 인덱스 결합
			SimpleDateFormat year_format = new SimpleDateFormat("yy");
			String year = year_format.format(employee.getHIRE_DATE());
			// idx 앞에 0을 붙이기 위해 select 후에 format 함수 사용
			int idx = service.getSelectIdx(employee);

			//fomrat을 사용하여 00x 형태로 setEMP_NUM 작업을 수행
			String EMP_IDX = String.format("%03d", idx); //00x 형태 변환
			String EMP_NUM = employee.getDEPT_CD() + year + EMP_IDX; // 부서코드(2)+입사년도(2)+인덱스(3)
			employee.setEMP_NUM(EMP_NUM); //set으로 EMP_NUM 저장
			
			//권한 결합 작업
			String [] emp_priv_arr = employee.getPRIV_CD().split(",");
			for(int i=0; i<emp_priv_arr.length; i++) {
				String PRIV_CD = emp_priv_arr[i].join("", emp_priv_arr);
//				System.out.println(EMP_EMAIL);
				employee.setPRIV_CD(PRIV_CD);
				
			}
			
			int updateCount = service.modifyEmployee(employee);
			System.out.println("수정 비즈니스 로직 : " + updateCount);
			
			if(updateCount > 0) { // 수정 성공
				model.addAttribute("msg","수정에 성공하였습니다");
				return "redirect:/EmployeeList.em"; //EmpList.em
			} else { // 수정 실패 
				model.addAttribute("msg","수정에 실패하였습니다");
				return "fail_back";
			} 
		
		} // 사원 정보 수정 끝 
		
			
		//======== 사원 수정 시 개별 파일 삭제 처리 ===============================
		// => 파라미터 : 글번호, 파일명, 세션 객체, 응답 객체 필요
		@ResponseBody
		@PostMapping("/DeleteImgFile")
		public void deleteImgFile(
				@RequestParam String EMP_NUM,
				@RequestParam String PHOTO,
				HttpSession session, HttpServletResponse response) {
			
			response.setCharacterEncoding("UTF-8");
			
			try {
					// Service 객체의 removeBoardFile() 메서드 호출하여 개별 파일 삭제 요청
					int deleteCount = service.removeImgFile(EMP_NUM, PHOTO);
					EmpVo vo =service.getEmployee(EMP_NUM);
					// DB 파일 삭제 성공 시 실제 파일 삭제
					if(deleteCount > 0) { // 삭제 성공
						String uploadDir = "/resources/upload"; // 가상의 업로드 경로(루트(webapp) 기준)
						String saveDir = session.getServletContext().getRealPath(uploadDir);
						
						Path path = Paths.get(saveDir);
						Files.deleteIfExists(path);
//						session.removeAttribute("PHOTO");
						response.getWriter().print("true");
					} else { // 삭제 실패
						response.getWriter().print("false");
					}
					
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		} //========================== 이미지 (수정) 삭제 끝============================
		
		//-------------마이페이지 이동------------
		@GetMapping(value = "MyPage.em") 
		public String mypage(HttpSession session, @ModelAttribute EmpVo emp, Model model) {
			
			if(session.getAttribute("emp_num") != null) {
				String EMP_NUM = (String)session.getAttribute("emp_num");
				//id에 맞는 사원정보 가져오기
				emp = service.getEmployee(EMP_NUM);
				// 개인 연락처 분리
				String emp_phone_number1 = emp.getEMP_TEL().substring(4, 8);
				String emp_phone_number2 = emp.getEMP_TEL().substring(9, 13);
				// 사무실 연락처 분리
				String emp_dtel_number1 = emp.getEMP_DTEL().substring(4,7);
				String emp_dtel_number2 = emp.getEMP_DTEL().substring(8,12);
				model.addAttribute("emp", emp);
				model.addAttribute("emp_phone_number1", emp_phone_number1);
				model.addAttribute("emp_phone_number2", emp_phone_number2);
				model.addAttribute("emp_dtel_number1", emp_dtel_number1);
				model.addAttribute("emp_dtel_number2", emp_dtel_number2);
				
				return "emp/employee_mypage";
			}else {
				model.addAttribute("msg","로그인이 필요한 페이지입니다.");
				return "redirect:/";
			}
				
		
		
	}//mypage 끝
	
	
	//-------------비밀번호 변경----------------
	@PostMapping(value = "ChangePasswd.em")
	public String changePass(HttpSession session, 
			@RequestParam("inputpasswd") String inputpasswd, 
			@RequestParam("newpasswd") String newpasswd,
			Model model) {
		//비밀번호 일치 여부 판별
//		System.out.println(inputpasswd);
		String emp_num = (String)session.getAttribute("emp_num"); //판별할 사원번호
		//비밀번호 해싱 작업
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
		String passwd = service.getSelectPasswd(emp_num); //패스워드 가져오기
		System.out.println("비밀번호: " + passwd);


		if(passwd == null |!passwdEncoder.matches(inputpasswd, passwd)) { //비밀번호 미일치 시
			model.addAttribute("msg","비밀번호가 일치하지 않습니다.");
			return "fail_back";
		}else {
			//일치할 경우 파라미터 newPassWd를 update
			String securePasswd = passwdEncoder.encode(newpasswd);
			//비밀번호 업데이트
			int updateCount = service.getUpdatePasswd(emp_num,securePasswd);
			//업데이트 성공 여부 판별
				if(updateCount > 0) {
					return "redirect:/MyPage.em";
				}else {
					model.addAttribute("msg","비밀번호 변경에 실패했습니다.");
					return "fail_back";
				}
		}
	}//changePass 끝
	
	// 상세정보에서의 비밀번호 변경
	@PostMapping(value = "ChangePasswdDetail.em")
	public String changePassDetail(HttpSession session, 
			@RequestParam("inputpasswd") String inputpasswd, 
			@RequestParam("newpasswd") String newpasswd,
			Model model) {
		//비밀번호 일치 여부 판별
//		System.out.println(inputpasswd);
		String emp_num = (String)session.getAttribute("emp_num"); //판별할 사원번호
		//비밀번호 해싱 작업
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
		String passwd = service.getSelectPasswd(emp_num); //패스워드 가져오기
		System.out.println("비밀번호: " + passwd);
		
		
		if(passwd == null |!passwdEncoder.matches(inputpasswd, passwd)) { //비밀번호 미일치 시
			model.addAttribute("msg","비밀번호가 일치하지 않습니다.");
			return "fail_back";
		}else {
			//일치할 경우 파라미터 newPassWd를 update
			String securePasswd = passwdEncoder.encode(newpasswd);
			//비밀번호 업데이트
			int updateCount = service.getUpdatePasswd(emp_num,securePasswd);
			//업데이트 성공 여부 판별
			if(updateCount > 0) {
//				model.addAttribute("msg","비밀번호 변경에 성공했습니다.");
				return "redirect:/EmployeeDetail.em?EMP_NUM=" + emp_num;
			}else {
				model.addAttribute("msg","비밀번호 변경에 실패했습니다.");
				return "fail_back";
			}
		}
	}//changePass 끝
	
	//-------------마이페이지  변경------------
	@PostMapping(value = "updateMypageInfo.me") 
	public String updateMypageInfo(@ModelAttribute EmpVo emp, HttpSession session, Model model
			, @RequestParam(value = "file",required = false) MultipartFile file) {
		
		String emp_num = (String)session.getAttribute("emp_num"); //판별할 사원번호

		//개인 연락처 결합
		String [] emp_telArr = emp.getEMP_TEL().split(",");
		for(int i=0; i<emp_telArr.length; i++) {
			String EMP_TEL = emp_telArr[i].join("-", emp_telArr);
//					System.out.println(EMP_TEL);
			emp.setEMP_TEL(EMP_TEL);
			
		}
		//사무실 연락처 결합
		String [] emp_dtelArr = emp.getEMP_DTEL().split(",");
		for(int i=0; i<emp_dtelArr.length; i++) {
			String EMP_DTEL = emp_dtelArr[i].join("-", emp_dtelArr);
			emp.setEMP_DTEL(EMP_DTEL);
			
		}
		
//		System.out.println(emp);
//		return "/";
		
		//------------- 이미지 수정 -------------------------------
		
		String uploadDir = "/resources/upload"; // 가상의 업로드 경로(루트(webapp) 기준)
		String saveDir = session.getServletContext().getRealPath(uploadDir); //실제 업로드 경로
		System.out.println("실제 업로드 경로:" + saveDir);
		System.out.println("이미지 : " + emp.getPHOTO());

		String PHOTO = emp.getPHOTO(); // 기존 파일명을 설정
		 
		if (file != null) { // file 객체가 null이 아닌 경우에만 처리
		    if (!file.isEmpty()) { // 파일을 선택한 경우    	 
		    	PHOTO = file.getOriginalFilename().toString(); // 파일명을 설정
		        // 파일 생성
		        File f = new File(saveDir,PHOTO); 	
				
				if(!f.exists()) {
					f.mkdirs(); // 지정된 경로 상에 존재하지 않는 모든 경로를 차례대로 생성
				}
				// MultipartFile 객체의 getOriginalFilename() 메서드를 통해 파일명 꺼내기
				try {
					// transferTo를 통해 파일 이동
					file.transferTo(f);
					
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
		    
		    } else { // 파일을 선택하지 않은 경우
		    	PHOTO = emp.getPHOTO(); // 기존 파일명을 설정
		    }
		} else { // file 객체가 null인 경우
			PHOTO = emp.getPHOTO(); // 기존 파일명을 설정
		}
				
			emp.setPHOTO(PHOTO);
		
		//-------------- 이미지 수정 끝 ----------------------
			
		//세션아이디에 저장된 emp_num에 일치하는 회원정보를 변경
		int updateCount = service.getupdateMypageInfo(emp, emp_num);
		if(updateCount > 0) {
			model.addAttribute("msg","정보 변경에 성공했습니다.");
			return "redirect:/";
		}else {
			model.addAttribute("msg","정보 변경에 실패했습니다.");
			return "fail_back";
		}
	}//updateMypageInfo 끝
	
	
	
}//EmpController 끝
