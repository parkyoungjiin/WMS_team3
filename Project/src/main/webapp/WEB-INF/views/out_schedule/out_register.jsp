<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>출고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">

// 거래처 목록 조회(모달)
function load_buyerList() {
	
	let buyer_keyword = $("#buyer_keyword").val();
	
// 	alert(buyer_keyword);
	
	$.ajax({
		type: "GET",
		url: "BuyerListJson?keyword=" + buyer_keyword,
		dataType: "json"
	})
	.done(function(buyerList) { // 요청 성공 시
// 			$(".modal-body").append(buyerList);
// 		$("#modal-body > table").empty();	
	
		if(buyerList.length == 0){
// 			$("#buyer_search").append("<div></div>");
			$("#buyer_search").html("<div>등록된 데이터가 없습니다.</div>");
			$("#buyer_search").css("color","#B9062F");
		} 
// 		else {
// 			$("#buyer_search").remove();
// 		}
		for(let buyer of buyerList) {
			
			let result = "<tr style='cursor:pointer;'>"
		                + "<td>" + buyer.business_no + "</td>"
		                + "<td id='cust_name'>" + buyer.cust_name + "</td>"
               			+ "</tr>";
             
			$("#modal-body > table").append(result);
		}
	})
	.fail(function() {
		$("#modal-body > table").append("<h3>요청 실패!</h3>");
	});
}


// 사원 목록 조회(모달)
function load_empList() {
	
	let emp_keyword = $("#emp_keyword").val();
	
	$.ajax({
		type: "GET",
		url: "EmpListJson?keyword=" + emp_keyword,
		dataType: "json"
	})
	.done(function(empList) { // 요청 성공 시
// 		$(".modal-body").append(buyerList);
// 		$("#modal-body > table").empty();	
	
// 		if(buyerList.length == 0){
// 			$("#buyer_search").append("<div></div>");
// 			$("#buyer_search").html("<div>등록된 데이터가 없습니다.</div>");
// 			$("#buyer_search").css("color","#B9062F");
// 		} 
// 		else {
// 			$("#buyer_search").remove();
// 		}
		for(let emp of empList) {
			
			let result = "<tr style='cursor:pointer;'>"
		                + "<td>" + emp.EMP_NUM + "</td>"
		                + "<td>" + emp.DEPT_CD + "</td>"
		                + "<td>" + emp.EMP_NAME + "</td>"
               			+ "</tr>";
             
			$("#modal-body-emp > table").append(result);
		}
	})
	.fail(function() {
		$("#modal-body-emp > table").append("<h3>요청 실패!</h3>");
	});
}
	
	
$(function() {
	
	$("#buyer_table").on('click','tr',function(){
		   let td_arr = $(this).find('td');
		   console.log(td_arr);
		   
//		   $('#no').val($(td_arr[0]).text());
		   let no = $(td_arr[0]).text();
//		   $('#name').val($(td_arr[1]).text());
		   let cust_name = $(td_arr[1]).text();
		   console.log(cust_name);
		   
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_buyer').modal('hide');
		   $("#cust_name").val(cust_name);
	});	   
	
	// td 클릭 시 해당 value 가져오기
	$("#emp_table").on('click','tr',function(){
		   let td_arr = $(this).find('td');
		   console.log(td_arr);
		   
// 		   $('#no').val($(td_arr[0]).text());
		   let emp_no = $(td_arr[0]).text();
		   let dept_cd = $(td_arr[1]).text();
		   let emp_name = $(td_arr[2]).text();
		   console.log(emp_name);
		   
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_emp').modal('hide');
		   $("#emp_name").val(emp_name);
		   $("#emp_num").val(emp_num);
	});	   
	
	$("#plus_out").on("click", function() {
		var date = $("#testDate").val();
		var remarks = $("#remarks").val();
// 		alert(date);
			var addInput =  '<tbody>'
							+'<tr>'
							+ '<td><input type="checkbox"></td>'
							+ '<td>'
							+ '<div class="col-md-8 col-lg-8"><div class="input-group input-group-sm mb-5">'
         					+ '<input type="text" class="form-control form-control-sm">'
	         				+ '<button class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_search_product_cd">검색</button></div>'
          					+ '</div></td>'
							+ '<td><input type="text" class="form-control form-control-sm">' + '</td>'
// 							+ '<td>' + '규격' + '</td>'
							+ '<td><input type="text" class="form-control form-control-sm"></td>'
							+ '<td><input type="date" class="form-control form-control-sm" style="border:none" value="' + date + '"></td>'
							+ '<td><input type="text" class="form-control form-control-sm" value="' + remarks + '"></td>'
							+ '<td><button id="" class="btn btn-secondary btn-sm" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_qty">검색</button></td>'
            				+ '</tr></tbody>';
            				
			var trHtml = $("[name=out_list]:last");
			trHtml.after(addInput);
		});
});


</script>

