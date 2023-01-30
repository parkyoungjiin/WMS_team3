package com.itwillbs.project.mapper;

import java.util.List;


import com.itwillbs.project.vo.BuyerVo;

public interface BuyerMapper {

	// 거래처 목록 조회
	List<BuyerVo> selectBuyerList();

	// 거래처 등록
	int insertBuyer(BuyerVo buyer);

	// 거래처 상세조회
	BuyerVo selecBuyerDetail(String business_no);

	// 거래처 수정
	int updateBuyer(BuyerVo buyer);

	// 거래처 코드 중복 확인
	int selectBuyerCode(String business_no);


}
