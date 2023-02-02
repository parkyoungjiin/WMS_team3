package com.itwillbs.project.controller;

import java.io.IOException;
import java.util.Arrays;
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

import com.itwillbs.project.service.BuyerService;
import com.itwillbs.project.vo.BuyerVo;

@Controller
public class BuyerController {
	
	@Autowired
	private BuyerService service;
	
	
	//------------거래처 조회 페이지 이동------------
	@GetMapping(value = "BuyerList")
	public String BuyerList(HttpSession session, Model model) {
		
		List<BuyerVo> buyerList = service.getBuyerList();
		
		model.addAttribute("buyerList", buyerList);
		
		return "buyer/buyer_list";
	}//BuyerList 끝
	
	@GetMapping(value = "test")
	public String test(HttpSession session, Model model) {
		
		
		return "buyer/test";
	}//BuyerList 끝
	
	//------------거래처 등록 페이지------------
	@GetMapping(value = "BuyerRegisterForm")
	public String BuyerRegisterForm() {
		
		return "buyer/buyer_register";
	}//BuyerResiter 끝
	
	
	//------------거래처 등록 로직------------
	@PostMapping(value = "BuyerRegisterPro")
	public String BuyerRegisterPro(
			@ModelAttribute BuyerVo buyer, 
			Model model,
			HttpSession session
			) {
		
		// if문 => 아무것도 입력안할 시 "" 저장
		//대표 연락처 결합
		if(!buyer.getTel().equals(",,")) {
			String [] buyer_telArr = buyer.getTel().split(",");
			for(int i=0; i<buyer_telArr.length; i++) {
				String buyer_TEL = buyer_telArr[i].join("-", buyer_telArr);
				buyer.setTel(buyer_TEL);
			}
		} else {
			buyer.setTel("");
		}
		
//			String [] buyer_telArr = buyer.getTel().split(",");
//			if(buyer.getTel() != null && !buyer.getTel().equals("")) {
//			for(int i=0; i<buyer_telArr.length; i++) {
//				String buyer_TEL = buyer_telArr[i].join("-", buyer_telArr);
//				buyer.setTel(buyer_TEL);
//			}
//		} else if(buyer.getTel().equals("")) {
//			buyer.setTel("");
//		}
		
		//담당자 연락처 결합
		if(!buyer.getMan_tel().equals(",,")) {
		String [] buyer_mtelArr = buyer.getMan_tel().split(",");
		for(int i=0; i<buyer_mtelArr.length; i++) {
			String buyer_MTEL = buyer_mtelArr[i].join("-", buyer_mtelArr);
			buyer.setMan_tel(buyer_MTEL);
			}
		} else {
			buyer.setMan_tel("");
		}
		
		//대표 이메일1,이메일2 결합
		if(!buyer.getEmail().equals(",")) {
		String [] buyer_emailArr = buyer.getEmail().split(",");
		for(int i=0; i<buyer_emailArr.length; i++) {
			String buyer_EMAIL = buyer_emailArr[i].join("@", buyer_emailArr);
//			System.out.println(buyer_EMAIL);
			buyer.setEmail(buyer_EMAIL);
		}
		}else {
			buyer.setEmail("");
		}
		
		//담당자 이메일1,이메일2 결합
		if(!buyer.getMan_email().equals(",")) {
		String [] buyer_MemailArr = buyer.getMan_email().split(",");
		for(int i=0; i<buyer_MemailArr.length; i++) {
			String buyer_MEMAIL = buyer_MemailArr[i].join("@", buyer_MemailArr);
//			System.out.println(buyer_MEMAIL);
			buyer.setMan_email(buyer_MEMAIL);
		}
		} else {
			buyer.setMan_email("");
		}
		
		//주소, 상세주소 결합
		if(!buyer.getAddr().equals(",")) {
		String [] buyer_addrArr = buyer.getAddr().split(",");
		for(int i=0; i<buyer_addrArr.length; i++) {
			String buyer_ADDR = buyer_addrArr[i].join(" ", buyer_addrArr);
			buyer.setAddr(buyer_ADDR);
		}
		} else {
			buyer.setAddr("");
		}
		
		// 업태, 종목 결합
//		System.out.println(buyer.getUptae());
//		if(buyer.getUptae() != null && !buyer.getUptae().equals("")) {
		String [] buyer_uptaeArr = buyer.getUptae().split(",");
//		System.out.println("buyer_uptaeArr : " + Arrays.toString(buyer_uptaeArr));
//		System.out.println("buyer_uptaeArr : " + buyer_uptaeArr[0]);
//		if(!buyer_uptaeArr[0].equals("")) {
		if(!buyer.getUptae().equals(",,")) {
			for(int i=0; i<buyer_uptaeArr.length; i++) {
				String buyer_uptae = buyer_uptaeArr[i].join("/", buyer_uptaeArr);
				System.out.println(buyer_uptae);
				buyer.setUptae(buyer_uptae);
			}
		} else {
			buyer.setUptae("");
		}
		
		String [] buyer_jongmokArr = buyer.getJongmok().split(",");
//		if(buyer_jongmokArr[0] != null && !buyer_jongmokArr[0].equals("")) {
		if(!buyer.getJongmok().equals(",,")) {
		for(int i=0; i<buyer_jongmokArr.length; i++) {
			String buyer_jongmok = buyer_jongmokArr[i].join("/", buyer_jongmokArr);
			buyer.setJongmok(buyer_jongmok);
		}
		}else {
			buyer.setJongmok("");
		}
		
		System.out.println(buyer);
		
		int insertCount = service.registerBuyer(buyer);
		
		if(insertCount > 0) {
			return "redirect:/BuyerList";
		}  else { // 실패
			model.addAttribute("msg", "거래처 등록 실패!");
			return "fail_back";
		}
		
	}//BuyerRegisterPro 끝
	
	
	//------------거래처 상세 조회------------
	@GetMapping(value = "BuyerDetail")
	public String BuyerDetail(
			@ModelAttribute BuyerVo buyer, 
			Model model,
			HttpSession session) {
		
		String business_no = buyer.getBusiness_no();
		
		buyer = service.getBuyerDetail(business_no);
		
		String [] telArr = buyer.getTel().split("-");
//		System.out.println("배열 확인" + Arrays.toString(telArr));
		buyer.setTelArr(telArr);
		
		String [] emailArr = buyer.getEmail().split("@");
		buyer.setEmailArr(emailArr);
		
		String [] addrArr = buyer.getAddr().split("\\\\s");
//		System.out.println("주소 배열 확인" + Arrays.toString(addrArr));
		buyer.setAddrArr(addrArr);
		
		String [] ManEmailArr = buyer.getMan_email().split("@");
		buyer.setMan_emailArr(ManEmailArr);
		
		String [] ManTelArr = buyer.getMan_tel().split("-");
		buyer.setMan_telArr(ManTelArr);
		
		
		model.addAttribute("buyer", buyer);
		
		return "buyer/buyer_detail";
	}//BuyerDetail 끝
	
	
	//------------거래처 수정------------
	@PostMapping(value = "BuyerModifyPro")
	public String BuyerModifyPro(
			@ModelAttribute BuyerVo buyer, 
			Model model,
			HttpSession session
			) {
		
		// if문 => 아무것도 입력안할 시 "" 저장
				//대표 연락처 결합
		if(!buyer.getTel().equals(",,")) {
			String [] buyer_telArr = buyer.getTel().split(",");
			for(int i=0; i<buyer_telArr.length; i++) {
				String buyer_TEL = buyer_telArr[i].join("-", buyer_telArr);
				buyer.setTel(buyer_TEL);
			}
		} else {
			buyer.setTel("");
		}
		
//					String [] buyer_telArr = buyer.getTel().split(",");
//					if(buyer.getTel() != null && !buyer.getTel().equals("")) {
//					for(int i=0; i<buyer_telArr.length; i++) {
//						String buyer_TEL = buyer_telArr[i].join("-", buyer_telArr);
//						buyer.setTel(buyer_TEL);
//					}
//				} else if(buyer.getTel().equals("")) {
//					buyer.setTel("");
//				}
		
		//담당자 연락처 결합
		if(!buyer.getMan_tel().equals(",,")) {
		String [] buyer_mtelArr = buyer.getMan_tel().split(",");
		for(int i=0; i<buyer_mtelArr.length; i++) {
			String buyer_MTEL = buyer_mtelArr[i].join("-", buyer_mtelArr);
			buyer.setMan_tel(buyer_MTEL);
			}
		} else {
			buyer.setMan_tel("");
		}
		
		//대표 이메일1,이메일2 결합
		if(!buyer.getEmail().equals(",")) {
		String [] buyer_emailArr = buyer.getEmail().split(",");
		for(int i=0; i<buyer_emailArr.length; i++) {
			String buyer_EMAIL = buyer_emailArr[i].join("@", buyer_emailArr);
//					System.out.println(buyer_EMAIL);
			buyer.setEmail(buyer_EMAIL);
		}
		}else {
			buyer.setEmail("");
		}
		
		//담당자 이메일1,이메일2 결합
		if(!buyer.getMan_email().equals(",")) {
		String [] buyer_MemailArr = buyer.getMan_email().split(",");
		for(int i=0; i<buyer_MemailArr.length; i++) {
			String buyer_MEMAIL = buyer_MemailArr[i].join("@", buyer_MemailArr);
//					System.out.println(buyer_MEMAIL);
			buyer.setMan_email(buyer_MEMAIL);
		}
		} else {
			buyer.setMan_email("");
		}
		
		//주소, 상세주소 결합
		if(!buyer.getAddr().equals(",")) {
		String [] buyer_addrArr = buyer.getAddr().split(",");
		for(int i=0; i<buyer_addrArr.length; i++) {
			String buyer_ADDR = buyer_addrArr[i].join(" ", buyer_addrArr);
			buyer.setAddr(buyer_ADDR);
		}
		} else {
			buyer.setAddr("");
		}
		
		// 업태, 종목 결합
//				System.out.println(buyer.getUptae());
//				if(buyer.getUptae() != null && !buyer.getUptae().equals("")) {
		if(!buyer.getUptae().equals(",,")) {
			String [] buyer_uptaeArr = buyer.getUptae().split(",");
//				System.out.println("buyer_uptaeArr : " + Arrays.toString(buyer_uptaeArr));
//				System.out.println("buyer_uptaeArr : " + buyer_uptaeArr[0]);
//				if(!buyer_uptaeArr[0].equals("")) {
			for(int i=0; i<buyer_uptaeArr.length; i++) {
				String buyer_uptae = buyer_uptaeArr[i].join("/", buyer_uptaeArr);
				System.out.println(buyer_uptae);
				buyer.setUptae(buyer_uptae);
			}
		} else {
			buyer.setUptae("");
		}
		
		if(!buyer.getUptae().equals(",,")) {
		String [] buyer_jongmokArr = buyer.getJongmok().split(",");
//		if(buyer_jongmokArr[0] != null && !buyer_jongmokArr[0].equals("")) {
		for(int i=0; i<buyer_jongmokArr.length; i++) {
			String buyer_jongmok = buyer_jongmokArr[i].join("/", buyer_jongmokArr);
			buyer.setJongmok(buyer_jongmok);
		}
		}else {
			buyer.setJongmok("");
		}
		
		int updateCount = service.updateBuyer(buyer);
		
		if(updateCount > 0) {
			return "redirect:/BuyerList";
		}  else { // 실패
			model.addAttribute("msg", "거래처 수정 실패!");
			return "fail_back";
		}
		
	}//BuyerModifyPro 끝
	
	
	//------------거래처 코드 중복 체크------------
	@PostMapping(value = "CodeCheck")
	@ResponseBody
	public void CodeCheck(@RequestParam("business_no") String business_no, HttpServletResponse response) {
		
		int result = service.codeCheck(business_no);
		
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}//CodeCheck 끝
	
}//BuyerController 끝
