<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<!-- 품목(기본 등록) 권한 판별 -->
<script type="text/javascript">
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_res = str.charAt(0); // 기본등록(0) 여부 판별할 값
	var priv_cd_pro = str.charAt(3); // 재고조회(3) 여부 판별할 값
	var priv_cd_pro2 = str.charAt(4); // 재고관리(4) 여부 판별할 값
	
	//기본등록에 대한 권한이 있는 지 판별
	if(priv_cd_res == '1' || priv_cd_pro == '1' || priv_cd_pro2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("권한이 없습니다");
		history.back();
	}
</script>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>품목</title>
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
      <h1>품목</h1>
    </div><!-- End Page Title -->
    
            <div class="card mb-4">
                <div class="card-header">
<!--                                 <i class="fas fa-table me-1"></i> -->
                     품목 조회
                     
                 </div>
                 <div class="card-body">
                     <table id="datatablesSimple" style="font-size: small;">
                         <thead>
                             <tr>
<!--                               				<th scope="col">#</th> -->
			                    <th>품목 코드</th>
			                    <th>품목명</th>
			                    <th>거래처명</th>
			                    <th>품목 그룹명</th>
			                    <th>규격</th>
			                    <th>바코드</th>
			                    <th>입고 단가</th>
			                    <th>출고 단가</th>
			                    <th>품목 구분</th>
			                    <th>대표 이미지</th>
                           	</tr>
                       </thead>
                      <tbody>
                                 <c:forEach var="ProdList" items="${ProdList }">
							<tr>
<!-- 										<td><input type="checkbox"></td> -->
<!-- 										<td scope="row"></td> -->
<%-- 								<td><a href="ProdDetail?product_group_bottom_cd=${prodList.product_group_bottom_cd }">${prodList.product_group_bottom_cd }</a></td> --%>
<%-- 								<td><a href="ProdDetail?product_group_bottom_cd=${prodList.product_group_bottom_cd }">${prodList.product_name }</a></td> --%>
								<td><a href="ProdModify?product_cd=${ProdList.product_cd }">${ProdList.product_cd }</a></td>
								<td><a href="ProdModify?product_cd=${ProdList.product_cd }">${ProdList.product_name }</a></td>
								<td>${ProdList.cust_name }</td>
								<td>${ProdList.product_group_bottom_name }</td>
								<td>${ProdList.size_des }</td>
								<td>${ProdList.barcode }</td>
								<td>${ProdList.in_unit_price }</td>
								<td>${ProdList.out_unit_price }</td>
								<td>${ProdList.product_type_name }</td>
<%-- 								<td> <input type="image" alt="${ProdList.product_image }" src="<%=request.getScheme()+"://"+request.getServerName() + ":" + request.getServerPort() +"/"+request.getContextPath()%>/resources/upload/${ProdList.product_image }" height="70" width="70"> --%>
								<td> <input type="image" alt="${ProdList.product_image }" src="${pageContext.request.contextPath}/resources/upload/${ProdList.product_image }" onError="this.onerror=null; this.src='resources/upload/차.JPG';" height="70" width="70">
<!-- 									<img src="/upload/noImg.png" width="100" height="100"> -->
								</td>
							</tr> 
							</c:forEach>  
                        </tbody>
                    </table>
                <button class="btn btn-primary" onclick="location.href='ProductInsertForm'" style="float: right;">신규등록</button>
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