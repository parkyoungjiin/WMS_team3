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
<title>품목 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

<!-- =========================품목 그룹 검색================================ -->
<script type="text/javascript">
function saveIdx(cb) {
	var idx = cb.id.replace("search_pGroup", "");
	alert(idx)
		$("#pGroup_table").on('click','tr',function(){
		   let pG_arr = $(this).find('td');
		   console.log(pG_arr);
		   
	//	   $('#no').val($(pG_arr[0]).text());
		   let pG_Code = $(pG_arr[0]).text(); //재고번호
	//	   $('#name').val($(pG_arr[1]).text());
		   let move_wh_loc_in_area = $(pG_arr[1]).text(); //창고위치
		   console.log(move_wh_loc_in_area);
		   
		
		   // td 클릭 -> 모달창 닫기
		   $('#modalDialogScrollable_pGroup').modal('hide');
		   $("#move_stock_cd" + idx).val(pG_Code);
		   $("#move_wh_loc_in_area" + idx).val(move_wh_loc_in_area);
		});
	
}//saveIdx 끝
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
     <h1>품목 관리</h1>
   </div>
	<div class="card-header">
            품목 상세 정보
        </div>
			<div></div>
		<div class="card mb-4">
		<!-- Profile Edit Form -->
		       <div class="card-body">
			
                  <form action="ProdModify.pr" method="post" enctype="multipart/form-data" id="product">
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">품목 코드</label>
                      <div class="col-md-8 col-lg-4">
                        <input name="product_cd" id="product_cd" type="text" class="form-control" readonly="readonly" value="${product.product_cd }" style= "font-style: italic; color: #868686;">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">품목명</label>
                      <div class="col-md-8 col-lg-4">
                        <input type="text" class="form-control" name="product_name" id="product_name"  value="${product.product_name }">
                      </div>
                    </div>
                    
