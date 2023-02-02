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
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<!-- css 경로 -->
<%-- <link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" /> --%>
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<%-- <link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" /> --%>
</head>
<body>
	<div class ="sidevar">
		<ul class ="side-menu">
			<li>
				<a href="" class="title">인사관리</a>
				<ul class="side-submenu">
					<li><a href="EmpInsertForm.em" class="sub-title">사원 등록</a></li>
					<li><a href="EmployeeList.em?EMP_NAME=${sessionScope.sId }" class="sub-title">사원 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="" class="title">재고관리</a>
				<ul class="side-submenu">
					<li>
					<!-- 기본 등록 -->
					<a href="#" class="sub-title">기본 등록</a>
						<ul class="side-submenu">
							<li><a href="WareHouseListPro.wh">창고 등록</a></li>
							<li><a href="BuyerList">거래처 등록</a></li>
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
							<li><a href="WareHouseManage.wh">창고 관리</a></li>
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