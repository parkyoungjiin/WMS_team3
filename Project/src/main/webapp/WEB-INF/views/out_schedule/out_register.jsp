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
	
	
$(function() {
	
	// td 클릭 시 해당 value 가져오기
	$("#buyer_table").on('click','tr',function(){
		   let td_arr = $(this).find('td');
		   console.log(td_arr);
		   
// 		   $('#no').val($(td_arr[0]).text());
		   let no = $(td_arr[0]).text();
// 		   $('#name').val($(td_arr[1]).text());
		   let cust_name = $(td_arr[1]).text();
		   console.log(cust_name);
		   
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_buyer').modal('hide');
		   $("#cust_name").val(cust_name);
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
        
       <div class="card-body" style="padding: 50px 80px;">
              
              
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
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_buyer">검색</button>
			        	 </div>
			          </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">담당자</label>
                      <div class="col-md-8 col-lg-2">
		      			<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_emp">검색</button>
			        	 </div>
			          </div>
                    </div>
                
                <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">납기일자</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="HIRE_DATE" type="date" class="form-control" id="Twitter">
                      </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">비고</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="HIRE_DATE" type="text" class="form-control" id="Twitter">
                      </div>
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
<!-- 				                <tbody> -->
				                
<!-- 				                </tbody> -->
<!-- 				                <tr> -->
<!-- 				                	<td colspan="2" style="text-align: center;" id="buyer_search">검색 후 이용 바랍니다.</td> -->
<!-- 				                </tr> -->
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
                    <div class="modal-body">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="" class="btn btn-secondary" type="button">검색</button>
			        	 </div>
				         <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
			
			
		</div> <!-- card mb-4 -->
		
		<div class="card mb-4">
        	
     	  <div class="card-body">
       			
       			<table class="table table-hover">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
		                    <th scope="col"><input type="checkbox"></th>
		                    <th scope="col">품목코드</th>
		                    <th scope="col">품목명</th>
		                    <th scope="col">규격</th>
		                    <th scope="col">수량</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">적요</th>
		                    <th scope="col">출고대상재고</th>
		                  </tr>
		                </thead>
		                <tbody>
		                  <tr>
		                    <th scope="row">1</th>
		                    <td><input type="checkbox"></td>
		                    <td>Designer</td>
		                    <td>Designer</td>
		                    <td>28</td>
		                    <td>28</td>
		                    <td>2016-05-25</td>
		                    <td>Designer</td>
		                    <td><button class="btn btn-secondary">검색</button> </td>
		                  </tr>
		                  <tr>
		                    <th scope="row">2</th>
		                    <td><input type="checkbox"></td>
		                    <td>Developer</td>
		                    <td>Developer</td>
		                    <td>35</td>
		                    <td>35</td>
		                    <td>2014-12-05</td>
		                    <td>Developer</td>
		                    <td><button class="btn btn-secondary">검색</button></td>
		                  </tr>
		                  
		                </tbody>
		              </table>
		              
		              <!-- End Table with hoverable rows -->
       			<div class="text-right" style="float: right; padding-top: 50px">
                  <button type="submit" class="btn btn-primary" onclick="fn_registerBuyer()">등록</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
       </div>
       
       </div>
           </form>  
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>