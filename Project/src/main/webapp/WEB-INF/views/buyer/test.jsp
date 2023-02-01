<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form action="BuyerRegisterPro" method="post" class="row g-3">
		<table>
			<tr>
				<td >거래처코드</td>
				<td class="col-md-6"><input type="text" class="form-control" class="form-control" name="business_no" id="business_no" required="required" class="form-control"></td>
				<td ><button type="button" class="btn btn-primary" onclick="checkCode()">fn</button></td>
			</tr>
			<tr>
				<td>거래처코드 구분</td>
				<td>
				<label><input type="radio" name="g_gubun" value="01" checked="checked">&nbsp;01 사업자등록번호</label>&nbsp; 
				<label><input type="radio" name="g_gubun" value="02">&nbsp;02 해외사업자등록번호</label>&nbsp; 
				<label><input type="radio" name="g_gubun" value="03">&nbsp;03 주민등록번호</label>&nbsp;
				<label><input type="radio" name="g_gubun" value="04">&nbsp;04 외국인</label>
				</td>
			</tr>
			<tr>
				<td>상호</td>
				<td><input type="text" class="form-control" name="cust_name" required="required"></td>
			</tr>
			<tr>
				<td>대표자명</td>
				<td><input type="text" class="form-control" name="boss_name"></td>
			<tr />
			<tr>
				<td>업태</td>
				<td><input type="text" class="form-control" name="uptae">&nbsp;<i id="plus_uptae" name="orgInput_uptae" class="fa-solid fa-plus" style="cursor: pointer;"></i></td>
			</tr>
			<tr>
				<td>종목</td>
				<td><input type="text" class="form-control" name="jongmok">&nbsp;<i id="plus_jongmok" name="orgInput_jongmok" class="fa-solid fa-plus" style="cursor: pointer;"></i></td>
			</tr>
			<tr>
				<td>대표 전화번호</td>
				<td>
					<input type="text" class="form-control" size="1" name="tel"> -
					<input type="text" class="form-control" size="1" name="tel"> -
					<input type="text" class="form-control" size="1" name="tel">
				</td>
			</tr>
			<tr>
				<td>팩스</td>
				<td><input type="text" class="form-control" name="fax"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
				<input type="text" class="form-control" size="5" id="email1" name="email" > @ 
				<input type="text" class="form-control" size="5" id="email2" name="email" > 
				<select name="selectDomain" id="domain" style="padding: .4em .5em;">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
				</select> &nbsp;
				</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><input type="text" class="form-control" name="post_no" id="emp_address_zonecode" > &nbsp;
					<button id="address_kakao" type="button">우편번호 찾기</button></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" class="form-control" name="addr" id="emp_address_kakao" > &nbsp; <br> 
				<input type="text" class="form-control" name="addr" id="emp_address_kakao2" placeholder="(상세주소를 입력해주세요.)"> &nbsp; <br> 
			</tr>
			<tr>
				<td>홈페이지</td>
				<td><input type="text" class="form-control" name="man_home"></td>
			</tr>
			<tr>
				<td>담당자명</td>
				<td><input type="text" class="form-control" name="man_name"></td>
				<td>담당자 전화번호</td>
				<td>
					<input type="text" class="form-control" size="1" name="man_tel"> -
					<input type="text" class="form-control" size="1" name="man_tel"> -
					<input type="text" class="form-control" size="1" name="man_tel">
				</td>
				<td>담당자 이메일</td>
				<td>
				<input type="text" class="form-control" size="5" id="email1_man" name="man_email"> @ 
				<input type="text" class="form-control" size="5" id="email2_man" name="man_email"> 
				<select name="selectDomain" id="domain_man" style="padding: .4em .5em;">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
				</select> &nbsp;
				</td>
			</tr>
			<tr>
				<td>적요</td>
				<td><input type="text" class="form-control" name="remarks"></td>
			</tr>
			<tr>
				<td colspan="6"><input type="submit" value="등록" onclick="fn_registerBuyer()"> <input
					type="reset" value="다시쓰기"> <input type="button"
					onclick="history.back()" value="취소"></td>
			</tr>
		</table>
	</form>