<!--                     <div class="row mb-3"> -->
<!--                       <label for="th" name="product_group_bottom_cd" id="pGroup_keyword" class="col-md-4 col-lg-3 col-form-label">품목 그룹</label> -->
<!--                       <div class="col-md-8 col-lg-2"> -->
<!--                         <input type="text" readonly="readonly" class="form-control" name="product_name" id="product_name" required placeholder="품목 그룹 선택" > -->
<!-- <!--                      	<button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="modalDialogScrollable_buyer">검색</button> --> 
<!--                       </div> -->
<!--                     </div> -->
                    
                  
                    <!-- ===========================모달 테스트1============================= -->
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" >품목 그룹###</label>
                      <div class="col-md-8 col-lg-4">
		      			<div class="input-group mb-6">
		             		<input name="product_group_bottom_cd" type="text" class="form-control" id="product_group_bottom_cd" value="${product.product_group_bottom_cd }">
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_pGroup">검색</button>
			        	 </div>
			          </div>
			          </div>
					<!-- ===========================모달 테스트 끝============================ -->

					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">규격</label>
                      <div class="col-md-8 col-lg-4">
                        <input type="text" class="form-control" name="size_des" id="size_des" value="${product.size_des }">
                      </div>
                    </div>
                    
					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">단위</label>
                      <div class="col-md-8 col-lg-4">
                      		<input class="form-check-input" type="radio" name="unit"  value="SET" <c:if test="${product.unit eq'SET'}"> checked="checked"</c:if>>
	                        &nbsp;01 SET&nbsp;
	                        <input class="form-check-input" type="radio" name="unit"  value="BOX" <c:if test="${product.unit eq'BOX'}"> checked="checked"</c:if>>
	                        &nbsp;02 BOX&nbsp;
	                        <input class="form-check-input" type="radio" name="unit"  value="EA" <c:if test="${product.unit eq'EA'}"> checked="checked"</c:if>>
	                        &nbsp;03 EA&nbsp;
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">입고 단가</label>
                      <div class="col-md-8 col-lg-4">
                        <input type="text" class="form-control" name="in_unit_price" id="in_unit_price" value="${product.in_unit_price }">
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">출고 단가</label>
                      <div class="col-md-8 col-lg-4">
                        <input type="text" class="form-control" name="out_unit_price" id="out_unit_price" value="${product.out_unit_price }">
                      </div>
                    </div>
                    
					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">품목 구분</label>
                      <div class="col-md-8 col-lg-7">
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="01" <c:if test="${product eq'01'}"> checked="checked"</c:if>>
	                        &nbsp;01 원재료&nbsp;
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="02" <c:if test="${product eq'02'}"> checked="checked"</c:if>>
	                        &nbsp;02 부재료&nbsp;
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="03" <c:if test="${product eq'03'}"> checked="checked"</c:if>>
	                        &nbsp;03 제품&nbsp;
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="04" <c:if test="${product eq'04'}"> checked="checked"</c:if>>
	                        &nbsp;04 반제품&nbsp;
	                      <input class="form-check-input" type="radio" name="product_type_cd" value="05" <c:if test="${product eq'05'}"> checked="checked"</c:if>>
	                        &nbsp;05 상품&nbsp;
                      </div>
                    </div>
                    
                    <!-- ===========================모달 테스트2==================== -->
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" >구매 거래처###</label>
                      <div class="col-md-8 col-lg-4">
		      			<div class="input-group mb-6">
		             		<input name="business_no" type="text" class="form-control" id="business_no" value="${product.business_no }">
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_Buyer">검색</button>
			        	 </div>
			          </div>
			          </div>
					<!-- ===========================모달 테스트 끝2==================== -->
                    

                   

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">품목 이미지</label>
                      <div class="col-md-8 col-lg-4">
                        <input name="product_image" type="file" class="form-control" id="product_image" value="${product.product_image }">
                      </div>
                    </div>

					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">적요</label>
                      <div class="col-md-8 col-lg-4">
                        <textarea class="form-control" name="remarks" id="remarks" placeholder="적요" style="height: 100px;" value="${product.remarks }"></textarea>
                      </div>
                    </div>


					
					<div></div>
                    <div class="text-right">
                      <button type="submit" class="btn btn-primary">품목 수정</button>
                    </div>
                    
<!--                     ===========================모달 테스트============ -->
<!--                     <div class="row mb-3"> -->
<!--                       <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">거래처</label> -->
<!--                       <div class="col-md-8 col-lg-2"> -->
<!-- 		      			<div class="input-group mb-6"> -->
<!-- 		             		<input name="" type="text" class="form-control" id="" > -->
<!-- 				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_buyer">검색</button> -->
<!-- 			        	 </div> -->
<!-- 			          </div> -->
			          
			 <!-- Modal Dialog Scrollable 1 -->
			 <!-- 품목그룹 검색1(모달) -->
              <div class="modal fade" id="modalDialogScrollable_pGroup" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">품목 그룹 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="pGroup_keyword" >
				         <button id="search_pGroup" class="btn btn-secondary" type="button" onclick="load_pGroupList">검색</button>
			        	 </div>
<!-- 			        	 <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
                   		 <table class='table table-hover' id="pGroup_table" style="margin-left: auto; margin-right: ">
				                <tr style="text-align: center">
				                  <th scope="col">품목 그룹 코드(소)</th>
				                  <th scope="col">품목 그룹명(소)</th>
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
                      <button type="button" class="btn btn-primary">Save</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
              
			 <!-- Modal Dialog Scrollable 2 -->
			 <!-- 구매 거래처 검색2(모달) -->
              <div class="modal fade" id="modalDialogScrollable_Buyer" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">구매 거래처 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="search_buyer" class="btn btn-secondary" type="button">검색</button>
			        	 </div>
<!-- 			        	 <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
                    	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: ">
				                <tr style="text-align: center">
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
                      <button type="button" class="btn btn-primary">Save</button>
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