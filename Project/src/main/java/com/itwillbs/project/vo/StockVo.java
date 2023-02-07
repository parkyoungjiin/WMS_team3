package com.itwillbs.project.vo;

// 재고 관리 ( 목록 ) 페이지에 담는 Vo
public class StockVo {
	private String stock_cd; //재고 번호
	private String product_cd; //품목 번호
	private String product_name; //품목 이름
	private String wh_cd; //창고 코드
	private String wh_name; //창고 이름
	private String wh_area_cd; //창고 구역 코드
	private String wh_area; //창고 구역 이름
	private String wh_loc_in_area_cd; //창고 내 구역 번호
	private String wh_loc_in_area; //창고 내 구역
	private String stock_qty; //재고 수량
	
	public String getStock_cd() {
		return stock_cd;
	}
	public void setStock_cd(String stock_cd) {
		this.stock_cd = stock_cd;
	}
	public String getProduct_cd() {
		return product_cd;
	}
	public void setProduct_cd(String product_cd) {
		this.product_cd = product_cd;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getWh_cd() {
		return wh_cd;
	}
	public void setWh_cd(String wh_cd) {
		this.wh_cd = wh_cd;
	}
	public String getWh_name() {
		return wh_name;
	}
	public void setWh_name(String wh_name) {
		this.wh_name = wh_name;
	}
	public String getWh_area_cd() {
		return wh_area_cd;
	}
	public void setWh_area_cd(String wh_area_cd) {
		this.wh_area_cd = wh_area_cd;
	}
	public String getWh_area() {
		return wh_area;
	}
	public void setWh_area(String wh_area) {
		this.wh_area = wh_area;
	}
	public String getWh_loc_in_area_cd() {
		return wh_loc_in_area_cd;
	}
	public void setWh_loc_in_area_cd(String wh_loc_in_area_cd) {
		this.wh_loc_in_area_cd = wh_loc_in_area_cd;
	}
	public String getWh_loc_in_area() {
		return wh_loc_in_area;
	}
	public void setWh_loc_in_area(String wh_loc_in_area) {
		this.wh_loc_in_area = wh_loc_in_area;
	}
	public String getStock_qty() {
		return stock_qty;
	}
	public void setStock_qty(String stock_qty) {
		this.stock_qty = stock_qty;
	}
	@Override
	public String toString() {
		return "StockVo [stock_cd=" + stock_cd + ", product_cd=" + product_cd + ", product_name=" + product_name
				+ ", wh_cd=" + wh_cd + ", wh_name=" + wh_name + ", wh_area_cd=" + wh_area_cd + ", wh_area=" + wh_area
				+ ", wh_loc_in_area_cd=" + wh_loc_in_area_cd + ", wh_loc_in_area=" + wh_loc_in_area + ", stock_qty="
				+ stock_qty + "]";
	}
	
	
	


	
	
	
}
