<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- css 경로 설정 -->
<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap"
	rel="stylesheet">
	
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- css -->
<link href="${path}/resources/css/main.css" rel="stylesheet"
	type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet"
	type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet"
	type="text/css" />
<meta charset="UTF-8">
<title>메인페이지</title>

</head>
<body>
	<header>
		<!-- top-->
		<jsp:include page="inc/top.jsp" />
	</header>
	<!-- side -->
	<jsp:include page="inc/side.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="pagetitle">
		   <h1>Dashboard</h1>
		</div><!-- End Page Title -->
		
		<section class="section dashboard">
				 <!-- Left side columns -->
			<div class="row">	
			    <div class="col-lg-6">
			         <!-- Reports -->
			            <div class="col-12">
			              <div class="card">
			                <div class="card-body">
			                  <h5 class="card-title">재고 <span>/Today</span></h5>
			                </div>
			              </div>
			            </div><!-- End Reports -->
				</div>
			
		<!-- Right side columns -->
		<div class="col-lg-6">
				 <!-- Recent Sales -->
            <div class="col-12">
              <div class="card recent-sales overflow-auto">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title"><a href="OutList.os">출고예정</a> <span>| Today</span></h5>

                  <table class="table table-borderless datatable">
                    <thead>
                      <tr>
                        <th scope="col">예정번호</th>
                        <th scope="col">거래처</th>
                        <th scope="col">담당자</th>
                        <th scope="col">납기일자</th>
                        <th scope="col">진행상황</th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="out" items="${outList }" end="5">
                      <tr>
                        <th scope="row">${out.out_schedule_cd }</th>
                        <td>${out.cust_name }</td>
                        <td>${out.emp_name }</td>
                        <td>${out.out_date }</td>
                        <c:choose>
                        	<c:when test="${out.out_complete eq '0'}">
                        		<td><input type="button" class="btn btn-sm btn-warning" value="진행중"></td>
                        	</c:when>
                        	<c:otherwise>
                        		<td><input type="button" class="btn btn-sm btn-primary" value="완료"></td>
                        	</c:otherwise>
                        </c:choose>
                      </tr>
                     </c:forEach> 
                    </tbody>
                  </table>

                </div>

              </div>
            </div><!-- End Recent Sales -->
            <div class="col-12">
              <div class="card recent-sales overflow-auto">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title"><a href="In_Per_List">입고예정 </a><span>| Today</span></h5>

                  <table class="table table-borderless datatable">
                   <thead>
                      <tr>
                        <th scope="col">예정번호</th>
                        <th scope="col">거래처</th>
                        <th scope="col">담당자</th>
                        <th scope="col">납기일자</th>
                        <th scope="col">진행상황</th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="in" items="${inList }" end="5">
                      <tr>
                        <th scope="row">${out.IN_SCHEDULE_CD }</th>
                        <td>${in.CUST_NAME }</td>
                        <td>${in.EMP_NAME }</td>
                        <td>${in.IN_DATE }</td>
                        <c:choose>
                        	<c:when test="${in.IN_COMPLETE eq '0'}">
                        		<td><input type="button" class="btn btn-sm btn-warning" value="진행중"></td>
                        	</c:when>
                        	<c:otherwise>
                        		<td><input type="button" class="btn btn-sm btn-primary" value="완료"></td>
                        	</c:otherwise>
                        </c:choose>
                      </tr>
                     </c:forEach> 
                    </tbody>
                  </table>

                </div>

              </div>
            </div><!-- End Recent Sales -->
			</div>
			</div>
		</section>
	</main>
</body>
</html>