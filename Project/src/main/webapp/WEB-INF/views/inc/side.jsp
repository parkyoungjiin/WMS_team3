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

<!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link collapsed" href="${path }/">
          <i class="bi bi-grid"></i>
          <span>Dashboard</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-menu-button-wide"></i><span>인사 관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="components-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="EmpInsertForm.em">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>사원 등록</span>
            </a>
          </li>
          <li>
            <a href="#">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>사원 조회</span>
            </a>
          </li>
         </ul> 
      </li><!-- End Components Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-journal-text"></i><span>기본 등록</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="forms-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          <li>
            <a href="WareHouseListPro.wh">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>창고 등록</span>
            </a>
          </li>
          <li>
            <a href="BuyerList">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>거래처 등록</span>
            </a>
          </li>
          <li>
            <a href="forms-editors.html">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>품목 등록</span>
            </a>
          </li>
        </ul>
      </li><!-- End Forms Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>WMS</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
         <li>
            <a href="WareHouseManage.wh">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>창고 관리</span>
            </a>
          </li>
         <li>
            <a href="forms-editors.html">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>입고 관리</span>
            </a>
          </li>
         <li>
            <a href="forms-editors.html">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>출고 관리</span>
            </a>
          </li>
         <li>
            <a href="forms-editors.html">
              <i class="fa-regular fa-circle fa-2xs"></i>&nbsp;<span>재고 관리</span>
            </a>
          </li>
        </ul>
      </li><!-- End Tables Nav -->


    </ul>

  </aside><!-- End Sidebar-->


</body>
</html>