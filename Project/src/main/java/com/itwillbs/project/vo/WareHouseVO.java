package com.itwillbs.project.vo;

import java.util.Arrays;

public class WareHouseVO {
private String wh_cd;//창고 코드
private String wh_name;//창고명
private String wh_gubun;//구분
private String wh_location;//위치
private String wh_addr;//주소
private String wh_addr1;//주소 상세 주소1
private String wh_addr_detail;//상세 주소2
private String wh_tel;//전화번호
private String wh_tel1;//전화번호
private String wh_tel2;//전화번호
private String wh_tel3;//전화번호
private String wh_man_name;//관리자명
private String wh_use;//사용여부
private String remarks;//적요
private String post_no;// 우편번호
private String wh_area;//창고 구역
private int wh_area_cd;//창고 구역 번호
private int wh_ref;//창고 참고 번호 
private int wh_seq;// 창고 참고 순서
private int wh_loc_in_area_cd; // 선반 번호
private String wh_loc_in_area; // 선반 공간
private String stock_cd;//재고 번호
private String product_name;//품목명
private String stock_qty; //재고 수량
//-----------getter/setter---------------


public String getWh_cd() {
	return wh_cd;
}
public String getStock_cd() {
	return stock_cd;
}
public void setStock_cd(String stock_cd) {
	this.stock_cd = stock_cd;
}
public String getProduct_name() {
	return product_name;
}
public void setProduct_name(String product_name) {
	this.product_name = product_name;
}
public String getStock_qty() {
	return stock_qty;
}
public void setStock_qty(String stock_qty) {
	this.stock_qty = stock_qty;
}
public String getWh_area() {
	return wh_area;
}
public void setWh_area(String wh_area) {
	this.wh_area = wh_area;
}
public int getWh_area_cd() {
	return wh_area_cd;
}
public void setWh_area_cd(int wh_area_cd) {
	this.wh_area_cd = wh_area_cd;
}
public int getWh_ref() {
	return wh_ref;
}
public void setWh_ref(int wh_ref) {
	this.wh_ref = wh_ref;
}
public int getWh_seq() {
	return wh_seq;
}
public void setWh_seq(int wh_seq) {
	this.wh_seq = wh_seq;
}
public int getWh_loc_in_area_cd() {
	return wh_loc_in_area_cd;
}
public void setWh_loc_in_area_cd(int wh_loc_in_area_cd) {
	this.wh_loc_in_area_cd = wh_loc_in_area_cd;
}
public String getWh_loc_in_area() {
	return wh_loc_in_area;
}
public void setWh_loc_in_area(String wh_loc_in_area) {
	this.wh_loc_in_area = wh_loc_in_area;
}
public String getPost_no() {
	return post_no;
}
public void setPost_no(String post_no) {
	this.post_no = post_no;
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


public String getWh_gubun() {
	return wh_gubun;
}


public void setWh_gubun(String wh_gubun) {
	this.wh_gubun = wh_gubun;
}


public String getWh_location() {
	return wh_location;
}


public void setWh_location(String wh_location) {
	this.wh_location = wh_location;
}


public String getWh_addr() {
	return wh_addr;
}


public void setWh_addr(String wh_addr) {
	this.wh_addr = wh_addr;
}


public String getWh_addr1() {
	return wh_addr1;
}


public void setWh_addr1(String wh_addr1) {
	this.wh_addr1 = wh_addr1;
}


public String getWh_addr_detail() {
	return wh_addr_detail;
}

public void setWh_addr_detail(String wh_addr_detail) {
	this.wh_addr_detail = wh_addr_detail;
	wh_addr = wh_addr1+","+wh_addr_detail;
}


public String getWh_tel() {
	return wh_tel;
}


public void setWh_tel(String wh_tel) {
	this.wh_tel = wh_tel;
}



public String getWh_tel1() {
	return wh_tel1;
}


public void setWh_tel1(String wh_tel1) {
	this.wh_tel1 = wh_tel1;
}


public String getWh_tel2() {
	return wh_tel2;
}


public void setWh_tel2(String wh_tel2) {
	this.wh_tel2 = wh_tel2;
}


public String getWh_tel3() {
	return wh_tel3;
}


public void setWh_tel3(String wh_tel3) {
	this.wh_tel3 = wh_tel3;
	wh_tel = wh_tel1 + "-" +wh_tel2 +"-"+wh_tel3;
}


public String getWh_man_name() {
	return wh_man_name;
}


public void setWh_man_name(String wh_man_name) {
	this.wh_man_name = wh_man_name;
}


public String getWh_use() {
	return wh_use;
}


public void setWh_use(String wh_use) {
	this.wh_use = wh_use;
}


public String getRemarks() {
	return remarks;
}


public void setRemarks(String remarks) {
	this.remarks = remarks;
}
@Override
public String toString() {
	return "WareHouseVO [wh_cd=" + wh_cd + ", wh_name=" + wh_name + ", wh_gubun=" + wh_gubun + ", wh_location="
			+ wh_location + ", wh_addr=" + wh_addr + ", wh_addr1=" + wh_addr1 + ", wh_addr_detail=" + wh_addr_detail
			+ ", wh_tel=" + wh_tel + ", wh_tel1=" + wh_tel1 + ", wh_tel2=" + wh_tel2 + ", wh_tel3=" + wh_tel3
			+ ", wh_man_name=" + wh_man_name + ", wh_use=" + wh_use + ", remarks=" + remarks + ", post_no=" + post_no
			+ ", wh_area=" + wh_area + ", wh_area_cd=" + wh_area_cd + ", wh_ref=" + wh_ref
			+ ", wh_seq=" + wh_seq + ", wh_loc_in_area_cd=" + wh_loc_in_area_cd + ", wh_loc_in_area=" + wh_loc_in_area
			+ "]";
}




}
