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

</head>
	<div class="nav">
		<div class="company-name">
			<a href="${path }/">SHOOKREAM</a>
		</div>
		<div class="search">
		  <input type="text" name ="search" placeholder="검색어 입력">
		  <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
		</div>
		<div class="nav-right-items">
			<div class="nav-item"><a href="#">로그인</a></div>
			<div class="nav-item"></div>
			<div class="nav-item"></div>
			<div class="nav-item"></div>
		</div>
	</div>
		<div class="main-menu">
			<ul class ="menu">
				<li class="menu">
					인사관리
					<ul class="submenu">
						<li><a href="#">사원 등록</a></li>
						<li><a href="#">사원 조회</a></li>
					</ul>
				</li>
				<li>
					재고관리
					<ul class="submenu">
						<li><a href="#">기본 등록</a></li>
						<li><a href="#">구매 관리</a></li>
						<li><a href="#">WMS</a></li>
					</ul>
				</li>
			</ul>
		
		</div>


</html>