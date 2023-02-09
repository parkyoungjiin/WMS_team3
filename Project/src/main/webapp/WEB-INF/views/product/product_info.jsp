<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- css 경로 설정 -->
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<!-- css -->
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<!-- js -->
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<meta charset="UTF-8">

<style type="text/css">
	#title_label{
		font-weight: bold;
	}
</style>
<title>품목 등록</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>



<!-- ========================= 품목 등록 모달 ================================ -->
<script type="text/javascript">

var idx = 0;
var selectIdx;

//거래처 목록 조회(모달)
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
			$("#modal-body-buyer > table ").remove();   //테이블 비우고

			let no_result = "<table class='table table-hover' id='buyer_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer;'>"
                + '<th scope="col" style ="width:180px">거래처 코드</th>'
                + '<th scope="col" style ="width:285px">상호명</th>'
                + '</tr>'
				+ "<tr style='cursor:pointer;'>"
				+ "<td colspan ='2'>"
				+ "<h4 style='font-weight: bold; text-align: center;'>검색결과가 없습니다."
				+ "</h4>"
				+ "</td>"
				+ "</tr>";
		 		+ '</table>';

// // 			$("#buyer_search").append("<div></div>");
// 			$("#buyer_search").html("<div>등록된 데이터가 없습니다.</div>");
// 			$("#buyer_search").css("color","#B9062F");
	         $("#modal-body-buyer").append(no_result);


		}else{
			
		$("#modal-body-buyer > table ").remove();   //테이블 비우고
			
				let set_table = "<table class='table table-hover' id='buyer_table' style='margin-left: auto; margin-right: '>"
					+ "<tr style='cursor:pointer;'>"
	                + '<th scope="col" style ="width:180px">거래처 코드</th>'
	                + '<th scope="col" style ="width:285px">상호명</th>'
	                + '</tr>'
  			 		+ '</table>';
  			 		
		         $("#modal-body-buyer").append(set_table);
				
		
// 		else {
// 			$("#buyer_search").remove();
// 		}
		for(let buyer of buyerList) {
			console.log("buyer.business_no : " + buyer.business_no);
			let result = "<tr style='cursor:pointer;'>"
		                + "<td>" + buyer.business_no + "</td>"
		                + "<td id='cust_name'>" + buyer.cust_name + "</td>"
               			+ "</tr>";
             
			$("#buyer_table").append(result);
		}
		}

	})
	.fail(function() {
		$("#modal-body-buyer").append("<h3>요청 실패!</h3>");
	});
}


// td 클릭 시 해당 value 가져오기
$(function() {
	// 품목 그룹
	$("#pGroup_table").on('click','tr',function(){
		   let td_arr = $(this).find('td');
		   
		   console.log(td_arr);
		   
		   let p_Tcd = $(td_arr[0]).text();
		   let p_Gcd = $(td_arr[1]).text();
		   let p_Gnm = $(td_arr[2]).text();
		   console.log(p_Gcd);
		   console.log(p_Gnm);
		   
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_pGroup').modal('hide');
		   $("#product_group_bottom_name").val(p_Gnm);
		   $("#product_group_bottom_cd").val(p_Gcd);
		   $("#product_group_top_cd").val(p_Tcd);
	});	   
	
	// 거래처
	$("#modal-body-buyer").on('click','tr',function(){
		  let td_arr = $(this).find('td');
		  console.log(td_arr);
			   
//		  $('#no').val($(td_arr[0]).text());
		  let no = $(td_arr[0]).text();
//		  $('#name').val($(td_arr[1]).text());
	      let cust_name = $(td_arr[1]).text();
		  console.log(no);
		  console.log(cust_name);
			   
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_buyer').modal('hide');
		   $("#cust_name").val(cust_name);
		   $("#business_no").val(no);
	});	 

});

</script>

</head>

<body>
	<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
