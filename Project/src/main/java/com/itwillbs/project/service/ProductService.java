package com.itwillbs.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.ProductMapper;
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
	

}
