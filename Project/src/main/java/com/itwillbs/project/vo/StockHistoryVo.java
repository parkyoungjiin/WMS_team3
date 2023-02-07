package com.itwillbs.project.vo;

import java.sql.Date;

// 재고 관리 ( 목록 ) 페이지에 담는 Vo
public class StockHistoryVo {
	private String stock_cd; //재고 번호
	private String control_type_cd; //작업 유형
	private int product_cd; //품목 번호
	private String source_stock_cd; //보내는 재고번호
	private String target_stock_cd; //받는 재고번호
	private int qty; //수량
	private String emp_num; //사원번호
	private Date stock_date; //작업날짜
	private String remarks; //적요
	
	
	public String getStock_cd() {
		return stock_cd;
	}
	public void setStock_cd(String stock_cd) {
		this.stock_cd = stock_cd;
	}
	public String getControl_type_cd() {
		return control_type_cd;
	}
	public void setControl_type_cd(String control_type_cd) {
		this.control_type_cd = control_type_cd;
	}
	public int getProduct_cd() {
		return product_cd;
	}
	public void setProduct_cd(int product_cd) {
		this.product_cd = product_cd;
	}
	public String getSource_stock_cd() {
		return source_stock_cd;
	}
	public void setSource_stock_cd(String source_stock_cd) {
		this.source_stock_cd = source_stock_cd;
	}
	public String getTarget_stock_cd() {
		return target_stock_cd;
	}
	public void setTarget_stock_cd(String target_stock_cd) {
		this.target_stock_cd = target_stock_cd;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getEmp_num() {
		return emp_num;
	}
	public void setEmp_num(String emp_num) {
		this.emp_num = emp_num;
	}
	public Date getStock_date() {
		return stock_date;
	}
	public void setStock_date(Date stock_date) {
		this.stock_date = stock_date;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	@Override
	public String toString() {
		return "StockHistoryVo [stock_cd=" + stock_cd + ", control_type_cd=" + control_type_cd + ", product_cd="
				+ product_cd + ", source_stock_cd=" + source_stock_cd + ", target_stock_cd=" + target_stock_cd
				+ ", qty=" + qty + ", emp_num=" + emp_num + ", stock_date=" + stock_date + ", remarks=" + remarks + "]";
	}
	
	
	
	


	
	
	
}
