<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
	
	var codeStatus = false;

// 	$(function() {
		
// 		//업태, 종목 항목 input 태그 추가
// 		$("#plus_uptae").on("click", function() {
// 			var addInput = '<input type="text" class="form-control" name="uptae">&nbsp';
// // 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
// 			var trHtml = $("[name=orgInput_uptae]:first");
// 			trHtml.before(addInput);
// 		});
		
// 		$("#plus_jongmok").on("click", function() {
// 			var addInput = '<input type="text" class="form-control" name="jongmok">&nbsp';
// // 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
// 			var trHtml = $("[name=orgInput_jongmok]:first");
// 			trHtml.before(addInput);
// 		});
		
		
// 	});
	
// 	//  코드 중복 체크
// 	$("#prod_cd_btn").on("click", function() {
// 		let product_cd = $("#product_cd").val();
// 		$.ajax({
// 			type: "GET",
// 			url: "ProdCodeCheck?product_cd="+product_cd,
// 			data: {product_cd:$("#product_cd").val()},
// 			dataType: "html",
// 			success: function(data){
// 				if(data == 0){
// 					alert("사용 가능한 코드입니다.");
// 					$("#fr").attr("onsubmit","return true");
// // 					codeStatus = true;
// 				}else if(data == 1){
// 					alert("사용 불가능한 코드입니다.");
// 					$("#product_cd").val('');
// 					$("#product_cd").focus();
// 					$("#fr").attr("onsubmit","return false");				
// // 					codeStatus = false;
// 				}
// 			}
// 		}).fail(function(result) {
// 			alert("중복아님");
// 		});
// 	});// 코드 중복 확인 끝	
	
	
	<!-- 바코드 숫자만 입력되는 유효성 검사 -->
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	} 
	 
	function inputOnlyNumberFormat(obj) {
	    obj.value = onlynumber(uncomma(obj.value));
	}
	 
	function onlynumber(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
	}
	
	
	// 품목 그룹 목록 조회(모달)
	function load_PGroupList() {
		
		let pGroup_keyword = $("#pGroup_keyword").val();
		
		alert(pGroup_keyword);
		
		$.ajax({
			type: "GET",
			url: "pGroupListJson?keyword=" + pGroup_keyword,
			dataType: "json"
		})
		.done(function(ProdList) { // 요청 성공 시
//	 			$(".modal-body").append(buyerList);
//	 		$("#modal-body > table").empty();	
		
// 			if(ProdList.length == 0){
// //	 			$("#pGroup_search").append("<div></div>");
// 				$("#pGroup_search").html("<div>등록된 데이터가 없습니다.</div>");
// 				$("#pGroup_search").css("color","#B9062F");
// 			} 
//	 		else {
//	 			$("#pGroup_search").remove();
//	 		}
			for(let list of ProdList) {
				
				let result = "<tr style='cursor:pointer;'>"
			                + "<td>" +list.product_group_bottom_cd+ "</td>"
			                + "<td id='product_group_bottom_name'>" +list.product_group_bottom_name+ "</td>"
	               			+ "</tr>";
	             
				$("#modal-body > table").append(result);
			}
		})
		.fail(function() {
			$("#modal-body > table").append("<h3>요청 실패!</h3>");
		});
	}
	
// 	$(function() {
		
// 		$("#buyer_table").on('click','tr',function(){
// 			   let td_arr = $(this).find('td');
// 			   console.log(td_arr);
			   
// //			   $('#no').val($(td_arr[0]).text());
// 			   let no = $(td_arr[0]).text();
// //			   $('#name').val($(td_arr[1]).text());
// 			   let cust_name = $(td_arr[1]).text();
// 			   console.log(cust_name);
			   
// 			   // td 클릭시 모달 창 닫기
// 			   $('##modalDialogScrollable_search_product_cd').modal('hide');
// 			   $("#cust_name").val(cust_name);
// 		});	   
		
// 		// td 클릭 시 해당 value 가져오기
// 		$("#emp_table").on('click','tr',function(){
// 			   let td_arr = $(this).find('td');
// 			   console.log(td_arr);
			   
// //	 		   $('#no').val($(td_arr[0]).text());
// 			   let emp_no = $(td_arr[0]).text();
// 			   let dept_cd = $(td_arr[1]).text();
// 			   let emp_name = $(td_arr[2]).text();
// 			   console.log(emp_name);
			   
// 			   // td 클릭시 모달 창 닫기
// 			   $('##modalDialogScrollable_search_product_cd').modal('hide');
// 			   $("#emp_name").val(emp_name);
// 			   $("#emp_num").val(emp_num);
// 		});	   
	
// 	});
	
</script>
</head>
<body>
	
<main id="main" class="main">

   <div class="pagetitle" style="text-align: center;">
     <h1>품목 등록</h1>
   </div><!-- End Page Title -->
    
	<div class="card mb-4">
		<div class="card-header">
            품목 등록
        </div>
        
       <div class="card-body">
         <!-- Floating Labels Form -->
            <form action="ProdInsertPro" method="post" class="row g-3">
              
              <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control"  readonly="readonly" value="* 품목코드는 자동으로 부여됩니다." style= "font-style: italic; color: #868686;">
                    
                    <label for="floatingName">* 품목 코드</label>
                  	</div>
                    <button id="prod_cd_btn" class="btn btn-secondary" type="button" >조회</button>
                  </div>
                </div>
               </div> 
                
