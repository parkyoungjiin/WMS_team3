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
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${path}/resources/css/main.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript">
	
</script>
</head>
<body>
	<header>
		<!-- top-->
		<jsp:include page="../inc/top.jsp" />
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>


		<form action="BuyerRegisterPro" method="post">
			<table border="1">
				<tr>
					<td>거래처코드</td>
					<td><input type="text" name="business_no" required="required"></td>
					<td><button type="button">fn</button></td>
				</tr>
				<tr>
					<td>상호</td>
					<td><input type="text" name="cust_name" required="required"></td>
				</tr>
				<tr>
					<td>거래처 코드 구분</td>
					<td><label><input type="radio" name="g_gubun"
							value="01" checked="checked">01 사업자등록번호</label> <label><input
							type="radio" name="g_gubun" value="02">02 해외사업자등록번호</label> <label><input
							type="radio" name="g_gubun" value="03">03 주민등록번호</label> <label><input
							type="radio" name="g_gubun" value="04">04 외국인</label></td>
				</tr>
				<tr>
					<td>대표자명</td>
					<td><input type="text" name="boss_name"></td>
				<tr />
				<tr>
					<td>업태</td>
					<td><input type="text" name="uptae"></td>
				</tr>
				<tr>
					<td>종목</td>
					<td><input type="text" name="jongmok"></td>
				</tr>
				<tr>
					<td>대표 전화번호</td>
					<td><input type="text" name="tel"></td>
				</tr>
				<tr>
					<td>팩스</td>
					<td><input type="text" name="fax"></td>
				</tr>
				<tr>
					<td>모바일</td>
					<td><input type="text" name="mobile_no"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>우편번호</td>
					<td><input type="text" name="post_no"></td>
				</tr>
				<tr>
					<td><label><input type="radio" name="location"
							value="inside" checked="checked">내부</label> <label><input
							type="radio" name="location" value="outside">외부</label></td>
					<td>주소</td>
					<td><input type="text" name="addr1"></td>
					<td>상세주소</td>
					<td><input type="text" name="addr2"></td>
				</tr>
				<tr>
					<td>홈페이지</td>
					<td><input type="text" name="man_home"></td>
				</tr>
				<tr>
					<td>담당자명</td>
					<td><input type="text" name="man_name"></td>
					<td>담당자 전화번호</td>
					<td><input type="text" name="man_tel"></td>
					<td>담당자 이메일</td>
					<td><input type="text" name="man_email"></td>
				</tr>
				<tr>
					<td>적요</td>
					<td><input type="text" name="remarks"></td>
				</tr>
				<tr>
					<td colspan="6">
					<input type="submit" value="등록"> 
					<input type="reset" value="다시쓰기"> 
					<input type="button" onclick="history.back()" value="취소"></td>
				</tr>
			</table>
		</form>
</body>
</html>