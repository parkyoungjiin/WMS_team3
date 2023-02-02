package com.itwillbs.project.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	//-------------- 품목 리스트 폼 이동 --------------
	@GetMapping(value = "ProductListForm.pr")
	public String prodList() {
		return "product/product_list";
	}// ProductInsertForm 끝
	
	//-------------- 품목 등록 폼 이동 --------------
	@GetMapping(value = "ProductInsertForm")
	public String prodInsert() {
		return "product/product_insert";
	}// ProductInsertForm 끝
	
	//------------------ 품목 등록 -------------------
	@PostMapping(value="ProdInsertPro")
	public String ProdInsertPro(
			@ModelAttribute ProductVO prod) {
		System.out.println(prod);
		
		int insertCount = service.insertProd(prod);
		
		return "product/product_list";
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
	@GetMapping(value = "ProductGroupForm")
	public String prodGroup() {
		return "product/product_group";
	}// ProductInsertForm 끝
	
				                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
	
} // ProductController 끝
