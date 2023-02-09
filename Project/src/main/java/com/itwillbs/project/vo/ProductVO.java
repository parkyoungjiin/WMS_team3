package com.itwillbs.project.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
	private int product_cd; // 품목코드
	private String product_name; // 품목명
	private int product_group_bottom_cd; // 품목그룹(소)
	private String product_group_bottom_name; // 품목그룹명(소)
	private String size_des; // 규격
	private String unit; // 단위
	private String barcode; // 바코드
	private int in_unit_price; // 입고단가
	private int out_unit_price; // 출고단가
	private int product_type_cd; // 품목타입코드
	private String business_no;// 구매거래처코드
	private String product_image; // 대표이미지
	private String remarks; // 적요
	private int product_group_top_cd; // 품목그룹코드(대)
	private String product_group_top_name; // 품목그룹명(대)
	private String product_type_name; // 품목타입명
	private Date insertCdDate; //  상품 등록 날짜
	private String cust_name;
    // MultipartFile 타입 객체를 통한 파일 처리를 위해 MultipartFile 타입 변수 선언
	//  private MultipartFile file;
	// 만약, 복수개의 파일 업로드 시 MultipartFile 타입 배열로 선언
	private MultipartFile file;
	
	// -----------getter/setter--------------------
	
	public int getProduct_cd() {
		return product_cd;
	}
	public void setProduct_cd(int product_cd) {
		this.product_cd = product_cd;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_group_bottom_cd() {
		return product_group_bottom_cd;
	}
	public void setProduct_group_bottom_cd(int product_group_bottom_cd) {
		this.product_group_bottom_cd = product_group_bottom_cd;
	}
	public String getProduct_group_bottom_name() {
		return product_group_bottom_name;
	}
	public void setProduct_group_bottom_name(String product_group_bottom_name) {
		this.product_group_bottom_name = product_group_bottom_name;
	}
	public String getSize_des() {
		return size_des;
	}
	public void setSize_des(String size_des) {
		this.size_des = size_des;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public int getIn_unit_price() {
		return in_unit_price;
	}
	public void setIn_unit_price(int in_unit_price) {
		this.in_unit_price = in_unit_price;
	}
	public int getOut_unit_price() {
		return out_unit_price;
	}
	public void setOut_unit_price(int out_unit_price) {
		this.out_unit_price = out_unit_price;
	}
	public int getProduct_type_cd() {
		return product_type_cd;
	}
	public void setProduct_type_cd(int product_type_cd) {
		this.product_type_cd = product_type_cd;
	}
	public String getBusiness_no() {
		return business_no;
	}
	public void setBusiness_no(String business_no) {
		this.business_no = business_no;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getProduct_group_top_cd() {
		return product_group_top_cd;
	}
	public void setProduct_group_top_cd(int product_group_top_cd) {
		this.product_group_top_cd = product_group_top_cd;
	}
	public String getProduct_group_top_name() {
		return product_group_top_name;
	}
	public void setProduct_group_top_name(String product_group_top_name) {
		this.product_group_top_name = product_group_top_name;
	}
	public String getProduct_type_name() {
		return product_type_name;
	}
	public void setProduct_type_name(String product_type_name) {
		this.product_type_name = product_type_name;
	}
	public Date getInsertCdDate() {
		return insertCdDate;
	}
	public void setInsertCdDate(Date insertCdDate) {
		this.insertCdDate = insertCdDate;
	}
	public String getCust_name() {
		return cust_name;
	}
	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	// ---------------toString()---------------------
	
	
	@Override
	public String toString() {
		return "ProductVO [product_cd=" + product_cd + ", product_name=" + product_name + ", product_group_bottom_cd="
				+ product_group_bottom_cd + ", product_group_bottom_name=" + product_group_bottom_name + ", size_des="
				+ size_des + ", unit=" + unit + ", barcode=" + barcode + ", in_unit_price=" + in_unit_price
				+ ", out_unit_price=" + out_unit_price + ", product_type_cd=" + product_type_cd + ", business_no="
				+ business_no + ", product_image=" + product_image + ", remarks=" + remarks + ", product_group_top_cd="
				+ product_group_top_cd + ", product_group_top_name=" + product_group_top_name + ", product_type_name="
				+ product_type_name + ", insertCdDate=" + insertCdDate + ", cust_name=" + cust_name + ", file=" + file
				+ "]";
	}



	
}
