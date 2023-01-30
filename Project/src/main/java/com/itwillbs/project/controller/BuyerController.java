package com.itwillbs.project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

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
			HttpSession session,
			String addr1, String addr2) {
		
//		System.out.println(buyer);
		buyer.setAddr(addr1 + " " + addr2);
		
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
		
		model.addAttribute("buyer", buyer);
		
		return "buyer/buyer_detail";
	}//BuyerDetail 끝
	
	
	//------------거래처 수정------------
	@PostMapping(value = "BuyerModifyPro")
	public String BuyerModifyPro(
			@ModelAttribute BuyerVo buyer, 
			Model model,
			HttpSession session,
			String addr1, String addr2) {
		
//		System.out.println(buyer);
		buyer.setAddr(addr1 + " " + addr2);
		
		int updateCount = service.updateBuyer(buyer);
		
		if(updateCount > 0) {
			return "redirect:/BuyerList";
		}  else { // 실패
			model.addAttribute("msg", "거래처 수정 실패!");
			return "fail_back";
		}
		
	}//BuyerModifyPro 끝
	
	
}//BuyerController 끝
