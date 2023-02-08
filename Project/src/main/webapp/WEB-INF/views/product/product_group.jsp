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
<title>품목 그룹 검색</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
//--------------ajax list 출력 ----------------
// 	$(function() {	
// 	$.ajax({
// 		type: "GET",
// 		url: "ProdGroupList",
// 		dataType: "json"
// 		})
// 		.done(function(prodList) { // 요청 성공 시
// 		for(let list of prodList) {
// 			let result = "<tr>"
// 			+"<td>"+list.product_group_bottom_cd+"</td>" 
// 			+"<td>"+list.product_group_bottom_name+"</td>"
// 			+"<td><button class='btn btn-secondary' id='info_search' onclick='info("+list.product_group_top_cd +")'>검색</button></td>"
// 			+"</tr>";
// 			$("table > tbody").append(result);
// 		}
// 		})
// 		.fail(function() {
// 			$("table > tbody > tr").append("<h3>요청 실패!</h3>");
// 		});
// 	});
</script>
</head>
<body class="sb-nav-fixed">
<main id="main" class="main">

	<div class="pagetitle">
	<h3> 품목 그룹 목록 </h3>
	</div><!-- End Page Title -->
	
	 <div class="card mb-4">
     <div class="card-header">
<!--                                 <i class="fas fa-table me-1"></i> -->
		 품목 그룹 검색
<!--                      <button class="btn btn-primary" onclick="location.href='#'" style="float: right;">신규등록</button> -->
	</div>
    <div class="card-body">
        <table id="datatablesSimple" style="font-size: small;" id="dynamicTable">
			 <thead>
                <tr>
		          <th scope="col">품목 그룹 코드</th>
		          <th scope="col">품목 그룹명</th>
              	</tr>
          </thead>
		  <tbody id="dynamicTbody">
			
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