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
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>품목 그룹</title>

<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
</head>
<body>
<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
		<main id="main" class="main">
			<div class="pagetitle">
		      <h1>품목 그룹 검색</h1>
		    	</div><!-- End Page Title -->
		            <div class="card mb-4">
		                <div class="card-header">
		                     품목 목록 조회
		                     <button class="btn btn-secondary" onclick="prod_insert()" style="float: right;">선택완료</button>
		                 </div>
		                 <div class="card-body">
		                     <h5 class="card-title"></h5>
		
		              <!-- Table with hoverable rows -->
		              <table class="table table-hover">
		                <thead>
		                  <tr>
		                    <th scope="col">품목 그룹 코드(소)</th>
		                    <th scope="col">품목 그룹명(소)</th>
		                  </tr>
		                </thead>
		                <tbody>
		                  <tr>
		                    <td>${product.product_group_bottom_cd }</td>
		                    <td>${product.product_group_bottom_name }</td>
		                  </tr>
		                </tbody>
		              </table>
		              <!-- End Table with hoverable rows -->
		
		            </div>
		          </div>
		          
		</main>	
</body>
</html>	