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
	}); // 체크박스 선택
	
	// 종결 상태 변경 (DB에도 값 변경해야함)
	$(function() {
		$("#btnComp").click(function() {
			var btnVal = $("#btnComp").val();
			
			if(btnVal=="취소") { // 취소버튼이 활성화일때는 해당상태가 1 > 클릭시 0(미완료 상태)으로 변경
				
				$.ajax({
					type: "get",
					url: "OutList.os",
					data: {
						out_complete: "0" // 미완료 상태로 변경
					},
					dataType: "html",
					success: function(data) {
						var check = confirm('종결된 출고를 취소하시겠습니까?');
						 if (check) {
						 	alert('출고가 완료되지 않았습니다.');
							$("#btnComp").attr("value","종결");
						 }
						 else {
						     alert('출고상태 변경이 취소되었습니다.');
						 }
					},
					error: function(xhr, textStatus, errorThrown) {
	 					alert("진생상황 변경 실패"); 
		 				}
				});
			} else if(btnVal=="종결") { // 종결버튼이 활성화 되어있다는 것은 미완료 상태라는 뜻
				$.ajax({
					type: "get",
					url: "OutList.os",
					data: {
						out_complete: "1"
					},
					dataType: "html",
					success: function(data) {
						 var check = confirm('해당 출고를 종결하시겠습니까?');
						 if (check) {
						 	alert('출고가 완료되었습니다.');
							$("#btnComp").attr("value","취소");
						 }
						 else {
						     alert('출고상태 변경이 취소되었습니다.');
						 }

					},
					error: function(xhr, textStatus, errorThrown) {
	 					alert("진생상황 변경 실패"); 
		 				}
				});
			}
		});
	}); // 종결상태 변경
	
	// 진행상태 조회 > 품목별 조회목록
	function searchCode('${outList.out_schedule_cd}') {
		let scCode = $("#scSearch").val();
		alert(scCode);
		
		$("#scSearch").click(function(){
			
		});
		
	} // 진행상태 조회 > 품목별 조회목록

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
                     출고 예정 목록
                     <button class="btn btn-primary" onclick="location.href='OutRegisterForm'" style="float: right;">신규등록</button>
                 </div>
                 <div class="card-body">
                 <table class="table table-hover" style="padding: 20px;">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
		                    <th scope="col"><input type="checkbox" id="chkAll"></th>
		                    <th scope="col">출고예정번호</th>
		                    <th scope="col">유형</th>
		                    <th scope="col">받는곳명</th>
		                    <th scope="col">담당자명</th>
		                    <th scope="col">품목명[규격]</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">출고예정수량합계</th>
		                    <th scope="col">종결상태변경</th>
		                    <th scope="col">진행상태</th>
		                  </tr>
		                </thead>
		                <tbody>
		                <c:forEach items="${outList }" var="outList">
		                  <tr>
		                    <th scope="row"></th>
		                    <td><input type="checkbox" name="chk"></td>
		                    <td>${outList.out_schedule_cd }</td>
		                    <td>${outList.out_category }</td>
		                    <td>${outList.business_no }</td>
		                    <td>${outList.emp_name }</td>
		                    <td>${outList. }</td>
		                    <td>${outList.out_date }</td>
		                    <td>jaego gaetsu</td>
		                    <td>
		                    	<c:choose>
		                    		<c:when test="${outList.out_complete eq '1'}">
										<input type="button" class="btn btn-sm btn-secondary" id="btnComp" value="취소">
		                    		</c:when>
		                    		<c:when test="${outList.out_complete eq '0'}">
		                    			<input type="button" class="btn btn-secondary btn-sm" id="btnComp" value="종결">
		                    		</c:when>
		                    	</c:choose>
		                    </td>
		                    <td>
								<button class="btn btn-secondary btn-sm" id="scSearch" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_complete" onclick="searchCode('${outList.out_schedule_cd}')">조회</button>
							</td>
		                  </tr>
		                </c:forEach>
		                </tbody>
		              </table>
		              <button class="btn btn-primary" onclick="location.href='#'">삭제하기</button>
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