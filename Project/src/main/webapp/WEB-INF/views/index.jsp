<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<header>
	<!-- top-->
		<jsp:include page="inc/top.jsp"/>
	</header>
	<div class ="sidevar">
		<ul class ="side-menu">
			<li>
				<a href="" class="title">인사관리</a>
				<ul class="side-submenu">
					<li><a href="#">사원 등록</a></li>
					<li><a href="#">사원 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="" class="title">재고관리</a>
				<ul class="side-submenu">
					<li>
					<!-- 기본 등록 -->
					<a href="#" class="sub-title">기본 등록</a>
						<ul class="side-submenu">
							<li><a href="#">거래처 등록</a></li>
							<li><a href="#">창고 등록</a></li>
							<li><a href="#">품목 등록</a></li>
						</ul>
					</li>
					<!-- 구매 -->
					<li>
					<a href="#" class="sub-title">구매 관리</a>
					<ul class="side-submenu">
						<li><a href="#">발주 요청</a></li>
						<li><a href="#">구매 작업</a></li>
					</ul>
					</li>
					<!-- WMS -->
					<li>
					<a href="#" class="sub-title">WMS</a>
						<ul class="side-submenu">
							<li><a href="#">창고 관리</a></li>
							<li><a href="#">입고 관리</a></li>
							<li><a href="#">출고 관리</a></li>
							<li><a href="#">재고 조정</a></li>
						</ul>
					</li>
					
				</ul>
			</li>
		</ul>
	</div>
	
	
</body> 
</html>