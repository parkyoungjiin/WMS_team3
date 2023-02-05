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
<script type="text/javascript">
	let pageNum = 1;
	$(function() {
		let searchType = $("#searchType").val();
		let keyword = $("#keyword").val();
// 		alert(searchType + ", " + keyword);
		
		load_list(searchType, keyword);
		
		// 무한스크롤 
		$(window).scroll(function() {
// 			$("#listForm").before("확인");
			let scrollTop = $(window).scrollTop();
			let windowHeight = $(window).height();
			let documentHeight = $(document).height();
			
			console.log("scrollTop : " + scrollTop + ", windowHeight : " + windowHeight + ", documentHeight : " + documentHeight + "<br>");

			if(scrollTop + windowHeight + 1 >= documentHeight) {
				pageNum++;
				load_list(searchType, keyword);
			}
		});
	});

	
	function load_list(searchType, keyword) {
		$.ajax({
			type: "GET",
// 			url: "ProdGroupList?pageNum=" + pageNum,
			url: "ProdGroupList?pageNum=" + pageNum + "&searchType=" + searchType + "&keyword=" + keyword,
			dataType: "json"
		})
		.done(function(prodList) { // 요청 성공 시
// 			$("#listForm > table").append(boardList);
			
			for(let product of prodList) {
				
				let result = "<tr height='100'>"
							+ "<td>" + product.product_group_bottom_cd + "</td>"
// 							+ "<td id='subject'>" 
// 								+ "<a href='BoardDetail.bo?board_num=" + board.board_num + "'>"
// 								+ board.board_subject + "</a></td>"
							+ "<td>" + product.product_name + "</td>"
							+ "</tr>";
				
				// 지정된 위치(table 태그 내부)에 JSON 객체 출력문 추가
				$("#listForm > table").append(result);
			}
		})
		.fail(function() {
			$("#listForm > table").append("<h3>요청 실패!</h3>");
		});
	}

</script>
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
	
</script>
</head>
<body class="sb-nav-fixed">
<main id="main" class="main">

	<div class="pagetitle">
      <h1>품목</h1>
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
                      
                       <c:forEach var="prodList" items="${prodList }">
							<tr>
							<td>testtest</td>
									<td><input type="checkbox"></td>
									<td scope="row"></td>
<%-- 								<td><a href="BuyerDetail?business_no=${prodList.business_no }"> ${buyerList.business_no }</a></td> --%>
<%-- 								<td><a href="BuyerDetail?business_no=${prodList.business_no }">${buyerList.cust_name }</a></td> --%>
								<td>${prodList.product_group_bottom_cd }</td>
								<td>${prodList.product_name }</td>
								<td>
<%-- 								<c:choose > --%>
<%-- 									<c:when test="${buyerList.by_use eq '1' }"> --%>
<!-- 										<span class="badge bg-success">YES</span> -->
<%-- 									</c:when>		 --%>
<%-- 									<c:otherwise> --%>
<!-- 										<span class="badge bg-warning">NO</span> -->
<%-- 									</c:otherwise>						 --%>
<%-- 								</c:choose> --%>
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