<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<!-- 거래처(기본 등록) 권한 판별 -->
<script type="text/javascript">
// 	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
// 	var priv_cd_res = str.charAt(0); // 기본등록(0) 여부 판별할 값
// 	var priv_cd_pro = str.charAt(3); // 재고조회(3) 여부 판별할 값
// 	var priv_cd_pro2 = str.charAt(4); // 재고관리(4) 여부 판별할 값
	
// 	//기본등록에 대한 권한이 있는 지 판별
// 	if(priv_cd_res == '1' || priv_cd_pro == '1' || priv_cd_pro2 == '1'){//권한이 있을 경우
		
// 	}else{//없을 경우
// 		alert("권한이 없습니다");
// 		history.back();
// 	}
</script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>입고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

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
      <h1>입고 관리</h1>
    </div><!-- End Page Title -->
    
            <div class="card mb-4">
                <div class="card-header">
                     입고 예정 목록
                     <button class="btn btn-primary" onclick="location.href='InRegisterForm'" style="float: right;">신규등록</button>
                 </div>
                 <div class="card-body">
                 	<table class="table table-hover">
		                <thead>
		                  <tr>
		                    <th scope="col"><i class="fa-solid fa-arrow-down"></i></th>
		                    <th scope="col"><input type="checkbox"></th>
		                    <th scope="col">입고예정코드</th>
		                    <th scope="col">입고유형코드</th>
		                    <th scope="col">거래처코드</th>
		                    <th scope="col">담당자(사원번호)</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">적요</th>
		                    <th scope="col">진행상태</th>
		                  </tr>
		                </thead>
		                <tbody>
		                
		                </tbody>
		                 <tbody>
                          <c:forEach var="isList" items="${islist }" varStatus="idx">
							<tr>
<!-- 										<td><input type="checkbox"></td> -->
<!-- 									
	<td scope="row"></td> -->
	<td>${idx.count }</td>
	<td><input type="checkbox"></td> 
	
								<td>${isList.IN_SCHEDULE_CD }</td>
		                    <td>${isList.IN_TYPE_CD }</td>
		                    <td>${isList.BUSINESS_NO}</td>
		                    <td>${isList.EMP_NUM}</td>
		                    <td>${isList.IN_DATE}</td>
		                    <td>${isList.REMARKS }</td>
<%-- 		                     <td>${isList.IN_COMPLETE }</td> --%>
								<td>
								<c:choose >
									<c:when test="${isList.IN_COMPLETE eq '1' }">
										<span class="badge bg-success">YES</span>
									</c:when>		
									<c:otherwise>
										<span class="badge bg-warning">NO</span>
									</c:otherwise>						
								</c:choose>
								</td>
								
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