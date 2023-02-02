package com.itwillbs.project.mapper;

import com.itwillbs.project.vo.ProductVO;

public interface ProductMapper {

	//---------------- 품목 등록 --------------------
	int insertProd(ProductVO product);
	
	//------------품목코드 중복 확인-----------------
	int existCd(int product_cd);

	

}
