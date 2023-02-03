package com.itwillbs.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.StockMapper;

@Service
public class StockService {
	@Autowired
	private StockMapper mapper;
}
