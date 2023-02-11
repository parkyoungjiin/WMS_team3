package com.itwillbs.project;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.project.service.In_scheduleService;
import com.itwillbs.project.service.Out_ScheduleService;
import com.itwillbs.project.vo.InScheduleVO;
import com.itwillbs.project.vo.OutSchedulePerProductVO;
import com.itwillbs.project.vo.OutScheduleVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired Out_ScheduleService service;
	@Autowired In_scheduleService inService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		List<OutScheduleVO> outList = service.getOutScheduleList();
		model.addAttribute("outList", outList);
		
		List<InScheduleVO> inlist = inService.getInscheduleList();
		model.addAttribute("inlist", inlist);
		
		return "index";
	}
	

}
