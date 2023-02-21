package com.itwillbs.project.vo;

import java.util.Arrays;

// 재고 관리 ( 목록 ) 페이지에 담는 Vo
public class StockVo {
	private int stock_cd; //재고 번호
	private int[] stock_cdArr; 
	private int product_cd; //품목 번호
	private int[] product_cdArr; //품목 번호
	private String product_name; //품목 이름
	private String[] product_nameArr;
	private int wh_cd; //창고 코드
	private int[] wh_cdArr;
	private String wh_name; //창고 이름
	private String[] wh_nameArr; //창고 이름
	private int wh_area_cd; //창고 구역 코드
	private int[] wh_area_cdArr; //창고 구역 코드
	private String wh_area; //창고 구역 이름
	private String[] wh_areaArr; //창고 구역 이름
	private int wh_loc_in_area_cd; //창고 내 구역 번호
	private int[] wh_loc_in_area_cdArr; //창고 내 구역 번호
	private String wh_loc_in_area; //창고 내 구역
	private String[] wh_loc_in_areaArr; //창고 내 구역
	private int stock_qty; //재고 수량
	private int[] stock_qtyArr; //재고 수량
	private int update_qty; //조정 수량
	private int[] update_qtyArr; //조정 수량
	private int move_stock_cd; //이동 재고 번호
	private int[] move_stock_cdArr; //이동 재고 번호
	private int move_wh_loc_in_area_cd; //이동할 창고 내 구역
	private int[] move_wh_loc_in_area_cdArr; //이동할 창고 내 구역
	private int move_qty; //이동 수량
	private int[] move_qtyArr; //이동 수량
	private int stock_control; //작업 구분 
	private int[] stock_controlArr; //작업 구분
	
