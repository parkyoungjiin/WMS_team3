<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>재고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

<script type="text/javascript">
</script>
</head>
<body class="sb-nav-fixed">
<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
<main id="main" class="main">
	<div class="pagetitle">
      <h1>재고 관리</h1>
    	</div><!-- End Page Title -->
            <div class="card mb-4">
                <div class="card-header">
                     재고 조회
                     <button class="btn btn-secondary" onclick="location.href='BuyerRegisterForm'" style="float: right;">신규등록</button>
                 </div>
                 <div class="card-body">
                     <table id="datatablesSimple" style="font-size: small;">
                         <thead>
                             <tr>
<!--                               				<th scope="col">#</th> -->
                               <th>재고번호</th>
                               <th>품목코드</th>
                               <th>품목명</th>
                               <th>창고명</th>
                               <th>구역명</th>
                               <th>위치명</th>
                               <th>재고수량</th>
                               <th>조정수량 </th>
                               <th>이동재고번호</th>
                               <th>이동위치</th>
                               <th>이동수량</th>
                               <th>합계수량</th>
                           </tr>
                       </thead>
                      <tbody>
                                 <c:forEach var="buyerList" items="${buyerList }">
							<tr>
<!-- 										<td><input type="checkbox"></td> -->
<!-- 										<td scope="row"></td> -->
								<td><a href="BuyerDetail?business_no=${buyerList.business_no }"> ${buyerList.business_no }</a></td>
								<td><a href="BuyerDetail?business_no=${buyerList.business_no }">${buyerList.cust_name }</a></td>
								<td>${buyerList.boss_name }</td>
								<td>${buyerList.tel }</td>
								<td>${buyerList.man_tel }</td>
								<td>${buyerList.addr }</td>
								<td>${buyerList.remarks }</td>
							</tr> 
							</c:forEach>  
                        </tbody>
                    </table>
                </div>
            </div>
</main>		


  <!-- 테이블 템플릿 css/js -->
  <script src="${path}/resources/js/scripts.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
  <script src="${path}/resources/js/datatables-simple-demo.js"></script>
<!--   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
  
</body>
</html>