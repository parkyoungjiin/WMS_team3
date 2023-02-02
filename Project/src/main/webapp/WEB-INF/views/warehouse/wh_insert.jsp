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
<!-- 권한 여부 판별하여 인사부서인지 판별 -->
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_emp = str.charAt(0); // 창고조회(0) 여부 판별할 값
	var priv_cd_emp2 = str.charAt(3); // 창고관리(2) 여부 판별할 값
	var priv_cd_emp3 = str.charAt(4); // 재고관리(4) 여부 판별할 값
	
	//사원조회, 사원관리에 대한 권한이 있는 지 판별
	if(priv_cd_emp == '1' || priv_cd_emp2 == '1' || priv_cd_emp3 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("창고등록 권한이 없습니다");
		history.back();
	}
	$(function() {
		$("input:radio[name='wh_location']").change(function() {
			var location = $("input:radio[name='wh_location']:checked").val();
			alert(location);
				if(location == '내부'){
					$("#address").hide();
				}else if(location == '외부'){
					$("#address").show();
				}
		});// 내부,외부처리 
//코드 중복 확인 처리
$("#wh_cd_button").click(function() {
		let wh_cd = $("#wh_cd").val();
		$.ajax({
			type: "get",
			url: "WhCodeCheck.wh?wh_cd="+wh_cd,
			data: wh_cd,
			dataType: "html",
			success: function(data){
				if(data == 0){
					alert("사용 가능한 코드입니다.");
					$("#fr").attr("onsubmit","return true");
// 					codeStatus = true;
				}else if(data == 1){
					alert("사용 불가능한 코드입니다.");
					$("#wh_cd").val('');
					$("#wh_cd").focus();
					$("#fr").attr("onsubmit","return false");				
// 					codeStatus = false;
				}
			}
		}).fail(function(result) {
			alert("중복아님");
		});
	});// 코드 중복 확인 끝	
// 	//등록 작업 막기
// 	function fn_registerBuyer(){
// 		if(codeStatus == false){
// 			alert("창고 코드를 확인해주세요");
// 			event.preventDefault();
// 	}
// }
});//제이쿼리 끝
</script>
<!-- 연락처 숫자만 입력되는 유효성 검사 -->
<script type="text/javascript">
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

window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("wh_addr").value = data.address; // 주소 넣기
                document.getElementById("post_no").value = data.zonecode; // 우편번호 넣기
                document.querySelector("input[id=wh_addr_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
	
</script>
<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("wh_addr").value = data.address; // 주소 넣기
                document.getElementById("post_no").value = data.zonecode; // 우편번호 넣기
                document.querySelector("input[id=wh_addr_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
</head>
<body>
	<header>
		<!-- top-->
		<jsp:include page="../inc/top.jsp" />
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
  <main id ="main" class="main">
   <div class="pagetitle">
     <h1>창고 관리</h1>
   </div>
	<form action="WareHouseInserPro.wh" method="post">
	<div class="card-header">
            창고 등록
            <select style="float: right;" name="wh_use">
            	<option value="1">사용</option>
            	<option value="2">미사용</option>
            </select>
        </div>
			<div></div>
		<div class="card mb-4">
		<!-- Profile Edit Form -->
		       <div class="card-body">
			
                  <form action="EmpInsertPro.em" method="post" enctype="multipart/form-data" id="emp">
                   <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">창고 코드</label>
                      <div class="col-md-8 col-lg-2">
	                	<div class="input-group mb-6">
                        <input name="wh_cd" type="text" class="form-control" id="emp_address_zonecode" required>
	                    <button id="wh_cd_button" class="btn btn-secondary" type="button">조회</button>
	                    </div>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">창고명</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="wh_name" type="text" class="form-control" id="fullName" required>
                      </div>
                    </div>
					 
					 <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">구분</label>
                       <div class="col-md-8 col-lg-5">
		                	<div class="input-group mb-6">
		                        <label class="form-check-label" style="margin-right: 30px">
		                        	<input type="radio" class="form-check-input" id="priv_cd1" name="wh_gubun" value="창고" style="margin-right: 10px" checked>
		                        	창고
		                        </label>
								<label class="form-check-label" style="margin-right: 30px">
									<input type="radio" class="form-check-input" id="priv_cd2" name="wh_gubun" value="공장" style="margin-right: 10px">
									공장
								</label>
		                    </div>
	                    </div>
                    </div>
					
					
					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">위치</label>
                       <div class="col-md-8 col-lg-5">
		                	<div class="input-group mb-6">
		                        <label class="form-check-label" style="margin-right: 30px">
		                        	<input type="radio" class="form-check-input" id="priv_cd1" name="wh_location" value="외부" style="margin-right: 10px" checked="checked">
		                        	외부
		                        </label>
								<label class="form-check-label" style="margin-right: 30px">
									<input type="radio" class="form-check-input" id="priv_cd2" name="wh_location" value="내부" style="margin-right: 10px">
									내부
								</label>
		                    </div>
	                    </div>
                    </div>
					
					<div id="address">
					<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">우편번호</label>
                      <div class="col-md-8 col-lg-2">
	                	<div class="input-group mb-6">
                        <input name="post_no" type="text" class="form-control" id="post_no">
	                    <button id="address_kakao" class="btn btn-secondary" type="button">우편번호 찾기</button>
	                    </div>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">주소</label>
                      <div class="col-md-8 col-lg-3">
                        <input name="wh_addr" type="text" class="form-control" id="wh_addr">
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">상세주소</label>
                      <div class="col-md-8 col-lg-3">
                        <input name="wh_addr_detail" type="text" class="form-control" id="wh_addr_detail">
                      </div>
                    </div>
				</div>
                   
                   
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">관리자</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="wh_man_name" type="text" class="form-control" id="wh_man_name" required>
                      </div>
                    </div>
                   
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">연락처</label>
   	                    <div class="col-md-8 col-lg-3">
       	                  <div class="input-group mb-6">
  	                    	<input type="text" class="form-control" name="wh_tel1" onkeyup="inputOnlyNumberFormat(this)" maxlength="3" required>
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="wh_tel2" onkeyup="inputOnlyNumberFormat(this)" maxlength="3" required>
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="wh_tel13" onkeyup="inputOnlyNumberFormat(this)" maxlength="4" required>
     					   </div>                 
     					</div>
                    </div>
					
					<div></div>
                    <div class="text-left">
                      <button type="submit" class="btn btn-primary">창고 등록</button>
                    </div>
                </div>
		</div>
		</form><!-- End Profile Edit Form -->
</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>