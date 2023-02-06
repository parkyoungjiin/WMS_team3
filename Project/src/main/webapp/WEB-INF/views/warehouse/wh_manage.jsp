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
	
		//--------창고 리스트 출력-----------	
		// 게시물 목록 조회를 AJAX + JSON 으로 처리할 load_list() 함수 정의
		// => 검색타입과 검색어를 파라미터로 지정
			$(function() {
					$.ajax({
						type: "GET",
						url: "WareHouseListJsonPro.wh",
						dataType: "json"
					})
					.done(function(whlist) { // 요청 성공 시
						for(let list of whlist) {
							let result = "<tr id='tr"+list.wh_cd+"'>"
										+"<td><button id='minus"+list.wh_cd+"' name='minus' value='"+list.wh_cd+"' onclick='minus_button("+list.wh_cd +")' class='btn' type='button'>-</button>"
										+"<button id='plus"+list.wh_cd+"' name='plus' value='"+list.wh_cd+"'  onclick='plus_button("+list.wh_cd +")' class='btn' type='button'>+</button>"
										+list.wh_name+"</td>" 
										+"<td>" + list.wh_man_name + "</td>"
										+"<td><button class='btn btn-secondary' id='info_search' onclick='info("+list.wh_cd +")'>검색</button></td>"
										+"</tr>"
										+"<tr id='tr"+list.wh_cd+"' class='hide"+list.wh_cd+"'>"
										+"<td> <input type='text' placeholder='창고지역' class='hide"+list.wh_cd+"' id='wh_area"+list.wh_cd+"'>"
										+"<button onclick='tableCreate("+list.wh_cd +")' class='hide"+list.wh_cd+"'>추가</button> </td>"
										+"</tr>";
							$("table > tbody").append(result);
						}
					})
					.fail(function() {
						$("table > tbody > tr").append("<h3>요청 실패!</h3>");
					});// 창고 리스트 출력
					
					
 					//--------------------창고 지역 리스트 ------------------------
					$.ajax({
						type: "GET",
						url: "WareHouseAreaListJsonPro.wh",
						dataType: "json"
					})
					.done(function(wharealist) { // 요청 성공 시
						for(let list of wharealist) {
							let result ="<tr id='tr"+list.wh_area_cd+"' class='hide"+list.wh_cd+"'>"
							+"<td scope='col'>&nbsp;&nbsp;"
							+"<button id='minus_loc"+list.wh_area_cd+"' name='minus' onclick='loc_minus_button("+list.wh_area_cd +")' class='btn' type='button'>-</button>"
							+"<button id='plus_loc"+list.wh_area_cd+"' name='plus' onclick='loc_plus_button("+list.wh_area_cd +")' class='btn' type='button'>+</button>"
							+"창고 지역 :"+list.wh_area + "</td>"
							+"<td><button class='btn btn-secondary' id='check_button' onclick='tableDelte("+list.wh_area_cd+")'>삭제</button> </td>"
							+"<td><div></div></td>"
							+"<input type='hidden' value='"+list.wh_area_cd+"' id='hidden_value'> "
							+"</tr>"
							+"<tr id='tr"+list.wh_cd+"' class='hide"+list.wh_cd+"'>"
							+"<td>&nbsp;&nbsp;&nbsp;<input type='text' placeholder='선반 위치' class='loc_hide"+list.wh_area_cd+"' id='wh_area_loc"+list.wh_area_cd+"'>"
							+"<button onclick='loc_tableCreate("+list.wh_area_cd +")' class='loc_hide"+list.wh_area_cd+"'>추가</button> </td>"
							+"</tr>";
							$("#tr"+list.wh_cd).after(result);
						}
						$("[class^='hide']").hide()
					})
					.fail(function() {
						$("#tr").append("<h3>요청 실패!</h3>");
					});
					
					//---------------선반 위치 출력------------------
					$.ajax({
						type: "GET",
						url: "WareHouseLocInListJsonPro.wh",
						dataType: "json"
					})
					.done(function(wharealist) { // 요청 성공 시
						alert(wharealist);
						for(let list of wharealist) {
							let result ="<tr id='tr"+list.wh_loc_in_area_cd+"' class='loc_hide"+list.wh_area_cd+"'>"
							+"<td scope='col'>&nbsp;&nbsp;&nbsp;&nbsp; 선반 위치 :"+list.wh_loc_in_area+ "</td>"
							+"<td><button class='btn btn-secondary' id='check_button' onclick='loc_tableDelte("+list.wh_loc_in_area_cd+")'>삭제</button> </td>"
							+"<td><div></div></td>"
							+"<input type='hidden' value='"+list.wh_loc_in_area_cd+"' id='loc_hidden_value'> "
							+"</tr>";
							$("#tr"+list.wh_area_cd).after(result);
						}
						$("[class^='loc_hide']").hide();
					})
					.fail(function() {
						$("#tr").append("<h3>요청 실패!</h3>");
					});
					
					//------------숨기기--------
					
				
		});//제이쿼리 끝		
			
		
		//--------창고 지역 minus 버튼-----------
		function loc_minus_button(cd) {
				$("#minus_loc"+cd).click(function() {
					$(".loc_hide"+cd).hide();
				});
			}//창고 지역 minus 끝
		
		//--------창고 지역 plus 버튼-----------
		function loc_plus_button(cd) {
				$("#plus_loc"+cd).click(function() {
					$(".loc_hide"+cd).show();
			});
		}// 창고 지역 plus 버튼 끝
		
		//--------창고 지역 minus 버튼-----------
		function minus_button(cd) {
				$("#minus"+cd).click(function() {
					$(".loc_hide"+cd).hide();
					$(".hide"+cd).hide();
				});
			}//창고 지역 minus 끝
		
		//--------창고 지역 plus 버튼-----------
		function plus_button(cd) {
				$("#plus"+cd).click(function() {
					$(".loc_hide"+cd).show();
					$(".hide"+cd).show();
				});
		}// 창고 지역 plus 버튼 끝
			
		
		//--------상제 정보 출력-----------
		function info(wh_cd){
			alert("버튼 감지"+wh_cd);
			$.ajax({
				type: "GET",
				url: "WareHouseInfoJson.wh?wh_cd="+wh_cd,
				dataType: "json"
			})
			.done(function(vo) { // 요청 성공 시
				alert("정보 확인"+vo);
				$("#wh_cd").val(vo.wh_cd);
				$("#wh_name").val(vo.wh_name);
				$("#wh_location").val(vo.wh_location);
				$("#wh_addr").val(vo.wh_addr);
				$("#wh_addr_detail").val(vo.wh_addr_detail);
				$("#wh_tel1").val(vo.wh_tel1);
				$("#wh_tel2").val(vo.wh_tel2);
				$("#wh_tel3").val(vo.wh_tel3);
				$("#wh_man_name").val(vo.wh_man_name);
				$("#remarks").val(vo.remarks);
			})
			.fail(function() {
				alert("정보 실패");
			});
	}//상세 정보 끝
	
	
	<!-- 연락처 숫자만 입력되는 유효성 검사 -->
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
	}//연락처 숫자 유효성 검사 끝
	
	<!-- 이메일 영어만 -->
	function onlyEngNumber(str) {
		var regType1 = /^[A-Za-z0-9+]*$/; // regex : 영어, 숫자만 입력
		if (regType1.test(str.value)) { //영어, 숫자만 입력했을 때
		}else{//영어, 숫자를 제외한 값 입력 시
			str.value = ""; // ""으로 초기화
		}
	}//이메일 영어 끝
	
	
	//-----------창고 지역 입력---------
	function tableCreate(wh_cd){
		var no = Number($("#hidden_value").val()) + 1
		var tc = new Array();
		var html = '';
		let wh_area = $("#wh_area"+wh_cd).val();
		$.ajax({
			type: "GET",
			url: "WareHouseAreaInsertPro.wh",
			data:{
				wh_area : wh_area,
				wh_cd : wh_cd
			}
		})
		.done(function(vo) { // 요청 성공 시
			alert("입력 확인");
		})
		.fail(function() {
			alert("정보 실패");
		});
		html += '<tr id="tr'+no +'">';
		html += '<td>창고 지역:'+wh_area+'</td>';
		html += '"<td><button class="btn btn-secondary" onclick="tableDelte('+no+')">삭제</button></td>"';
		html += '</tr>';
		$("#tr"+wh_cd).after(html);
		}// 창고 지역 입력 끝
		
		//-----------창고 선반 입력---------
		function loc_tableCreate(wh_cd){
			var no = Number($("#loc_hidden_value").val()) + 1
			var tc = new Array();
			var html = '';
			let wh_area_loc = $("#wh_area_loc"+wh_cd).val();
			$.ajax({
				type: "GET",
				url: "WareHouseLocAreaInsertPro.wh",
				data:{
					wh_loc_in_area : wh_area_loc,
					wh_area_cd : wh_cd
				}
			})
			.done(function(vo) { // 요청 성공 시
				alert("입력 확인");
			})
			.fail(function() {
				alert("정보 실패");
			});
			html += '<tr id="tr'+no +'">';
			html += '<td scope="col">&nbsp;&nbsp;&nbsp;&nbsp; 선반 위치 :'+wh_area_loc+'</td>';
			html += '"<td><button class="btn btn-secondary" onclick="loc_tableDelte('+no+')">삭제</button></td>"';
			html += '</tr>';
			$("#tr"+wh_cd).after(html);
			}// 창고 지역 입력 끝
		
		//--------창고 지역 삭제 버튼-----------
		function tableDelte(code) {
			$.ajax({
				type: "GET",
				url: "WareHouseAreadeletePro.wh?wh_area_cd="+code
			})
			.done(function() { // 요청 성공 시
				$("#tr"+code).remove();
			})
			.fail(function() {
				alert("정보 실패");
			});
		}// 창고 지역 삭제 끝
		//--------창고 지역 삭제 버튼-----------
		function loc_tableDelte(code) {
			$.ajax({
				type: "GET",
				url: "WareHouseLocAreadeletePro.wh?wh_loc_in_area_cd="+code
			})
			.done(function() { // 요청 성공 시
				$("#tr"+code).remove();
			})
			.fail(function() {
				alert("정보 실패");
			});
		}// 창고 지역 삭제 끝
		
		
		
