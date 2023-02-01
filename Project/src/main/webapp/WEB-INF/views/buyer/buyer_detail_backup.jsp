<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
$(function() {
	
	// 대표 이메일
		$("#domain").on("change", function() {
			$("#email2").val($(this).val());

			if ($(this).val() == "") {
				$("#email2").prop("readonly", false);
				$("#email2").css("background-color", "white");
				$("#email2").focus();
			} else {
				$("#email2").prop("readonly", true);
				$("#email2").css("background-color", "lightgray");
			}
		});
		
		// 담당자 이메일
		$("#domain_man").on("change", function() {
			$("#email2_man").val($(this).val());

			if ($(this).val() == "") {
				$("#email2_man").prop("readonly", false);
				$("#email2_man").css("background-color", "white");
				$("#email2_man").focus();
			} else {
				$("#email2_man").prop("readonly", true);
				$("#email2_man").css("background-color", "lightgray");
			}
		});

	
		//업태, 종목 항목 input 태그 추가
		$("#plus_uptae").on("click", function() {
			var addInput = '<input type="text" name="uptae">&nbsp'
							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_uptae]:first");
			trHtml.before(addInput);
		});
		
		$("#plus_jongmok").on("click", function() {
			var addInput = '<input type="text" name="jongmok">&nbsp'
							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_jongmok]:first");
			trHtml.before(addInput);
		});
		
	});
</script>
</head>
<body>
	<header>
		<!-- top-->
		<jsp:include page="../inc/top.jsp" />
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>


		<form action="BuyerModifyPro" method="post">
			<table>
				<tr>
					<td>거래처코드</td>
					<td><input type="text" name="business_no" readonly="readonly" value="${buyer.business_no }"></td>
				</tr>
				<tr>
					<td>거래처 코드 구분</td>
					<td>
					<label><input type="radio" name="g_gubun" value="01" <c:if test="${buyer.g_gubun eq'01'}"> checked="checked"</c:if>>&nbsp;01 사업자등록번호</label>&nbsp; 
					<label><input type="radio" name="g_gubun" value="02" <c:if test="${buyer.g_gubun eq'02'}"> checked="checked"</c:if>>&nbsp;02 해외사업자등록번호</label>&nbsp; 
					<label><input type="radio" name="g_gubun" value="03" <c:if test="${buyer.g_gubun eq'03'}"> checked="checked"</c:if>>&nbsp;03 주민등록번호</label>&nbsp;
					<label><input type="radio" name="g_gubun" value="04" <c:if test="${buyer.g_gubun eq'04'}"> checked="checked"</c:if>>&nbsp;04 외국인</label>
					</td>
				</tr>
				<tr>
					<td>상호</td>
					<td><input type="text" name="cust_name" value="${buyer.cust_name }"></td>
				</tr>
				<tr>
					<td>대표자명</td>
					<td><input type="text" name="boss_name" value="${buyer.boss_name }"></td>
				<tr />
				<tr>
					<td>업태</td>
					<td><input type="text" name="uptae" value="${buyer.uptae }">&nbsp;<i id="plus_uptae" name="orgInput_uptae" class="fa-solid fa-plus" style="cursor: pointer;"></i></td>
				</tr>
				<tr>
					<td>종목</td>
					<td><input type="text" name="jongmok" value="${buyer.jongmok }">&nbsp;<i id="plus_jongmok" name="orgInput_jongmok" class="fa-solid fa-plus" style="cursor: pointer;"></i></td>
				</tr>
				<tr>
					<td>대표 전화번호</td>
					<td>
					<input type="text" size="1" name="tel" value="${buyer.telArr[0]}"> -
					<input type="text" size="1" name="tel" value="${buyer.telArr[1]}"> -
					<input type="text" size="1" name="tel" value="${buyer.telArr[2]}">
					</td>
				</tr>
				<tr>
					<td>팩스</td>
					<td><input type="text" name="fax" value="${buyer.fax }"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<input type="text" size="5" id="email1" name="email" value="${buyer.emailArr[0]}"> @ 
						<input type="text" size="5" id="email2" name="email" value="${buyer.emailArr[1]}"> 
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
					<td><input type="text" name="post_no" id="emp_address_zonecode" value="${buyer.post_no}"> &nbsp;
					<button id="address_kakao" type="button">우편번호 찾기</button></td>
			</tr>
				<tr>
				<th>주소</th>
				<td><input type="text" name="addr" id="emp_address_kakao" value="${buyer.addrArr[0]}"> &nbsp; <br> 
				<input type="text" name="addr" id="emp_address_kakao2" value="${buyer.addrArr[1]}"> &nbsp; <br> 
			</tr>
				<tr>
					<td>홈페이지</td>
					<td><input type="text" name="man_home" value="${buyer.man_home }"></td>
				</tr>
				<tr>
				<td>담당자명</td>
				<td><input type="text" name="man_name" value="${buyer.man_name }"></td>
				<td>담당자 전화번호</td>
				<td>
					<input type="text" size="1" name="man_tel" value="${buyer.man_telArr[0]}"> -
					<input type="text" size="1" name="man_tel" value="${buyer.man_telArr[1]}"> -
					<input type="text" size="1" name="man_tel" value="${buyer.man_telArr[2]}">
				</td>
				<td>담당자 이메일</td>
				<td>
				<input type="text" size="5" id="email1_man" name="man_email" value="${buyer.man_emailArr[0]}"> @ 
				<input type="text" size="5" id="email2_man" name="man_email" value="${buyer.man_emailArr[1]}"> 
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
					<td><input type="text" name="remarks" value="${buyer.remarks }"></td>
				</tr>
				<tr>
					<td colspan="6">
					<input type="submit" value="수정"> 
					<input type="reset" value="다시쓰기"> 
					<input type="button" onclick="history.back()" value="취소"></td>
				</tr>
			</table>
		</form>
</body>
</html>