<main id ="main" class="main">
   <div class="pagetitle">
     <h1>품목 상세</h1>
   </div>
	<div class="card-header">
            품목 상세
        </div>
			<div></div>
		<div class="card mb-4">
		<!-- Profile Edit Form -->
		       <div class="card-body">
			
				  <!-- 품목 코드 -->
                  <form action="UpdateProd" method="post" enctype="multipart/form-data" id="product">
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">품목 코드</label>
                      <div class="col-md-8 col-lg-4">
                        <input name="product_cd" id="product_cd" type="text" class="form-control" readonly="readonly" value="${product.product_cd }" style= "font-style: italic; color: #868686;">
                      </div>
                    </div>

					<!-- 품목명 -->
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">품목명</label>
                      <div class="col-md-8 col-lg-4">
                       <input type="text" class="form-control" name="product_name" id="product_name" value="${product.product_name }">
                      </div>
                    </div>
                    
                    <!-- 품목 그룹 -->
                    <!-- =========================== 모달 1 - 품목 그룹 ============================= -->
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" >품목 그룹</label>
                      <div class="col-md-8 col-lg-4">
		      			<div class="input-group mb-6">
		      				<input type="hidden" name="product_group_top_cd" id="product_group_top_cd"  class="form-control" >
		      				<input name="product_group_bottom_cd" type="hidden" class="form-control" id="product_group_bottom_cd" value="${product.product_group_bottom_cd }">
							<input name="product_group_bottom_name" id="product_group_bottom_name" type="text" class="form-control" readonly="readonly" value="${product.product_group_bottom_name }"><!-- prod_group_bottom. -->
				         <button id="search_pGroup" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_pGroup">검색</button>
			        	 </div>
			          </div>
			          </div>
					<!-- =========================== 모달 1 - 품목 그룹 끝 ============================= -->
					
					<!-- 규격 -->
					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">규격</label>
                      <div class="col-md-8 col-lg-4">
                        <input type="text" class="form-control" name="size_des" id="size_des" value="${product.size_des }">
                      </div>
                    </div>
                    
                    <!-- 단위 -->
					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">단위</label>
                      <div class="col-md-8 col-lg-4">
		                    <input class="form-check-input" type="radio" name="unit"  value="SET" <c:if test="${product.unit eq'SET'}" >checked </c:if>>
		                    &nbsp;SET&nbsp; 
	                        <input class="form-check-input" type="radio" name="unit"  value="BOX" <c:if test="${product.unit eq'BOX'}">checked</c:if>>
	                        &nbsp;BOX&nbsp;
	                        <input class="form-check-input" type="radio" name="unit"  value="EA" <c:if test="${product.unit eq'EA'}">checked</c:if>>
	                        &nbsp;EA&nbsp;
                      </div>
                    </div>
                    
                    <!-- 입고 단가 -->
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">입고 단가</label>
                      <div class="col-md-8 col-lg-4">
                        <input type="text" class="form-control" name="in_unit_price" id="in_unit_price" value="${product.in_unit_price }">
                      </div>
                    </div>
                    
                    <!-- 출고 단가 -->
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">출고 단가</label>
                      <div class="col-md-8 col-lg-4">
                        <input type="text" class="form-control" name="out_unit_price" id="out_unit_price" value="${product.out_unit_price }">
                      </div>
                    </div>
                    
                    <!-- 품목 구분 -->
					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">품목 구분</label>
                      <div class="col-md-8 col-lg-7">
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="01" <c:if test="${product.product_type_cd eq'1'}">checked</c:if>>
	                        &nbsp;원재료&nbsp;
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="02" <c:if test="${product.product_type_cd eq'2'}">checked</c:if>>
	                        &nbsp;부재료&nbsp;
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="03" <c:if test="${product.product_type_cd eq'3'}">checked</c:if>>
	                        &nbsp;제품&nbsp;
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="04" <c:if test="${product.product_type_cd eq'4'}">checked</c:if>>
	                        &nbsp;반제품&nbsp;
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="05" <c:if test="${product.product_type_cd eq'5'}">checked</c:if>>
	                        &nbsp;상품&nbsp;
                      </div>
                    </div>
                    
                    <!-- 거래처 -->
                    <!-- ==================== 모달 2 - 거래처 =========================== -->
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" >구매 거래처</label>
                      <div class="col-md-8 col-lg-4">
		      			<div class="input-group mb-6">
		             		<input name="cust_name" id="cust_name" type="text" class="form-control" readonly="readonly" value="${product.business_no }">
				         	<input name="business_no" id="business_no" type="hidden" class="form-control"  >
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_buyer">검색</button>
			        	 </div>
			          </div>
			          </div>
					<!-- ==================== 모달 2 - 거래처 끝 =========================== -->
                   
					<!-- 품목 이미지 -->
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">품목 이미지</label>
                      <div class="col-md-8 col-lg-4">
                         <input name="file" type="file" class="form-control" id="file" value="${product.product_image }"> 
                      		현재 등록된 이미지 : ${product.product_image }
                      </div>
                    </div>

					<!-- 적요 -->
					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">적요</label>
                      <div class="col-md-8 col-lg-4">
                         <textarea class="form-control" name="remarks" id="remarks" style="height: 100px;" value="${product.remarks }">${product.remarks }</textarea>
                     		현재 등록된 적요 : ${product.remarks }
                      </div>
                    </div>

					<!-- 품목 등록 -->
					<div></div>
                    <div class="text-right">
                      <button type="submit" class="btn btn-primary">품목 수정</button>
                    </div>
                    
			          
			 <!-- Modal Dialog Scrollable 1 -->
			 <!-- ================================================ 품목그룹 검색1(모달) ================================================ -->
              <div class="modal fade" id="modalDialogScrollable_pGroup" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">품목 그룹 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                     	<div class="input-group mb-6">
