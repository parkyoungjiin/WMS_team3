package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.BuyerMapper;
import com.itwillbs.project.mapper.ProductMapper;
import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.ProductVO;

@Service
public class ProductService {

	@Autowired
	private ProductMapper mapper;

	//------------------ 품목등록 --------------------
	public int insertProd(ProductVO product) {
		return mapper.insertProd(product);
	}// insertProd() 끝

	//-------------------- 품목 중복 체크------------- 
	public int existCd(int product_cd) {
		return mapper.existCd(product_cd);
	} // existCd() 끝

	//-------------------- 품목 그룹 리스트 ------------------
	public List<ProductVO> getProdList() {
		return mapper.selectGroupList();
	}
	
	//------------------- 품목 리스트 ------------------------
	public List<ProductVO> getPdList(String keyword) {
		return mapper.selectPdList(keyword);
	}
	
	public ProductVO getProdInfo(int product_cd) {
		return mapper.selectProdInfo(product_cd);
	}

	//--------------------품목 수정---------------------------
	public int updateProd(ProductVO product) {
		return mapper.modifyProd(product);
	}
	



}