</script>
<!-- 카카오 주소 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("wh_addr").value = data.address; // 주소 넣기
                document.getElementById("emp_address_zonecode").value = data.zonecode; // 우편번호 넣기
                document.querySelector("input[id=emp_address_kakao2]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
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
   <div class="pagetitle">
     <h1>창고 관리</h1>
   </div><!-- End Page Title -->
	<div class="card mb-4">
		<div class="card-header">
            창고 상세정보 입력
        </div>
        
       <div class="card-body" style="padding: 50px 80px;">
              	<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">창고 번호</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="wh_cd" type="text" value="${vo.wh_cd }" class="form-control" id="wh_cd">
                      </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">창고 사용</label>
                      <div class="col-md-8 col-lg-2">
                        <select name="wh_use" required="required" class="form-select">
								<option value="1">사용</option>
								<option value="2">미사용</option>
						</select>
                      </div>
                    </div>
              	<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">위치</label>
                      <div class="col-md-8 col-lg-2">
		      			<div class="input-group mb-6">
		             		<input name="wh_location" type="text" class="form-control" id="wh_location" >
<!-- 				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_buyer">검색</button> -->
			        	 </div>
			          </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">관리자</label>
                      <div class="col-md-8 col-lg-2">
		      			<div class="input-group mb-6">
		             		<input name="wh_man_name" value="${wh.wh_man_name }" type="text" class="form-control" id="wh_man_name" >
<!-- 				         	<button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_emp">검색</button> -->
			        	 </div>
			          </div>
                    </div>
                
                <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">주소</label>
                      <div class="col-md-8 col-lg-2">
                        <div class="input-group mb-6">
                        	<input name="wh_addr" value="${wh.wh_addr }" id="wh_addr" type="text" class="form-control" id="wh_addr">
                      		<button id="address_kakao" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_buyer">검색</button>
                      	</div>
                      </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">비고</label>
                      <div class="col-md-8 col-lg-2">
                        <div class="input-group mb-6">
                        	<input name="HIRE_DATE" value="${wh.remarks }" type="text" class="form-control" id="remarks">
                      	</div>
                      </div>
                    </div>
                <div class="row mb-3">
                	<label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">상세 주소</label>
	                <div class="col-md-8 col-lg-2">	
	                      	<div class="input-group mb-6">
	                      		<input name="wh_addr_detail" value="${wh.wh_addr_detail }" id="wh_addr_detail" type="text" class="form-control" id="Twitter">
	               			</div>
	               	</div>
               		<label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">전화 번호 </label>
	                <div class="col-md-8 col-lg-3">	
       	                  <div class="input-group mb-6">
  	                    	<input type="text" class="form-control" value="${wh.wh_tel1 }"id="wh_tel1" name="wh_tel1" onkeyup="inputOnlyNumberFormat(this)" maxlength="3" required>
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" value="${wh.wh_tel2 }" id="wh_tel2" name="wh_tel2" onkeyup="inputOnlyNumberFormat(this)" maxlength="3" required>
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" value="${wh.wh_tel3 }" id="wh_tel3" name="wh_tel13" onkeyup="inputOnlyNumberFormat(this)" maxlength="4" required>
     					   </div>                 
	               	</div>
               </div>
               <form action="WareHouseAreaInsertPro.wh" method="post">
<!--                <input type="hidden" value="6" name="wh_cd"> -->
<!--                <div id="area_div" class="row mb-3"> -->
<!--                 	<label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">창고 지역</label> -->
<!-- 	                <div class="col-md-8 col-lg-2">	 -->
<!-- 	                      	<div class="input-group mb-6">	 -->
<!-- 	                      		<input name="wh_area" id="wh_area" type="text" class="form-control"> -->
<!-- 	               				<button id="plus" class="btn btn-secondary" type="button">+</button>	 -->
<!-- 	               				<button id="minus_button" class="btn btn-secondary" type="button">-</button>	 -->
<!-- 	               			</div> -->
<!-- 	               		</div> -->
<!-- 	              	</div> -->
<!-- 				<div class="text-right" style="float: right; padding-top: 50px"> -->
<!--                   <button type="submit" class="btn btn-primary" id="register">등록</button> -->
<!--                   <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button> -->
<!--                 </div> -->
				</form>
			</div> <!-- card-body -->
			
		
			
			
			
			
			 <!-- Modal Dialog Scrollable -->
			 <!-- 거래처 검색 -->
              <div class="modal fade" id="modalDialogScrollable_buyer" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">위치 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="search_buyer" class="btn btn-secondary" type="button">검색</button>
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
                      <button type="button"  class="btn btn-primary">Save changes</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
			
			
		</div> <!-- card mb-4 -->
		
		<div class="card mb-4">
        	
     	  <div class="card-body">
       			
       			<table id="table" class="table table-hover">
		                <thead>
		                  <tr>
                               <th scope="col">창고명</th>
                               <th scope="col">관리자명</th>
                               <th scope="col">상세 정보</th>
		                  </tr>
		                </thead>
		                <tbody>
		                </tbody>
		              </table>
		             
					  
		              <!-- End Table with hoverable rows -->
       </div>
       </div>
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>