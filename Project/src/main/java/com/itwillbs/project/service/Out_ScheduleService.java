package com.itwillbs.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.mapper.Out_ScheduleMapper;

@Service
public class Out_ScheduleService {

	@Autowired
	private Out_ScheduleMapper mapper;
}
