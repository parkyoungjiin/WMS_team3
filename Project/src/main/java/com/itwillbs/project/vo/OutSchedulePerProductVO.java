package com.itwillbs.project.vo;

import java.sql.Date;
import java.util.Arrays;

public class OutSchedulePerProductVO {
	private String out_schedule_cd;
	private int product_cd;
	private int[] product_cdArr;
	private String product_name;
	private String[] product_nameArr;
	private String product_size;
	private String[] product_sizeArr;
	private int out_schedule_qty;
	private int[] out_schedule_qtyArr;
	private int out_qty;
	private int[] out_qtyArr;
	private String out_date;
	private String[] out_dateArr;
	private String remarks_pro;
	private String[] remarks_proArr;
	private String stock_cd;
	private String[] stock_cdArr;
	private String out_complete;
	private String[] out_completeArr;
	
	
	public String getOut_schedule_cd() {
		return out_schedule_cd;
	}
	public void setOut_schedule_cd(String out_schedule_cd) {
		this.out_schedule_cd = out_schedule_cd;
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
	public String getProduct_size() {
		return product_size;
	}
	public void setProduct_size(String product_size) {
		this.product_size = product_size;
	}
	public String[] getProduct_sizeArr() {
		return product_sizeArr;
	}
	public void setProduct_sizeArr(String[] product_sizeArr) {
		this.product_sizeArr = product_sizeArr;
	}
	public void setProduct_cdArr(int[] product_cdArr) {
		this.product_cdArr = product_cdArr;
	}
	public int getOut_schedule_qty() {
		return out_schedule_qty;
	}
	public void setOut_schedule_qty(int out_schedule_qty) {
		this.out_schedule_qty = out_schedule_qty;
	}
	public int[] getOut_schedule_qtyArr() {
		return out_schedule_qtyArr;
	}
	public void setOut_schedule_qtyArr(int[] out_schedule_qtyArr) {
		this.out_schedule_qtyArr = out_schedule_qtyArr;
	}
	public int getOut_qty() {
		return out_qty;
	}
	public void setOut_qty(int out_qty) {
		this.out_qty = out_qty;
	}
	public int[] getOut_qtyArr() {
		return out_qtyArr;
	}
	public void setOut_qtyArr(int[] out_qtyArr) {
		this.out_qtyArr = out_qtyArr;
	}
	public String getOut_date() {
		return out_date;
	}
	public void setOut_date(String out_date) {
		this.out_date = out_date;
	}
	public String[] getOut_dateArr() {
		return out_dateArr;
	}
	public void setOut_dateArr(String[] out_dateArr) {
		this.out_dateArr = out_dateArr;
	}
	public String getRemarks_pro() {
		return remarks_pro;
	}
	public void setRemarks_pro(String remarks_pro) {
		this.remarks_pro = remarks_pro;
	}
	public String[] getRemarks_proArr() {
		return remarks_proArr;
	}
	public void setRemarks_proArr(String[] remarks_proArr) {
		this.remarks_proArr = remarks_proArr;
	}
	public String getStock_cd() {
		return stock_cd;
	}
	public void setStock_cd(String stock_cd) {
		this.stock_cd = stock_cd;
	}
	public String[] getStock_cdArr() {
		return stock_cdArr;
	}
	public void setStock_cdArr(String[] stock_cdArr) {
		this.stock_cdArr = stock_cdArr;
	}
	public String getOut_complete() {
		return out_complete;
	}
	public void setOut_complete(String out_complete) {
		this.out_complete = out_complete;
	}
	public String[] getOut_completeArr() {
		return out_completeArr;
	}
	public void setOut_completeArr(String[] out_completeArr) {
		this.out_completeArr = out_completeArr;
	}
	
	
	@Override
	public String toString() {
		return "OutSchedulePerProductVO [out_schedule_cd=" + out_schedule_cd + ", product_cd=" + product_cd
				+ ", product_cdArr=" + Arrays.toString(product_cdArr) + ", out_schedule_qty=" + out_schedule_qty
				+ ", out_schedule_qtyArr=" + Arrays.toString(out_schedule_qtyArr) + ", out_qty=" + out_qty
				+ ", out_qtyArr=" + Arrays.toString(out_qtyArr) + ", out_date=" + out_date + ", out_dateArr="
				+ Arrays.toString(out_dateArr) + ", remarks_pro=" + remarks_pro + ", remarks_proArr="
				+ Arrays.toString(remarks_proArr) + ", stock_cd=" + stock_cd + ", stock_cdArr="
				+ Arrays.toString(stock_cdArr) + ", out_complete=" + out_complete + ", out_completeArr="
				+ Arrays.toString(out_completeArr) + "]";
	}

	
}
