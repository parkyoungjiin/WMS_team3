<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!-- css 경로 설정 -->
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<!-- css 경로 -->
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<script>
	function logout() {
		let isLogout = confirm("로그아웃 하시겠습니까?");
		
		if(isLogout) {
			location.href = "EmpLogout.em";
		}
	}
</script>
</head>
	<div class="nav">
		<div class="company-name">
			<a href="${path }/">SHOOKREAM</a>
		</div>
		<div class="search">
		  <input type="text" name ="search" placeholder="검색어 입력">
		  <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" id ="searchimg">
		</div>
	<c:choose>
		<%-- 로그인 상태가 아닐 경우 Login, Join 링크 표시 --%>
		<%-- EL 을 사용하여 세션 객체 접근 시 sessionScope.속성명 으로 접근 --%>
		<c:when test="${empty sessionScope.sId }">
			<div class="nav-right-items">
				<div class="nav-item"><a href="EmpLoginForm.em">로그인</a></div>
				<div class="nav-item"></div>
				<div class="nav-item"></div>
				<div class="nav-item"></div>
			</div>
		</c:when>
		<%-- 로그인 상태일 경우 아이디 표시, Logout 링크 표시 --%>
		<c:otherwise>
			<div class="nav-right-items">
				<div class="nav-item"><a href="#">${sessionScope.sId }</a> 님</div>
				<div class="nav-item"><a href="javascript:logout()">Logout</a></div>
				<div class="nav-item"></div>
				<div class="nav-item"></div>
			</div>
		</c:otherwise>
	</c:choose>
		
	</div>
		<div class="main-menu">
			<ul class ="menu">
				<li class="menu">
					인사관리
					<ul class="submenu">
						<li><a href="EmpInsertForm.em">사원 등록</a></li>
						<li><a href="EmployeeList.em">사원 조회</a></li>
					</ul>
				</li>
				<li>
					기본등록
					<ul class="submenu">
						<li><a href="WareHouseInsertForm.wh">창고 등록</a></li>
						<li><a href="BuyerList">거래처 등록</a></li>
						<li><a href="#">품목 등록</a></li>
					</ul>
				</li>
				<li>
					구매관리
					<ul class="submenu">
						<li><a href="#">발주 요청</a></li>
						<li><a href="#">구매 작업</a></li>
					</ul>
				</li>
				<li>
					WMS
					<ul class="submenu">
						<li><a href="#">창고 관리</a></li>
						<li><a href="#">입고 관리</a></li>
						<li><a href="#">출고 관리</a></li>
						<li><a href="#">재고 조정</a></li>
					</ul>
				</li>
			</ul>
		
		</div>


</html>