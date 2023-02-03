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

	$(function() {
		
	
		
		
	
		//업태, 종목 항목 input 태그 추가
		$("#plus_uptae").on("click", function() {
			
			var addInput = '<div class="col-md-3">'
            				+ '<input type="text" class="form-control" name="uptae">'
            				+ '</div>';
			
// 			var addInput = '<input type="text" class="form-control" name="uptae">&nbsp';
// 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_uptae]:last");
			trHtml.before(addInput);
		});
		
		
		$("#plus_jongmok").on("click", function() {
			
			var addInput = '<div class="col-md-3">'
							+ '<input type="text" class="form-control" name="jongmok">'
							+ '</div>';
			
// 			var addInput = '<input type="text" class="form-control" name="jongmok">&nbsp';
// 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_jongmok]:last");
			trHtml.before(addInput);
		});
		
		
// 	function checkCode() {
	$("#business_no").keyup(function() {
		let business_no = $('#business_no').val();
		
		 $.ajax({
	            url:'CodeCheck', //Controller에서 요청 받을 주소
	            type:'post', //POST 방식으로 전달
	            data:{business_no:business_no},
	            success:function(result){ //컨트롤러에서 넘어온 cnt값을 받는다 
	                if(result == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 코드 
// 	                	alert("사용 가능한 코드입니다.");
						$("#checkCdResult").html("사용 가능한 코드입니다.");
						$("#checkCdResult").css("color", "#3CAEFF");
	                	codeStatus = true;
	                } else { // cnt가 1일 경우 -> 이미 존재하는 코드
// 	                    alert("이미 존재하는 코드입니다.");
	                	$("#checkCdResult").html("사용 불가능한 코드입니다.");
						$("#checkCdResult").css("color", "#B9062F");
	                    codeStatus = false;
	                }
	            },
	            error:function(){
	                alert("중복 체크 실패!");
	                codeStatus = false;
	            }
	        });
	});
});	
	
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
	}
	
	<!-- 이메일 영어만 -->
	function onlyEngNumber(str) {
		var regType1 = /^[A-Za-z0-9+]*$/; // regex : 영어, 숫자만 입력
		if (regType1.test(str.value)) { //영어, 숫자만 입력했을 때
		}else{//영어, 숫자를 제외한 값 입력 시
			str.value = ""; // ""으로 초기화
		}
	}//onlyEngNumber 끝
	
	// 등록 작업 막기
	function fn_registerBuyer(){
		if(business_no.length == 0){
			alert("거래처 코드를 입력해주세요");
			event.preventDefault();
		} 
		
		if(codeStatus == false){
			alert("거래처 코드를 확인해주세요");
			event.preventDefault();
		}
	}
	
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
                document.getElementById("emp_address_kakao").value = data.address; // 주소 넣기
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
     <h1>출고 관리</h1>
   </div><!-- End Page Title -->
    
	<div class="card mb-4">
		<div class="card-header">
            출고 입력
        </div>
        
       <div class="card-body" style="padding: 50px 80px;">
<!--             <form action="OutRegisterPro" method="post"> -->
              
              
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
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="" class="btn btn-secondary" type="button">검색</button>
			        	 </div>
			          </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">담당자</label>
                      <div class="col-md-8 col-lg-2">
		      			<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="" class="btn btn-secondary" type="button">검색</button>
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
<!--            </form>   -->
       			<div class="text-right" style="float: right; padding-top: 50px">
                  <button type="submit" class="btn btn-primary" onclick="fn_registerBuyer()">등록</button>
                  <button type="reset" class="btn btn-secondary">다시쓰기</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
       </div>
       
       </div>
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>