<!--                 <div class="col-md-3"> -->
<!--                     <button type="button" class="btn btn-primary" onclick="checkCode()">fn</button> -->
<!--                 </div> -->
                
              <div></div>
              <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="product_name" id="product_name" required placeholder="거래처코드">
                    <label for="floatingName">* 품목명</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>
               
                <div class="col-lg-12">  
                <div></div>
                 <label class="form-label"></label>
                  <div class= "col-md-12">
                	<div class="input-group mb-1">
                      <div class="form-floating">
		                    <input type="text" class="form-control" name="product_group_bottom_cd"  id="pGroup_keyword" placeholder="품목 그룹">
		                    <label for="floatingName">* 품목 그룹</label>
                  	  </div>
                  	  <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_emp">검색</button>
                  	  
                      <input type="text" class="form-control" name="" id="">
	                    <div class="form-floating">
	                   </div>
                    </div>
                   </div>
              </div>  
                
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
		
                <div></div>
               <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="size_des" id="size_des" placeholder="규격">
                    <label for="floatingName">규격</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>
                
                
              <fieldset class="row mb-6">
                  <div class="col-sm-10">* 단위<br>   
                      <input class="form-check-input" type="radio" name="unit" value="SET" checked>
                        &nbsp;01 SET&nbsp;
                      <input class="form-check-input" type="radio" name="unit"  value="BOX">
                        &nbsp;02 BOX&nbsp;
                      <input class="form-check-input" type="radio" name="unit"  value="EA">
                        &nbsp;03 EA&nbsp;
                  </div>
                </fieldset>
                
              
				<div></div>
               <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="in_unit_price" id="in_unit_price" required placeholder="입고단가">
                    <label for="floatingName">* 입고단가 (숫자만 입력해주세요)</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>              

             <div></div>
               <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="out_unit_price" id="out_unit_price" required placeholder="출고단가">
                    <label for="floatingName">* 출고단가 (숫자만 입력해주세요)</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>  
              
              <fieldset class="row mb-6">
                  <div class="col-sm-10">
                  	* 품목 구분 <br>
                      <input class="form-check-input" type="radio" name="product_type_cd"  value="01" checked>
                        &nbsp;01 원재료&nbsp;
                      <input class="form-check-input" type="radio" name="product_type_cd"  value="02">
                        &nbsp;02 부재료&nbsp;
                      <input class="form-check-input" type="radio" name="product_type_cd"  value="03">
                        &nbsp;03 제품&nbsp;
                      <input class="form-check-input" type="radio" name="product_type_cd" value="04">
                        &nbsp;04 반제품&nbsp;
                      <input class="form-check-input" type="radio" name="product_type_cd" value="05">
                        &nbsp;05 상품&nbsp;
                  </div>
                </fieldset>
                
               <div class="col-lg-12">  
                <div></div>
                 <label class="form-label"></label>
                  <div class= "col-md-12">
                	<div class="input-group mb-1">
                      <div class="form-floating">
		                    <input type="text" class="form-control" name="business_no" id="business_no" required placeholder="구매 거래처">
		                    <label for="floatingName">* 구매 거래처</label>
                  	  </div>
                  	  <button class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_pro" >검색</button>
<!--                       <button id="" class="btn btn-secondary" type="button">검색</button> -->
                      <input type="text" class="form-control" name="b_search" id="b_search">
	                    <div class="form-floating">
	                   </div>
                    </div>
                   </div>
              </div>  
              
               <div></div>
               
             <!-- 이미지 업로드 폼 -->
             <div class="row mb-3">
                  <label for="inputNumber" class="col-sm-2 col-form-label">Image Upload</label>
                  <div class="col-sm-10">
                    <input type="file" name="product_image" class="form-control" id="product_image" >
                  </div>
                </div>
                
                <div></div>
                <div class="col-12">
                  <div class="form-floating">
                    <textarea class="form-control" placeholder="적요" id="remarks" style="height: 100px;" name="remarks"></textarea>
                    <label for="floatingTextarea">적요</label>
                  </div>
                </div>
                <div></div>
                
                <div class="text-left" >
                  <button type="submit" class="btn btn-primary" onclick="ProdInsertPro">등록</button>
                  <button type="reset" class="btn btn-secondary">다시쓰기</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
                
                
                
		<!-- Modal Dialog Scrollable -->
<!--               <div class="modal fade" id="modalDialogScrollable_search_product_cd" tabindex="-1"> -->
<!--                 <div class="modal-dialog modal-dialog-scrollable"> -->
<!--                   <div class="modal-content"> -->
<!--                     <div class="modal-header"> -->
<!--                       <h5 class="modal-title">품목 그룹 검색</h5> -->
<!--                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!--                     </div> -->
<!--                     <div class="modal-body" id="modal-body" style="text-align: center;"> -->
<!--                      	<div class="input-group mb-6"> -->
<!-- 		             		<input name="pGroup_keyword" type="text" class="form-control" > -->
<!-- 				         <button id="search_pGroup" class="btn btn-secondary" type="button" onclick="load_PGroupList()">검색</button> -->
<!-- 			        	 </div> -->
<!-- <!-- 			        	 <div id="modal-body-result" style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> --> -->
<!-- 			        	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: "> -->
<!-- 				                <tr> -->
<!-- 				                  <th scope="col">거래처코드</th> -->
<!-- 				                  <th scope="col">상호명</th> -->
<!-- 				                </tr> -->
<!-- 			        	 </table> -->
<!--                     </div> -->
<!--                     <div class="modal-footer"> -->
<!--                       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button> -->
<!--                       <button type="button" class="btn btn-primary">Save changes</button> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div> -->
<!--               </div> -->

<!-- Modal Dialog Scrollable -->
			   
               
	                
	              </form><!-- End floating Labels Form -->      
			</div>
		</div>
			
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>