	public int getStock_cd() {
		return stock_cd;
	}
	public void setStock_cd(int stock_cd) {
		this.stock_cd = stock_cd;
	}
	public int[] getStock_cdArr() {
		return stock_cdArr;
	}
	public void setStock_cdArr(int[] stock_cdArr) {
		this.stock_cdArr = stock_cdArr;
	}
	public int getProduct_cd() {
		return product_cd;
	}
	public void setProduct_cd(int product_cd) {
		this.product_cd = product_cd;
	}
	public int[] getProduct_cdArr() {
		return product_cdArr;
	}
	public void setProduct_cdArr(int[] product_cdArr) {
		this.product_cdArr = product_cdArr;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String[] getProduct_nameArr() {
		return product_nameArr;
	}
	public void setProduct_nameArr(String[] product_nameArr) {
		this.product_nameArr = product_nameArr;
	}
	public int getWh_cd() {
		return wh_cd;
	}
	public void setWh_cd(int wh_cd) {
		this.wh_cd = wh_cd;
	}
	public int[] getWh_cdArr() {
		return wh_cdArr;
	}
	public void setWh_cdArr(int[] wh_cdArr) {
		this.wh_cdArr = wh_cdArr;
	}
	public String getWh_name() {
		return wh_name;
	}
	public void setWh_name(String wh_name) {
		this.wh_name = wh_name;
	}
	public String[] getWh_nameArr() {
		return wh_nameArr;
	}
	public void setWh_nameArr(String[] wh_nameArr) {
		this.wh_nameArr = wh_nameArr;
	}
	public int getWh_area_cd() {
		return wh_area_cd;
	}
	public void setWh_area_cd(int wh_area_cd) {
		this.wh_area_cd = wh_area_cd;
	}
	public int[] getWh_area_cdArr() {
		return wh_area_cdArr;
	}
	public void setWh_area_cdArr(int[] wh_area_cdArr) {
		this.wh_area_cdArr = wh_area_cdArr;
	}
	public String getWh_area() {
		return wh_area;
	}
	public void setWh_area(String wh_area) {
		this.wh_area = wh_area;
	}
	public String[] getWh_areaArr() {
		return wh_areaArr;
	}
	public void setWh_areaArr(String[] wh_areaArr) {
		this.wh_areaArr = wh_areaArr;
	}
	public int getWh_loc_in_area_cd() {
		return wh_loc_in_area_cd;
	}
	public void setWh_loc_in_area_cd(int wh_loc_in_area_cd) {
		this.wh_loc_in_area_cd = wh_loc_in_area_cd;
	}
	public int[] getWh_loc_in_area_cdArr() {
		return wh_loc_in_area_cdArr;
	}
	public void setWh_loc_in_area_cdArr(int[] wh_loc_in_area_cdArr) {
		this.wh_loc_in_area_cdArr = wh_loc_in_area_cdArr;
	}
	public String getWh_loc_in_area() {
		return wh_loc_in_area;
	}
	public void setWh_loc_in_area(String wh_loc_in_area) {
		this.wh_loc_in_area = wh_loc_in_area;
	}
	public String[] getWh_loc_in_areaArr() {
		return wh_loc_in_areaArr;
	}
	public void setWh_loc_in_areaArr(String[] wh_loc_in_areaArr) {
		this.wh_loc_in_areaArr = wh_loc_in_areaArr;
	}
	public int getStock_qty() {
		return stock_qty;
	}
	public void setStock_qty(int stock_qty) {
		this.stock_qty = stock_qty;
	}
	public int[] getStock_qtyArr() {
		return stock_qtyArr;
	}
	public void setStock_qtyArr(int[] stock_qtyArr) {
		this.stock_qtyArr = stock_qtyArr;
	}
	public int getUpdate_qty() {
		return update_qty;
	}
	public void setUpdate_qty(int update_qty) {
		this.update_qty = update_qty;
	}
	public int[] getUpdate_qtyArr() {
		return update_qtyArr;
	}
	public void setUpdate_qtyArr(int[] update_qtyArr) {
		this.update_qtyArr = update_qtyArr;
	}
	public int getMove_stock_cd() {
		return move_stock_cd;
	}
	public void setMove_stock_cd(int move_stock_cd) {
		this.move_stock_cd = move_stock_cd;
	}
	public int[] getMove_stock_cdArr() {
		return move_stock_cdArr;
	}
	public void setMove_stock_cdArr(int[] move_stock_cdArr) {
		this.move_stock_cdArr = move_stock_cdArr;
	}
	public int getMove_wh_loc_in_area_cd() {
		return move_wh_loc_in_area_cd;
	}
	public void setMove_wh_loc_in_area_cd(int move_wh_loc_in_area_cd) {
		this.move_wh_loc_in_area_cd = move_wh_loc_in_area_cd;
	}
	public int[] getMove_wh_loc_in_area_cdArr() {
		return move_wh_loc_in_area_cdArr;
	}
	public void setMove_wh_loc_in_area_cdArr(int[] move_wh_loc_in_area_cdArr) {
		this.move_wh_loc_in_area_cdArr = move_wh_loc_in_area_cdArr;
	}
	public int getMove_qty() {
		return move_qty;
	}
	public void setMove_qty(int move_qty) {
		this.move_qty = move_qty;
	}
	public int[] getMove_qtyArr() {
		return move_qtyArr;
	}
	public void setMove_qtyArr(int[] move_qtyArr) {
		this.move_qtyArr = move_qtyArr;
	}
	public int getStock_control() {
		return stock_control;
	}
	public void setStock_control(int stock_control) {
		this.stock_control = stock_control;
	}
	public int[] getStock_controlArr() {
		return stock_controlArr;
	}
	public void setStock_controlArr(int[] stock_controlArr) {
		this.stock_controlArr = stock_controlArr;
	}
	@Override
	public String toString() {
		return "StockVo [stock_cd=" + stock_cd + ", stock_cdArr=" + Arrays.toString(stock_cdArr) + ", product_cd="
				+ product_cd + ", product_cdArr=" + Arrays.toString(product_cdArr) + ", product_name=" + product_name
				+ ", product_nameArr=" + Arrays.toString(product_nameArr) + ", wh_cd=" + wh_cd + ", wh_cdArr="
				+ Arrays.toString(wh_cdArr) + ", wh_name=" + wh_name + ", wh_nameArr=" + Arrays.toString(wh_nameArr)
				+ ", wh_area_cd=" + wh_area_cd + ", wh_area_cdArr=" + Arrays.toString(wh_area_cdArr) + ", wh_area="
				+ wh_area + ", wh_areaArr=" + Arrays.toString(wh_areaArr) + ", wh_loc_in_area_cd=" + wh_loc_in_area_cd
				+ ", wh_loc_in_area_cdArr=" + Arrays.toString(wh_loc_in_area_cdArr) + ", wh_loc_in_area="
				+ wh_loc_in_area + ", wh_loc_in_areaArr=" + Arrays.toString(wh_loc_in_areaArr) + ", stock_qty="
				+ stock_qty + ", stock_qtyArr=" + Arrays.toString(stock_qtyArr) + ", update_qty=" + update_qty
				+ ", update_qtyArr=" + Arrays.toString(update_qtyArr) + ", move_stock_cd=" + move_stock_cd
				+ ", move_stock_cdArr=" + Arrays.toString(move_stock_cdArr) + ", move_wh_loc_in_area_cd="
				+ move_wh_loc_in_area_cd + ", move_wh_loc_in_area_cdArr=" + Arrays.toString(move_wh_loc_in_area_cdArr)
				+ ", move_qty=" + move_qty + ", move_qtyArr=" + Arrays.toString(move_qtyArr) + ", stock_control="
				+ stock_control + ", stock_controlArr=" + Arrays.toString(stock_controlArr) + "]";
	}
		

}
	
	