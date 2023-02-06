package com.itwillbs.project.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.itwillbs.project.service.ProductService;
import com.itwillbs.project.vo.ProductVO;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService service;
	
	//-------------- 품목 리스트 이동 --------------
	@GetMapping(value = "ProductList")
	public String ProdList(
				@RequestParam(defaultValue = "") String keyword,
				HttpSession session, Model model) {
		
		//품목 리스트
		List<ProductVO> ProdList = service.getPdList(keyword);
		
		model.addAttribute("ProdList", ProdList);
		System.out.println(ProdList);
		
		return "product/product_list";
		
	}// ProductList 끝
	

	
	
	//-------------- 품목 등록 폼 이동 --------------
	@GetMapping(value = "ProductInsertForm")
	public String prodInsert() {
		return "product/product_insert";
	}// ProductInsertForm 끝
	
	//------------------ 품목 등록 -------------------
	@PostMapping(value="ProdInsertPro")
	public String ProdInsertPro(
			@ModelAttribute ProductVO prod
			, Model model) {
		System.out.println(prod);
		
		//**품목 바코드 결합** 
		// -> 바코드(barcode) = 연도yy(2) + 월MM(2) + 그룹코드 대(2) + 그룹코드 소(2)(= 총 8자리), 자동부여
		SimpleDateFormat year_format = new SimpleDateFormat("yyMM");
		Date date = new Date(System.currentTimeMillis());
		String year = year_format.format(date);
		
		System.out.println("year : " + year);
		System.out.println("date : " + date);
		
		//		SimpleDateFormat date_format = new SimpleDateFormat("yyMM");
//		System.out.println("date_format" + date_format);
		
//		String year = date_format.format(prod.getInsertCdDate());

		// -> 바코드(barcode) = 연도yy(2) + 월MM(2) + 그룹코드 대(2) + 그룹코드 소(2)(= 총 8자리), 자동부여
		String Pcode = Integer.toString(prod.getProduct_group_top_cd()) + prod.getProduct_group_bottom_cd();
		System.out.println("Pcode : " + Pcode);
		
		String barcode = year + Pcode;
				
		prod.setBarcode(barcode); // 저장
		
		System.out.println("barcode : " + barcode);

		//-----------------------------------------------------
		
		int insertCount = service.insertProd(prod);
		
		// 등록 성공 / 실패에 따른 포워딩
		if(insertCount > 0) { // 성공
			model.addAttribute("msg", "등록 성공");
			return "redirect:/ProductInsertForm";
		} else {
			model.addAttribute("msg", "등록 실패");
			return "fail_back";
		}
		
	}
	
	//------------ 품목 코드 중복체크---------------
		@ResponseBody
		@GetMapping(value = "ProdCodeCheck")
		public void ProdCodeCheck(@RequestParam(defaultValue = "1")int product_cd
								,HttpServletResponse response ) {
			
			System.out.println(product_cd);
			
			int isExist = service.existCd(product_cd);
			System.out.println(isExist);
			try {
				response.getWriter().print(isExist);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			System.out.println("isExist : "+isExist);
		}// ProdCodeCheck 끝
	
	
	
	//-------------- 품목 그룹 폼 이동 --------------
	@GetMapping(value = "/ProductGroupForm")
	public String prodGroup() {
		return "product/product_group";
	}// ProductInsertForm 끝

	//-------- 품목 그룹 리스트 -------------------------------
//	@ResponseBody
//	@GetMapping("/ProdGroupList")
//	public void prodList(
//			@RequestParam(defaultValue = "") String searchType,
//			@RequestParam(defaultValue = "") String keyword,
//			@RequestParam(defaultValue = "1") int pageNum,
//			Model model,
//			HttpServletResponse response) {
//			
//		int listLimit = 10;
//		int startRow = (pageNum - 1) * listLimit;
//		
//		List<ProductVO> prodList = service.getProdList(searchType, keyword, startRow, listLimit);
//		
//		JSONArray jsonArray = new JSONArray();
//		for(ProductVO product : prodList) {
//			JSONObject jsonObject = new JSONObject(product);
//			System.out.println(jsonObject);
//			jsonArray.put(jsonObject);
//		}
//			try {
//				response.setCharacterEncoding("UTF-8");
//				response.getWriter().print(jsonArray);
//			} catch (IOException e) {
//				e.printStackTrace();
//			}

	@ResponseBody
	@GetMapping(value = "/ProdGroupList")
	public void groupList(Model model,HttpServletResponse response
						, @RequestParam(defaultValue = "") String keyword) {
		
			//품목 그룹 리스트
			List<ProductVO> prodList = service.getProdList(keyword);
			JSONArray jsonArray = new JSONArray();
			
			for(ProductVO list: prodList) {
				
				JSONObject jsonObject = new JSONObject(list);
				System.out.println(jsonObject);
				
				jsonArray.put(jsonObject);
			}
			try {
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(jsonArray); 
			} catch (IOException e) {
				e.printStackTrace();
			}
			
	
}//---------- list 끝----------------------------
	
	
	
//----------------- 품목 info (상세)----------------------------
@GetMapping(value="ProdInfo.pr")
public String prodInfo(
				@RequestParam(defaultValue = "1")String pd_cd
				, Model model) {
	ProductVO prod = service.getProduct(pd_cd);

	return "product/product_info";
	
}

	
//----------------- 품목 info (cd 링크) ----------------------------


//----------------- 품목 info (name 링크) ----------------------------
	
	
	
//--------------------품목 수정-------------------------------

	
	
	
}// ProductController 끝
