package com.itwillbs.project.vo;

import java.sql.Timestamp;
import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class BuyerVo {
	private String business_no; // 거래처 코드
	private String cust_name; // 상호
	private String boss_name; // 대표자명
	private String uptae; // 업태
	private String jongmok; // 종목
	private String tel; // 대표 전화번호
	private String[] telArr;
	private String email; // 이메일
	private String[] emailArr; // 이메일
	private String post_no; // 우편번호
	private String addr; // 주소
	private String[] addrArr; // 주소
	private String g_gubun; // 거래처코드 구분
	private String fax; // fax
	private String mobile_no; // 모바일
	private String man_home; // 홈페이지
	private String man_name; // 담당자명
	private String man_tel; // 담당자 전화번호
	private String[] man_telArr; // 담당자 전화번호
	private String man_email; // 담당자 e-mail
	private String[] man_emailArr; // 담당자 e-mail
	private String remarks; // 적요
	private String by_use; // 사용여부
	
	
	
	
	
	public String[] getTelArr() {
		return telArr;
	}
	public void setTelArr(String[] telArr) {
		this.telArr = telArr;
	}
	
	public String[] getEmailArr() {
		return emailArr;
	}
	public void setEmailArr(String[] emailArr) {
		this.emailArr = emailArr;
	}
	public String[] getAddrArr() {
		return addrArr;
	}
	public void setAddrArr(String[] addrArr) {
		this.addrArr = addrArr;
	}
	public String[] getMan_telArr() {
		return man_telArr;
	}
	public void setMan_telArr(String[] man_telArr) {
		this.man_telArr = man_telArr;
	}
	public String[] getMan_emailArr() {
		return man_emailArr;
	}
	public void setMan_emailArr(String[] man_emailArr) {
		this.man_emailArr = man_emailArr;
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
	public String getBoss_name() {
		return boss_name;
	}
	public void setBoss_name(String boss_name) {
		this.boss_name = boss_name;
	}
	public String getUptae() {
		return uptae;
	}
	public void setUptae(String uptae) {
		this.uptae = uptae;
	}
	public String getJongmok() {
		return jongmok;
	}
	public void setJongmok(String jongmok) {
		this.jongmok = jongmok;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPost_no() {
		return post_no;
	}
	public void setPost_no(String post_no) {
		this.post_no = post_no;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getG_gubun() {
		return g_gubun;
	}
	public void setG_gubun(String g_gubun) {
		this.g_gubun = g_gubun;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getMobile_no() {
		return mobile_no;
	}
	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}
	public String getMan_home() {
		return man_home;
	}
	public void setMan_home(String man_home) {
		this.man_home = man_home;
	}
	public String getMan_name() {
		return man_name;
	}
	public void setMan_name(String man_name) {
		this.man_name = man_name;
	}
	public String getMan_tel() {
		return man_tel;
	}
	public void setMan_tel(String man_tel) {
		this.man_tel = man_tel;
	}
	public String getMan_email() {
		return man_email;
	}
	public void setMan_email(String man_email) {
		this.man_email = man_email;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getBy_use() {
		return by_use;
	}
	public void setBy_use(String by_use) {
		this.by_use = by_use;
	}
	@Override
	public String toString() {
		return "BuyerVo [business_no=" + business_no + ", cust_name=" + cust_name + ", boss_name=" + boss_name
				+ ", uptae=" + uptae + ", jongmok=" + jongmok + ", tel=" + tel + ", telArr=" + Arrays.toString(telArr)
				+ ", email=" + email + ", emailArr=" + Arrays.toString(emailArr) + ", post_no=" + post_no + ", addr="
				+ addr + ", addrArr=" + Arrays.toString(addrArr) + ", g_gubun=" + g_gubun + ", fax=" + fax
				+ ", mobile_no=" + mobile_no + ", man_home=" + man_home + ", man_name=" + man_name + ", man_tel="
				+ man_tel + ", man_telArr=" + Arrays.toString(man_telArr) + ", man_email=" + man_email
				+ ", man_emailArr=" + Arrays.toString(man_emailArr) + ", remarks=" + remarks + ", by_use=" + by_use
				+ "]";
	}
	
	
	
	
	
}














