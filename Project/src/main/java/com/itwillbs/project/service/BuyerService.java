package com.itwillbs.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.BuyerMapper;
import com.itwillbs.project.vo.BuyerVo;

import org.springframework.stereotype.Service;

@Service
public class BuyerService {

	@Autowired
	private BuyerMapper mapper;
	
	public List<BuyerVo> getBuyerList() {
		return mapper.selectBuyerList();
	}

	public int registerBuyer(BuyerVo buyer) {
		return mapper.insertBuyer(buyer);
	}

	public BuyerVo getBuyerDetail(String business_no) {
		return mapper.selecBuyerDetail(business_no);
	}

	public int updateBuyer(BuyerVo buyer) {
		return mapper.updateBuyer(buyer);
	}

	public int codeCheck(String business_no) {
		return mapper.selectBuyerCode(business_no);
	}

}
