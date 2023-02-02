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
<title>거래처</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

<script type="text/javascript">
	<!-- 권한 여부 판별하여 인사부서인지 판별 -->
// 	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
// 	var priv_cd_emp = str.charAt(0); // 창고조회(1) 여부 판별할 값
// 	var priv_cd_emp2 = str.charAt(3); // 창고관리(2) 여부 판별할 값
// 	var priv_cd_emp3 = str.charAt(4); // 재고관리(2) 여부 판별할 값
	
// 	//사원조회, 사원관리에 대한 권한이 있는 지 판별
// 	if(priv_cd_emp == '1' || priv_cd_emp2 == '1' || priv_cd_emp3 == '1'){//권한이 있을 경우
		
// 	}else{//없을 경우
// 		alert("창고등록 권한이 없습니다");
// 		history.back();
// 	}
	//------------상세페이지 창 작업-------------
	function wh_info(wh_cd) {
		 location.href="WareHouseInfo.wh?wh_cd="+wh_cd;
	}
	
	//------------상세페이지(이름) 창 작업-------------
	function wh_infoName(wh_cd,wh_name) {
	     location.href="WareHouseInfoName.wh?wh_cd="+wh_cd+"&wh_name="+wh_name;
	}
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
      <h1>창고</h1>
    </div><!-- End Page Title -->
    
            <div class="card mb-4">
                <div class="card-header">
<!--                                 <i class="fas fa-table me-1"></i> -->
                	창고 조회
                     <button class="btn btn-secondary" onclick="location.href='WareHouseInsertForm.wh'" style="float: right;">창고등록</button>
                 </div>
                 <div class="card-body">
                     <table id="datatablesSimple" style="font-size: small;">
                         <thead>
                             <tr>
<!--                               				<th scope="col">#</th> -->
                               <th>창고코드</th>
                               <th>창고명</th>
                               <th>구분</th>
                               <th>관리자명</th>
                               <th>사용여부</th>
                           </tr>
                       </thead>
                      <tbody>
                            <c:forEach var="warehouse" items="${whlist }">
							<c:if test="${warehouse.wh_use eq '1' }">
							<tr>
								<td><a href="javascript:void(0);" onclick="wh_info('${warehouse.wh_cd}')">${warehouse.wh_cd }</a></td>	
								<td><a href="javascript:wh_infoName('${warehouse.wh_cd}','${warehouse.wh_name}');">${warehouse.wh_name }</a></td>	
								<td>${warehouse.wh_gubun }</td>	
								<td>${warehouse.wh_man_name }</td>	
								<c:if test="${warehouse.wh_use eq '1'}">
								<td>사용</td>	
								</c:if>
								<c:if test="${warehouse.wh_use eq '2'}">
								<td>미사용</td>
								</c:if>
							</tr>
							</c:if>
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