<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
<!-- 거래처(기본 등록) 권한 판별 -->
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

<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>출고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
// 체크박스 선택 jQuery
	$(document).ready(function() {
		$("#chkAll").click(function() {
			if($("#chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
			else $("input[name=chk]").prop("checked", false);
		});
	
		$("input[name=chk]").click(function() {
			var total = $("input[name=chk]").length;
			var checked = $("input[name=chk]:checked").length;
		
			if(total != checked) $("#chkAll").prop("checked", false);
			else $("#chkAll").prop("checked", true); 
		});
	});
	
	$(function() {
		var btnVal = $("#complete").val();
// 		alert(btnVal);
	// 종결, 완료여부 버튼
		if(btnVal=="종결") {
			$(":button").on("click", function() {
				$("#complete").attr("value","취소");
				$("#complete").removeClass("btn-success").addClass("btn-warning");
// 				alert(btnVal)
			})
		}
		
		if(btnVal=="취소"){
			$(":button").on("click", function() {
				$("#complete").attr("value","종결");
				$("#complete").removeClass("btn-warning").addClass("btn-success");
// 				alert(btnVal);
			})
		}
	});
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
      <h1>출고 관리</h1>
    </div><!-- End Page Title -->
    
            <div class="card mb-4">
                <div class="card-header">
                     출고 예정 목록
                     <button class="btn btn-primary" onclick="location.href='OutRegisterForm'" style="float: right;">신규등록</button>
                 </div>
                 <div class="card-body">
                 <table class="table table-hover" style="padding: 20px;">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
		                    <th scope="col"><input type="checkbox" name="chkAll"></th>
		                    <th scope="col">출고예정번호</th>
		                    <th scope="col">유형</th>
		                    <th scope="col">받는곳명</th>
		                    <th scope="col">담당자명</th>
		                    <th scope="col">품목명</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">출고예정수량합계</th>
		                    <th scope="col">종결여부</th>
		                    <th scope="col">진행상태</th>
		                  </tr>
		                </thead>
		                <tbody>
		                <c:forEach items="${outList }" var="outList">
		                  <tr>
		                    <th scope="row">1</th>
		                    <td><input type="checkbox" name="chk"></td>
		                    <td>${outList.out_schedule_cd }</td>
		                    <td>발주서/구매</td>
		                    <td>${outList.business_no }</td>
		                    <td>${outList.emp_num }</td>
		                    <td>품목명</td>
		                    <td>${outList.out_date }</td>
		                    <td>jaego gaetsu</td>
		                    <td>
		                    	<input id="complete" type="button" class="btn btn-success btn-sm" value="종결">
		                    </td>
		                    <td>
								<c:choose>
		                    		<c:when test="${outList.out_complete eq '1'}">
		                    			<input type="button" class="btn btn-primary btn-sm" value="완료">
		                    		</c:when>
		                    		<c:when test="${outList.out_complete eq '0'}">
		                    			<input type="button" class="btn btn-secondary btn-sm" value="미완료">
		                    		</c:when>
		                    	</c:choose>
							</td>
		                  </tr>
		                </c:forEach>
		                  <tr>
		                    <th scope="row">2</th>
		                    <td><input type="checkbox" name="chk"></td>
		                    <td>Developer</td>
		                    <td>Developer</td>
		                    <td>35</td>
		                    <td>35</td>
		                    <td>2014-12-05</td>
		                    <td>Developer</td>
		                    <td>Developer</td>
		                    <td>Developer</td>
		                    <td>Developer</td>
		                  </tr>
		                  
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