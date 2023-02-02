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
<meta charset="UTF-8">
<!-- css 경로 -->
<%-- <link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" /> --%>
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script>
	function logout() {
		let isLogout = confirm("로그아웃 하시겠습니까?");
		
		if(isLogout) {
			location.href = "EmpLogout.em";
		}
	}
</script>
</head>

<!-- 	<div class="nav"> -->
<!-- 		<div class="company-name"> -->
<%-- 			<a href="${path }/">SHOOKREAM</a> --%>
<!-- 		</div> -->
<!-- 		<div class="search"> -->
<!-- 		  <input type="text" name ="search" placeholder="검색어 입력"> -->
<!-- 		  <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"> -->
<!-- 		</div> -->
<%-- 	<c:choose> --%>
<%-- 		<%-- 로그인 상태가 아닐 경우 Login, Join 링크 표시 --%>
<%-- 		<%-- EL 을 사용하여 세션 객체 접근 시 sessionScope.속성명 으로 접근 --%> 
<%-- 		<c:when test="${empty sessionScope.sId }"> --%>
<!-- 			<div class="nav-right-items"> -->
<!-- 				<div class="nav-item"><a href="EmpLoginForm.em">로그인</a></div> -->
<!-- 				<div class="nav-item"></div> -->
<!-- 				<div class="nav-item"></div> -->
<!-- 				<div class="nav-item"></div> -->
<!-- 			</div> -->
<%-- 		</c:when> --%>
<%-- 		<%-- 로그인 상태일 경우 아이디 표시, Logout 링크 표시 --%> 
<%-- 		<c:otherwise> --%>
<!-- 			<div class="nav-right-items"> -->
<%-- 				<div class="nav-item"><a href="#">${sessionScope.sId }</a> 님</div> --%>
<!-- 				<div class="nav-item"><a href="javascript:logout()">Logout</a></div> -->
<!-- 				<div class="nav-item"></div> -->
<!-- 				<div class="nav-item"></div> -->
<!-- 			</div> -->
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>
		
	<!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="${path }/" class="logo d-flex align-items-center">
<!--         <img src="assets/img/logo.png" alt=""> -->
        <span class="d-none d-lg-block">SHOOKREAM</span>
      </a>
      <i class="fa-solid fa-bars toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <div class="search-bar">
      <form class="search-form d-flex align-items-center" method="POST" action="#">
        <input type="text" name="search" placeholder="Search" title="Enter search keyword">
        <button type="submit" title="Search"><i class="fa-solid fa-magnifying-glass"></i></button>
      </form>
    </div><!-- End Search Bar -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">

        <li class="nav-item d-block d-lg-none">
          <a class="nav-link nav-icon search-bar-toggle " href="#">
            <i class="bi bi-search"></i>
          </a>
        </li><!-- End Search Icon-->


      <c:choose> 
<%-- 		<%-- 로그인 상태가 아닐 경우 Login, Join 링크 표시 --%>
<%-- 		<%-- EL 을 사용하여 세션 객체 접근 시 sessionScope.속성명 으로 접근 --%> 

		<c:when test="${empty sessionScope.sId }">
		
			<div class="nav-item" style="padding-right: 50px;"><a class="nav-link nav-profile d-flex align-items-center pe-0" href="EmpLoginForm.em">로그인</a></div>
			
		</c:when>
		
		
		<%-- 로그인 상태일 경우 아이디 표시, Logout 링크 표시 --%>
		<c:otherwise>
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <img src="${path}/resources/test_image.jpg" alt="" class="rounded-circle" style="width:36px; height: 36px;"> <!-- 프로필 사진? -->
            <span class="d-none d-md-block dropdown-toggle ps-2">${sessionScope.sId } 님</span>
          </a><!-- End Profile Iamge Icon -->
		<div class="nav-item" style="padding-right: 50px;">
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6>${sessionScope.sId }</h6>
<!--               <span>Web Designer</span> -->
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="MyPage.em">
                <i class="bi bi-person"></i>
                <span>My Profile</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>


<!--             <li> -->
<!--               <a class="dropdown-item d-flex align-items-center" href="pages-faq.html"> -->
<!--                 <i class="bi bi-question-circle"></i> -->
<!--                 <span>Need Help?</span> -->
<!--               </a> -->
<!--             </li> -->
<!--             <li> -->
<!--               <hr class="dropdown-divider"> -->
<!--             </li> -->

            <li>
              <a class="dropdown-item d-flex align-items-center" href="javascript:logout()">
                <i class="bi bi-box-arrow-right"></i>
                <span>Sign Out</span>
              </a>
            </li>
          </ul><!-- End Profile Dropdown Items -->
         </div>
		</c:otherwise>
	</c:choose>
      </ul>
    </nav><!-- End Icons Navigation -->
  </header><!-- End Header -->	
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
						<li><a href="ProductListForm.pr">품목 등록</a></li>
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