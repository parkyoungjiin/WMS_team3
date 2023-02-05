package com.itwillbs.project.vo;

import java.sql.Date;

public class OutScheduleVO {
	private String out_schedule_cd;
	private String business_no;
	private String emp_num;
	private Date out_date;
	private String remarks;
	private String out_complete;
	
	public String getOut_schedule_cd() {
		return out_schedule_cd;
	}
	public void setOut_schedule_cd(String out_schedule_cd) {
		this.out_schedule_cd = out_schedule_cd;
	}
	public String getBusiness_no() {
		return business_no;
	}
	public void setBusiness_no(String business_no) {
		this.business_no = business_no;
	}
	public String getEmp_num() {
		return emp_num;
	}
	public void setEmp_num(String emp_num) {
		this.emp_num = emp_num;
	}
	public Date getOut_date() {
		return out_date;
	}
	public void setOut_date(Date out_date) {
		this.out_date = out_date;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getOut_complete() {
		return out_complete;
	}
	public void setOut_complete(String out_complete) {
		this.out_complete = out_complete;
	}
	
	@Override
	public String toString() {
		return "OutScheduleVO [out_schedule_cd=" + out_schedule_cd + ", business_no=" + business_no + ", emp_num="
				+ emp_num + ", out_date=" + out_date + ", remarks=" + remarks + ", out_complete=" + out_complete + "]";
	}

	
}
