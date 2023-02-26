package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.EmpMapper;
import com.itwillbs.project.vo.EmpVo;

@Service
public class EmpService {
	@Autowired
	private EmpMapper mapper;
	//------------인사 등록 작업-----------------
	public int InsertEmployee(EmpVo emp) {
		return mapper.InsertEmployee(emp);
	}//InsertEmployee 끝
	
	//---------사원코드에 인덱스 00X 작업을 위해 IDX를 가져오는 작업------------
	public int getSelectIdx(EmpVo emp) {
		return mapper.getSelectIdx(emp);
	}//getSelectIdx 끝
	
	//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
	public String getSelectPass(String emp_EMAIL) {
		return mapper.getSelectPass(emp_EMAIL);
	}
	//로그인 시 재직자 판별을 위해 재직코드 가져오기
	public String getSelectWorkCd(String emp_EMAIL) {
		return mapper.getSelectWorkCd(emp_EMAIL);
	}
	//세션에 저장할 이름값,권한코드,idx값 가져오기
	public EmpVo getSelectName(String emp_EMAIL) {
		return mapper.getSelectName(emp_EMAIL);
	}
  //이메일 중복 확인
	public Integer getEmailCheck(String check_email) {
		return mapper.getEmailCheck(check_email);
	}

	// ==============================================인사 2 채원========================================================
	//---------------- 모달 사원 목록 ----------------------------
		public List<EmpVo> getEmployeeList(String keyword) {
			return mapper.selectEmployeeList(keyword);
		} // 사원 목록 끝 String keyword

		
		//-----------------현재 로그인한 사원의 권한정보 조회------------------------
		public String getPrivCode(String sId) {
			return mapper.selectPrivCode(sId);
		}
		
		//----------------- 사원 정보 ----------------------------
		public EmpVo getEmployee(String EMP_NUM) {
			return mapper.selectEmployee(EMP_NUM);
		} // 사원 상세 정보 끝
		
		//-----------------사원 수정--------------------
		public int modifyEmployee(EmpVo employee) {
			System.out.println("서비스 확인 : " +employee);
			return mapper.updateEmployee(employee);
		} // 사원 수정 끝
		
		//-----------비밀번호 일치 여부 확인을 위해 비밀번호 가져오기-----------
		public String getSelectPasswd(String emp_num) {
			return mapper.getSelectPasswd(emp_num);
		}
		//-------비밀번호 일치 시 변경----------
		public int getUpdatePasswd(String emp_num, String securePasswd) {
			return mapper.updatePasswd(emp_num, securePasswd);
		}
		//세션아이디에 저장된 emp_num에 일치하는 회원정보를 변경
		public int getupdateMypageInfo(EmpVo emp, String emp_num) {
			return mapper.updateMypageInfo(emp, emp_num);
		}
		//  게시물 수정 작업 중 개별 파일 삭제
		public int removeImgFile(String EMP_NUM, String PHOTO) {
			return mapper.deleteImgFile(EMP_NUM, PHOTO);
		}
			
		// 사원 리스트 일반  출력
		public List<EmpVo> getEmpList(int startRow, int listLimit) {
			List<EmpVo> empList = mapper.selectEmpList(startRow,listLimit);
			for(int i = 0; i < empList.size(); i++) {
				String dept_cd = empList.get(i).getDEPT_CD();
				String dept_name = mapper.selectEmpDept(dept_cd);
				empList.get(i).setDEPT_NAME(dept_name);
				String grade_cd = empList.get(i).getGRADE_CD();
				String grade_name = mapper.selectEmpGrd(grade_cd);
				empList.get(i).setGRADE_NAME(grade_name);
			}
			return empList;
		}
		
		// 리스트 페이징 처리
		public int getEmpListCount() {
			return mapper.selectBoardListCount();
		}
		
}
