package com.itwillbs.project.vo;

import java.sql.Date;

public class OutScheduleVO {
	private Date out_schedule_date;
	private String out_schedule_cd;
	private String business_no;
	private String cust_name;
	private String emp_num;
	private String emp_name;
	private Date out_date;
	private String remarks;
	private String out_complete;
	private String out_category;
	private String product_name;

	
	public Date getOut_schedule_date() {
		return out_schedule_date;
	}
	public void setOut_schedule_date(Date out_schedule_date) {
		this.out_schedule_date = out_schedule_date;
	}
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
	public String getCust_name() {
		return cust_name;
	}
	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}
	public String getEmp_num() {
		return emp_num;
	}
	public void setEmp_num(String emp_num) {
		this.emp_num = emp_num;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
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
	public String getOut_category() {
		return out_category;
	}
	public void setOut_category(String out_category) {
		this.out_category = out_category;
	}
	public String getOut_complete() {
		return out_complete;
	}
	public void setOut_complete(String out_complete) {
		this.out_complete = out_complete;
	}
	
//
//	public String getOut_category() {
//		return out_category;
//	}
//	public void setOut_category(String out_category) {
//		this.out_category = out_category;
//	}
//	
//	public String getCust_name() {
//		return cust_name;
//	}
//	public void setCust_name(String cust_name) {
//		this.cust_name = cust_name;
//	}
//	public String getEmp_name() {
//		return emp_name;
//	}
//	public void setEmp_name(String emp_name) {
//		this.emp_name = emp_name;
//	}
	
	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	@Override
	public String toString() {
		return "OutScheduleVO [out_schedule_date=" + out_schedule_date + ", out_schedule_cd=" + out_schedule_cd
				+ ", business_no=" + business_no + ", cust_name=" + cust_name + ", emp_num=" + emp_num + ", emp_name="
				+ emp_name + ", out_date=" + out_date + ", remarks=" + remarks + ", out_complete=" + out_complete
				+ ", out_category=" + out_category + "]";
	}
	

	
}