<style type="text/css">
#title_label {
	text-align: center;
}
</style>
</head>
<body>
	<header>
		<!-- top-->
		<jsp:include page="../inc/top.jsp" />
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
<main id="main" class="main">
            <form action="OutRegisterPro" method="post">

   <div class="pagetitle">
     <h1>출고 관리</h1>
   </div><!-- End Page Title -->
    
	<div class="card mb-4">
		<div class="card-header">
            출고 입력
        </div>
        
       <div class="card-body" style="padding: 80px 50px 30px 50px;">
              
              
              	<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">작성일자</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="HIRE_DATE" type="date" class="form-control" id="Twitter">
                      </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">출고유형</label>
                      <div class="col-md-8 col-lg-2">
                        <select name="GRADE_CD" required="required" class="form-select">
								<option value="B1">발주서</option>
								<option value="B6">구매</option>
							</select>
                      </div>
                    </div>
                    
                    
              	<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">거래처</label>
                      <div class="col-md-8 col-lg-2">
		      			<div class="input-group mb-6">
		             		<input name="cust_name" type="text" class="form-control" id="cust_name" >
		             		<input name="business_no" type="hidden" class="form-control" id="business_no" >
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_buyer">검색</button>
			        	 </div>
			          </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">담당자</label>
                      <div class="col-md-8 col-lg-2">
		      			<div class="input-group mb-6">
		             		<input name="emp_name" type="text" class="form-control" id="emp_name" >
		             		<input name="emp_num" type="hidden" class="form-control" id="emp_num" >
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_emp">검색</button>
			        	 </div>
			          </div>
                    </div>
                
                <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">납기일자</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="HIRE_DATE" type="date" class="form-control" id="testDate">
                      </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">비고</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="HIRE_DATE" type="text" class="form-control" id="remarks">
                      </div>
                    </div>
               
               <div class="row mb-3" style="float: right;">
                    	<label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">
	           				<input type="button" class="btn btn-secondary btn-sm" value="추가하기" id="plus_out">
	           			</label>
                    </div> 
			</div> <!-- card-body -->
			
			 <!-- Modal Dialog Scrollable -->
			 <!-- 거래처 검색 -->
              <div class="modal fade" id="modalDialogScrollable_buyer" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">거래처 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body" style="text-align: center;">
                     	<div class="input-group mb-6">
		             		<input name="buyer_keyword" type="text" class="form-control" id="buyer_keyword" >
				         <button id="search_buyer" class="btn btn-secondary" type="button" onclick="load_buyerList()">검색</button>
			        	 </div>
<!-- 			        	 <div id="modal-body-result" style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
			        	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: ">
				                <tr>
				                  <th scope="col">거래처코드</th>
				                  <th scope="col">상호명</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
              
			 <!-- Modal Dialog Scrollable -->
			 <!-- 담당자 검색 -->
              <div class="modal fade" id="modalDialogScrollable_emp" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">담당자 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-emp">
                     	<div class="input-group mb-6">
		             		<input name="emp_keyword" type="text" class="form-control" id="emp_keyword" placeholder="검색 후 이용 바랍니다.">
				         <button id="search_emp" class="btn btn-secondary" type="button" onclick="load_empList()">검색</button>
			        	 </div>
<!-- 				         <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
 						<table class='table table-hover' id="emp_table" style="margin-left: auto; margin-right: ">
				                <tr>
				                  <th scope="col">사원번호</th>
				                  <th scope="col">부서</th>
				                  <th scope="col">사원명</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
			
			<!-- Modal Dialog Scrollable -->
			 <!-- 복수개 등록시 품목 코드 검-->
              <div class="modal fade" id="modalDialogScrollable_search_product_cd" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title"></h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="" class="btn btn-secondary" type="button">검색</button>
			        	 </div>
			        	 <div style="text-align: center;">품목을 선택하세요</div>
<!-- 			        	 <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button" class="btn btn-primary">재고 선택</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
		</div> <!-- card mb-4 -->
			
			
		<%-- ********************************** 복수개 품목명 입력창(하단부)************************************************* --%>		
		<div class="card mb-4">
     	  <div class="card-body" style="font-size: small">
       			<table class="table table-hover">
		                <thead>
		                  <tr>
		                    <th scope="col"><input type="checkbox"></th>
		                    <th scope="col">품목코드</th>
		                    <th scope="col">품목명(규격)</th>
<!-- 		                    <th scope="col">규격</th> -->
		                    <th scope="col" style="width: 50px">수량</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">비고</th>
		                    <th scope="col">출고대상재고</th>
		                  </tr>
		                </thead>
		                <tbody name="out_list">
		                  
		                </tbody>
		              </table>
		              
		              <!-- End Table with hoverable rows -->
       			<div class="text-right" style="float: right; padding-top: 50px">
                  <button type="submit" class="btn btn-primary" onclick="OutRegister.os">등록</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
       </div>
		

       </div>
     </form>  
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>