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
<title>입고 처리</title>
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
	
	//-------------입고처리 시 팝업창 ----------------
	
	function in_schedule_process() {
		var genreArray = new Array();

	    $('input:checkbox[name=chk]:checked').each(function() {
	        genreArray.push(this.value);
	    });
		alert(genreArray)
	    window.open("In_Per_List_popup?IN_SCHEDULE_PER_CDArr="+genreArray, "입고처리", "width=1200, height=750, top=50, left=50");
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
      <h1>입고 관리</h1>
    </div><!-- End Page Title -->
    	
    	<div class="modal fade" id="modalDialogScrollable_complete" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body" style="text-align: center;">
<!--                      	<div class="input-group mb-6"> -->
<!-- 			        	 </div> -->
			        	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: ">
				                <tr>
				                	<th scope="col">품목코드</th>
				                	<th scope="col">품목명[규격]</th>
				                	<th scope="col">출고예정수량</th>
				                	<th scope="col">미출고수량</th>
				                </tr>
<%-- 				                <c:forEach items="${outProdList }" var="outProdList"> --%>
<!-- 					                <tr> -->
<%-- 					                	<td>${outProdList.out_product_cd }</td> --%>
<%-- 					                	<td>${outProdList.out_product_name }</td>  --%>
<%-- 					                	<td>${outProdList.out_shedule_qty }</td> --%>
<%-- 					                	<td>${outProdList.out_shedule_qty - outProdList.out_qty }</td> --%>
<!-- 					                </tr> -->
<%-- 				                </c:forEach> --%>
			        	 </table>

                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
    	
            <div class="card mb-4">
                <div class="card-header">
                     입고 처리 목록
                     <button class="btn btn-primary" onclick="location.href='OutRegisterForm'" style="float: right;">신규등록</button>
                 </div>
                 <div class="card-body">
              <!-- 탭 항목 -->
              <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                  <button class="nav-link active tab-css" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" style="font-size:15px;" aria-selected="true">전체</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link tab-css" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" style="font-size:15px;" aria-selected="false">진행 중</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link tab-css" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" style="font-size:15px;"  aria-controls="contact" aria-selected="false">완료</button>
                </li>
              </ul>
               <!-- 탭 항목 끝-->
               <div class="tab-content pt-2" id="myTabContent">
                <!-- 전체 탭 -->
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                 <table class="table table-hover" style="padding: 20px;">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
		                    <th scope="col"><input type="checkbox" id="chkAll"></th>
		                    <th scope="col">입고예정번호</th>
		                    <th scope="col">보낸곳명</th>
		                    <th scope="col">품목명</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">입고예정수량</th>
		                    <th scope="col">입고수량</th>
		                    <th scope="col">미입고수량</th>
		                    <th scope="col">적요</th>
		                  </tr>
		                </thead>
		                <tbody>
		                <c:forEach items="${list }" var="list"> 
		                  <tr>
		                    <th scope="row"></th>
		                   	<c:choose>
		                   		<c:when test="${list.IN_COMPLETE eq '1' }">
		                   		<td></td>
		                   		</c:when>
		                   		<c:otherwise>
		                   		<td><input type="checkbox" name="chk" value="${list.IN_SCHEDULE_PER_CD}"></td>
		                   		</c:otherwise>
		                   	</c:choose>
		                    <td>${list.IN_SCHEDULE_CD }</td>
		                    <td>${list.PRODUCT_CD }</td>
		                    <td>${list.PRODUCT_NAME }</td>
		                    <td>${list.IN_DATE }</td>
		                    <td>${list.IN_SCHEDULE_QTY }</td>
		                    <td>${list.IN_QTY }</td>
		                    <td>${list.IN_SCHEDULE_QTY - list.IN_QTY}</td>
		                    <td>${list.REMARKS }</td>
		                  </tr>
		                </c:forEach>
		                </tbody>
		              </table>
		              <button class="btn btn-primary" onclick="in_schedule_process()">입고처리</button>
		             </div>
		              <!-- 전체 탭 끝-->
                <!-- 진행 중 탭 -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab"> <%-- 진행 --%>
                 <table class="table table-hover" style="padding: 20px;">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
		                    <th scope="col"><input type="checkbox" id="chkAll"></th>
		                    <th scope="col">입고예정번호</th>
		                    <th scope="col">보낸곳명</th>
		                    <th scope="col">품목명</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">입고예정수량</th>
		                    <th scope="col">입고수량</th>
		                    <th scope="col">미입고수량</th>
		                    <th scope="col">적요</th>
		                  </tr>
		                </thead>
		                <tbody>
		                <c:forEach items="${list }" var="list"> 
		                 <c:if test="${list.IN_COMPLETE eq '0' }"> 
		                  <tr>
		                    <th scope="row"></th>
		                    <td><input type="checkbox" name="chk" value="${list.IN_SCHEDULE_PER_CD}"></td>
		                    <td>${list.IN_SCHEDULE_CD }</td>
		                    <td>${list.PRODUCT_CD }</td>
		                    <td>${list.PRODUCT_NAME }</td>
		                    <td>${list.IN_DATE }</td>
		                    <td>${list.IN_SCHEDULE_QTY }</td>
		                    <td>${list.IN_QTY }</td>
		                    <td>${list.IN_SCHEDULE_QTY - list.IN_QTY}</td>
		                    <td>${list.REMARKS }</td>
		                  </tr>
		                </c:if>
		                </c:forEach>
		                </tbody>
		              </table>
		              <button class="btn btn-primary" onclick="in_schedule_process()">입고처리</button>
		             </div>
		              <!-- 진행 중 끝-->
                <!-- 완료 탭 -->
               <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab"> <%--완료 시작 --%>
                 <table class="table table-hover" style="padding: 20px;">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
<!-- 		                    <th scope="col"><input type="checkbox" id="chkAll"></th> -->
		                    <th scope="col">입고예정번호</th>
		                    <th scope="col">보낸곳명</th>
		                    <th scope="col">품목명</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">입고예정수량</th>
		                    <th scope="col">입고수량</th>
		                    <th scope="col">미입고수량</th>
		                    <th scope="col">적요</th>
		                  </tr>
		                </thead>
		                <tbody>
		                <c:forEach items="${list }" var="list"> 
		                  <c:if test="${list.IN_COMPLETE eq '1' }">
		                  <tr>
		                    <th scope="row"></th>
<%-- 		                    <td><input type="checkbox" name="chk" value="${list.IN_SCHEDULE_PER_CD}"></td> --%>
		                    <td>${list.IN_SCHEDULE_CD }</td>
		                    <td>${list.PRODUCT_CD }</td>
		                    <td>${list.PRODUCT_NAME }</td>
		                    <td>${list.IN_DATE }</td>
		                    <td>${list.IN_SCHEDULE_QTY }</td>
		                    <td>${list.IN_QTY }</td>
		                    <td>${list.IN_SCHEDULE_QTY - list.IN_QTY}</td>
		                    <td>${list.REMARKS }</td>
		                  </tr>
		                  </c:if>
		                </c:forEach>
		                </tbody>
		              </table>
		             </div>
		              <!-- 완료 탭 끝-->
		             
		             
           		  </div>
            </div>
          
          
          </div>
            
</main>		
  
</body>
</html>