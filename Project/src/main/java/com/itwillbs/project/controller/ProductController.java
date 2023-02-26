package com.itwillbs.project.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project.service.ProductService;
import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.EmpVo;
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
		System.out.println("ProdList : " + ProdList);
		
		return "product/product_list";
		
	}// ProductList 끝
	

	//-------------- 품목 등록 폼 이동 --------------
	@GetMapping(value = "ProductInsertForm")
	public String prodInsert(@ModelAttribute ProductVO prod, Model model) {
		
		// (수정 전)품목 그룹 모달
//		List<ProductVO> ProdGList = service.getProdList();
//		model.addAttribute("ProdGList", ProdGList);
//		System.out.println("ProdGList : " +  ProdGList);
		
		return "product/product_insert";
	}// ProductInsertForm 끝
	
	
	//------------------ 품목 등록 -------------------
	@PostMapping(value="ProdInsertPro")
	public String ProdInsertPro(
			@ModelAttribute ProductVO prod
			, Model model
			, HttpSession session
			) {
		System.out.println(prod);
		
		try {
			//**품목 바코드 결합** 
//			// -> 바코드(barcode) = 연도yy(2) + 월MM(2) + 그룹코드 대(2) + 그룹코드 소(2)(= 총 8자리), 자동부여
			//** 바코드 중복 방지를 위한 수정 ** 
			// -> 바코드(barcode) = 연도yy(2) + 월MM(2) + 초ss(2) + 그룹코드 대(2) + 그룹코드 소(2)(= 총 10자리), 자동부여
			SimpleDateFormat year_format = new SimpleDateFormat("yyMMss");
			Date date = new Date(System.currentTimeMillis());
			String year = year_format.format(date);
			
			System.out.println("year : " + year);
			System.out.println("date : " + date);
			
//				String Pcode = Integer.toString(prod.getProduct_group_top_cd())+Integer.toString(prod.getProduct_group_bottom_cd());
			String Pcode = String.valueOf(prod.getProduct_group_top_cd()) + String.valueOf(prod.getProduct_group_bottom_cd());
			System.out.println("품목코드 확인 : " + prod.getProduct_cd());
			System.out.println("Pcode : " + Pcode);
			
			String barcode = year + Pcode;
					
			prod.setBarcode(barcode); // 저장
			
			System.out.println("barcode : " + barcode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//-----------------------------------------------------
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
		
		MultipartFile mFile = prod.getFile();
		//4. MultipartFile 객체의 getOriginalFilename() 메서드를 통해 파일명 꺼내기
		String originalFileName = mFile.getOriginalFilename(); //원본 파일명
		System.out.println("원본 파일명: " +originalFileName);
		System.out.println("파일명: " +mFile.getName());
		//5. 원본 파일명을 empVo에 저장
		prod.setProduct_image(originalFileName);
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
		
		// 품목 등록
		int insertCount = service.insertProd(prod);
		
		// 등록 성공 / 실패에 따른 포워딩
		if(insertCount > 0) { // 성공
			model.addAttribute("msg", "등록 성공");
			return "redirect:/ProductList";
		} else {
			model.addAttribute("msg", "등록 실패");
			return "fail_back";
		}
		
	}
	
	//------------ 품목 코드 중복체크 ---------------
		
//		@GetMapping(value = "ProdCodeCheck")
//		public void ProdCodeCheck(@RequestParam(defaultValue = "1") int product_cd
//								,HttpServletResponse response) {
//			
//			System.out.println(product_cd);
//			
//			int isExist = service.existCd(product_cd);
//			System.out.println(isExist);
//			try {
//				response.getWriter().print(isExist);
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//			
//			System.out.println("isExist : "+isExist);
//		}// ProdCodeCheck 끝
	
	
	
	
	
//----------------- 품목 info (상세)----------------------------
@GetMapping(value="/ProdModify")
public String prodInfo(
				@ModelAttribute ProductVO product
				, @RequestParam(defaultValue = "") String keyword
				, Model model
				, HttpSession session) {
	
	int product_cd = product.getProduct_cd();
	
	product = service.getProdInfo(product_cd);
	model.addAttribute("product", product);
//	System.out.println(product);
	
	// (수정 전)품목 그룹 모달
//	List<ProductVO> ProdGList = service.getProdList();
//	model.addAttribute("ProdGList", ProdGList);
	
	
	return "product/product_info";
	
}

//-------------------- 품목 상세 - 품목 그룹 조회 --------------------
@GetMapping(value="/pGroupListJson", produces = "application/json; charset=utf-8")
@ResponseBody
public void listJson_product(
		@RequestParam(defaultValue = "") String keyword,
		Model model,
		HttpServletResponse response) {
	
	List<ProductVO> ProdList = service.getProdList(keyword);
		
	JSONArray jsonArray = new JSONArray();
	
	for(ProductVO prod : ProdList) {
		JSONObject jsonObject = new JSONObject(prod);
//		System.out.println(jsonObject);
		
		jsonArray.put(jsonObject);
	}
		
	try {
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonArray);
	} catch (IOException e) {
		e.printStackTrace();
	}
	
}


//-------------------- 품목 수정 Pro -------------------------------
@PostMapping(value="/UpdateProd")
public String productUpdate(
		@ModelAttribute ProductVO product
		, Model model
		, HttpSession session
		,@RequestParam(value = "file",required = false) MultipartFile file) {
	
	//------------- 이미지 수정 -------------------------------
	
	String uploadDir = "/resources/upload"; // 가상의 업로드 경로(루트(webapp) 기준)
	String saveDir = session.getServletContext().getRealPath(uploadDir); //실제 업로드 경로
	System.out.println("실제 업로드 경로:" + saveDir);
	System.out.println("이미지 : " + product.getProduct_image());
	System.out.println("거래처 : " + product.getBusiness_no());

	String product_image = product.getProduct_image(); // 기존 파일명을 설정
	 
	if (file != null) { // file 객체가 null이 아닌 경우에만 처리
	    if (!file.isEmpty()) { // 파일을 선택한 경우    	 
	    	product_image = file.getOriginalFilename().toString(); // 파일명을 설정
	        // 파일 생성
	        File f = new File(saveDir,product_image); 	
			
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
	        product_image = product.getProduct_image(); // 기존 파일명을 설정
	    }
	} else { // file 객체가 null인 경우
	    product_image = product.getProduct_image(); // 기존 파일명을 설정
	}
			
		product.setProduct_image(product_image);
	
		// --------------- 수정 --------------------------------
		int updateCount = service.updateProd(product);
		
		if(updateCount > 0) { // 수정 성공 시		
			model.addAttribute("msg", "품목 수정 성공!");
			return "redirect:/ProductList";
		} else { // 수정 실패 시
			model.addAttribute("msg", "품목 수정 실패!");
			return "fail_back";
		}
	}


//======== 품목 수정 시 개별 파일 삭제 처리 ===============================
		@ResponseBody
		@PostMapping("/DeleteImgFile2")
		public void deleteImgFile(
				@RequestParam int product_cd,
				@RequestParam String product_image,
				HttpSession session, HttpServletResponse response
				, Model model) {
			
			response.setCharacterEncoding("UTF-8");
			
			try {
					// Service 객체의 removeBoardFile() 메서드 호출하여 개별 파일 삭제 요청
					int deleteCount = service.removeImgFile(product_cd, product_image);
					ProductVO vo =service.getProdInfo(product_cd);
					// DB 파일 삭제 성공 시 실제 파일 삭제
					if(deleteCount > 0) { // 삭제 성공
						String uploadDir = "/resources/upload"; // 가상의 업로드 경로(루트(webapp) 기준)
						String saveDir = session.getServletContext().getRealPath(uploadDir);
						
						Path path = Paths.get(saveDir + "/" + product_image);
						Files.deleteIfExists(path);
//						session.removeAttribute("PHOTO");
						response.getWriter().print("true");
					} else { // 삭제 실패
						response.getWriter().print("false");
					}
					
			} catch (IOException e) {
				e.printStackTrace();
				model.addAttribute("msg", "일시적인 오류로 파일 삭제에 실패했습니다!");
			}
			
		} //========================== 이미지 (수정) 삭제 끝============================
		

	
}// ProductController 끝