<!-- 		             		<input name="" type="text" class="form-control" id="pGroup_keyword" > -->
<!-- 				         <button id="search_pGroup" class="btn btn-secondary" type="button" onclick="load_pGroupList">검색</button> -->
			        	 </div>
                   		 <table class='table table-hover' id="pGroup_table" style="margin-left: auto; margin-right: ">
				                <tr style="text-align: center">
				                  <th scope="col">품목 그룹 코드(대)</th>
				                  <th scope="col">품목 그룹 코드(소)</th>
				                  <th scope="col">품목 그룹명(소)</th>
				                </tr>
	                                 <c:forEach var="ProdGList" items="${ProdGList }" varStatus="status">
		        	 			<tr>
		        	 				<td>${ProdGList.product_group_top_cd}</td>
		        	 				<td>${ProdGList.product_group_bottom_cd}</td>
		        	 				<td>${ProdGList.product_group_bottom_name}</td>
		        	 			</tr>
                                 </c:forEach>
			        	 </table>
                    
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
<!--                       <button type="button" class="btn btn-primary">Save</button> -->
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
              
              
			 <!-- Modal Dialog Scrollable 2 -->
			 <!-- ================================================ 구매 거래처 검색2(모달) ================================================ -->
              <div class="modal fade" id="modalDialogScrollable_buyer" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">거래처 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-buyer" style="text-align: center;">
                     	<div class="input-group mb-6">
		             		<input name="buyer_keyword" type="text" class="form-control" id="buyer_keyword" placeholder="검색 후 이용 바랍니다.">
				         <button id="search_buyer" class="btn btn-secondary" type="button" onclick="load_buyerList()">검색</button>
			        	 </div>
<!-- 			        	 <div id="modal-body-result" style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
			        	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: ">
				                <tr>
				                  <th scope="col" style="width: 180px">거래처 코드</th>
				                  <th scope="col" style="width: 285px">상호명</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
<!--                       <button type="button" class="btn btn-primary">Save</button> -->
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
			          
                  </form><!-- End Profile Edit Form -->
                </div>
		</div>
</main>
</body>
</html>