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
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_res = str.charAt(0); // 기본등록(0) 여부 판별할 값
	var priv_cd_pro = str.charAt(3); // 재고조회(3) 여부 판별할 값
	var priv_cd_pro2 = str.charAt(4); // 재고관리(4) 여부 판별할 값
	
	//기본등록에 대한 권한이 있는 지 판별
	if(priv_cd_res == '1' || priv_cd_pro == '1' || priv_cd_pro2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("권한이 없습니다");
		history.back();
	}
</script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>거래처 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
	
	var codeStatus = false;

	$(function() {
		
	// 대표 이메일
		$("#domain").on("change", function() {
			$("#email2").val($(this).val());

			if ($(this).val() == "") {
				$("#email2").prop("readonly", false);
				$("#email2").css("background-color", "white");
				$("#email2").focus();
			} else {
				$("#email2").prop("readonly", true);
				$("#email2").css("background-color", "lightgray");
			}
		});
		
		// 담당자 이메일
		$("#domain_man").on("change", function() {
			$("#email2_man").val($(this).val());

			if ($(this).val() == "") {
				$("#email2_man").prop("readonly", false);
				$("#email2_man").css("background-color", "white");
				$("#email2_man").focus();
			} else {
				$("#email2_man").prop("readonly", true);
				$("#email2_man").css("background-color", "lightgray");
			}
		});

	
		//업태, 종목 항목 input 태그 추가
// 		$("#plus_uptae").on("click", function() {
			
// 			var addInput = '<div class="col-md-3">'
//             				+ '<input type="text" class="form-control" name="uptae">'
//             				+ '</div>';
			
// // 			var addInput = '<input type="text" class="form-control" name="uptae">&nbsp';
// // 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
// 			var trHtml = $("[name=orgInput_uptae]:last");
// 			trHtml.before(addInput);
// 		});
		
		$("#plus_uptae").on("click", function() {
			
			$("#orgInput_uptae").append(
					 '<div class="input-group mb-1"><div class="col-md-3">'
    				+ '<input type="text" class="form-control" name="uptae"></div>'
    				+ '<button name="remove_uptae" class="btn btn-secondary" type="button">-</button>'
    				+ '</div>');
		});
		
		$(document).on("click", "button[name=remove_uptae]", function(e){
// 			$(this).parent('div').remove();
			$(this).prev().remove();
			$(this).remove();
		});
		
		$("#plus_jongmok").on("click", function() {
			
			$("#orgInput_jongmok").append(
					 '<div class="input-group mb-1"><div class="col-md-3">'
   				+ '<input type="text" class="form-control" name="jongmok"></div>'
   				+ '<button name="remove_jongmok" class="btn btn-secondary" type="button">-</button>'
   				+ '</div>');
		});
		
		$(document).on("click", "button[name=remove_jongmok]", function(e){
// 			$(this).parent('div').remove();
			$(this).prev().remove();
			$(this).remove();
		});
// 	function checkCode() {
	$("#business_no").change(function() {
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
     <h1>거래처</h1>
   </div><!-- End Page Title -->
    
	<div class="card mb-4">
		<div class="card-header">
            거래처 등록
        </div>
        
       <div class="card-body">
         <!-- Floating Labels Form -->
            <form action="BuyerRegisterPro" method="post">
              
              <!-- 사용 여부 --> 
              <div class="row mb-3">
                <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">사용 여부</label>
                <div class="col-md-3 col-lg-2">
                  <select class="form-select" name="by_use" >
					<option value="1">사용</option>
					<option value="2">비사용</option>
		           </select>
                </div>
              </div>

			<div class="row mb-3">
              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">거래처 코드 (*)</label>
              <div class="col-md-6 col-lg-2">
<!--                 <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button> -->
                <input type="text" class="form-control" name="business_no" id="business_no" required onkeyup="inputOnlyNumberFormat(this)">
                <span id="checkCdResult"></span>
              </div>
            </div>	
            
            <div class="row mb-3">
	              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label"></label>
	            <div class="col-md-6 col-lg-6">
                     <input class="form-check-input" type="radio" name="g_gubun"  value="01" checked>
                       &nbsp;01 사업자등록번호&nbsp;
                     <input class="form-check-input" type="radio" name="g_gubun"  value="02">
                       &nbsp;02 해외사업자등록번호&nbsp;
                     <input class="form-check-input" type="radio" name="g_gubun"  value="03">
                       &nbsp;03 주민등록번호&nbsp;
                     <input class="form-check-input" type="radio" name="g_gubun" value="04">
                       &nbsp;04 외국인&nbsp;
               </div>    
             </div>   
             
             <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">상호 (*)</label>
              <div class="col-md-6 col-lg-2">
                <input type="text" class="form-control" name="cust_name" required="required">
              </div>
            </div>	
            
            <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">업태</label>
              <div class="col-md-6 col-lg-6">
              <div class="input-group mb-1">
               <div class="col-md-3" >
                    <input type="text" class="form-control" name="uptae">
               </div>
              	<button id="plus_uptae" class="btn btn-secondary" type="button">+</button>
              	</div>
              <div class="col-md-6 col-lg-12" id="orgInput_uptae">
              </div>
              </div>
            </div> 
            
            <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">종목</label>
              <div class="col-md-6 col-lg-6">
              <div class="input-group mb-1">
               <div class="col-md-3" >
                    <input type="text" class="form-control" name="jongmok">
               </div>
              	<button id="plus_jongmok" class="btn btn-secondary" type="button">+</button>
              	</div>
              	<div class="col-md-6 col-lg-12" id="orgInput_jongmok">
              </div>
              </div>
            </div> 
            
          <div style="padding-top: 40px;"></div>  
            
          <div class="row mb-3">
           <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">우편번호</label>
           	<div class="col-md-8 col-lg-2">
      			<div class="input-group mb-6">
             		<input name="post_no" type="text" class="form-control" id="emp_address_zonecode" >
		         <button id="address_kakao" class="btn btn-secondary" type="button">검색</button>
	        	 </div>
	          </div>
         </div>   
            
         <div class="row mb-3">
           <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">주소</label>
           <div class="col-md-8 col-lg-5">
           	<div class="input-group mb-6">
             <input name="addr" type="text" class="form-control" id="emp_address_kakao" >
             <input name="addr" type="text" class="form-control" id="emp_address_kakao2" placeholder="상세주소">
             </div>
           </div>
         </div>   
                    
            <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">대표자명</label>
              <div class="col-md-6 col-lg-3">
                <input type="text" class="form-control" name="boss_name">
              </div>
            </div>	
                
           <div class="row mb-3">
                <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">대표 전화번호</label>
                 <div class="col-md-8 col-lg-3">
 	                  <div class="input-group mb-6">
                 	<input type="text" class="form-control" name="tel" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">
                		<span class="input-group-text">-</span>
                		<input type="text" class="form-control" name="tel" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
                		<span class="input-group-text">-</span>
                		<input type="text" class="form-control" name="tel" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
				   </div>                 
				</div>
          </div> 
              
            <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">대표 이메일</label>
                		  <div class="col-md-8 col-lg-5">
		                	<div class="input-group mb-5">
		                      <input type="text" class="form-control" id="email1" name="email" onkeyup="onlyEngNumber(this)">
		                      <span class="input-group-text">@</span>
		                      <input type="text" class="form-control" id="email2" name="email">
		                      	<select class="form-select" name="selectDomain" id="domain" >
			                      	<option value="">직접 입력</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="daum.net">daum.net</option>
									<option value="nate.com">nate.com</option>
		                   		 </select>
		                    </div>
	                    </div>
                    </div>  
              
<!--              <div style="padding-top: 40px;"></div> -->
            
            <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">담당자명</label>
              <div class="col-md-6 col-lg-3">
                <input type="text" class="form-control" name="man_name">
              </div>
            </div>	
                
                
           <div class="row mb-3">
                <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">담당자 전화번호</label>
                 <div class="col-md-8 col-lg-3">
 	                  <div class="input-group mb-6">
                 	<input type="text" class="form-control" name="man_tel" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">
                		<span class="input-group-text">-</span>
                		<input type="text" class="form-control" name="man_tel" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
                		<span class="input-group-text">-</span>
                		<input type="text" class="form-control" name="man_tel" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
				   </div>                 
				</div>
          </div> 
              
            <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">담당자 이메일</label>
                		  <div class="col-md-8 col-lg-5">
		                	<div class="input-group mb-5">
		                      <input type="text" class="form-control" id="email1_man" name="man_email" onkeyup="onlyEngNumber(this)">
		                      <span class="input-group-text">@</span>
		                      <input type="text" class="form-control" id="email2_man" name="man_email" >
		                      	<select class="form-select" name="selectDomain" id="domain_man" >
			                      	<option value="">직접 입력</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="daum.net">daum.net</option>
									<option value="nate.com">nate.com</option>
		                   		 </select>
		                    </div>
	                    </div>
                    </div>
              
              

                    
               
              <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">팩스</label>
              <div class="col-md-6 col-lg-3">
                <input type="text" class="form-control" name="fax" onkeyup="inputOnlyNumberFormat(this)">
              </div>
            </div>	
            
            <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">홈페이지</label>
              <div class="col-md-6 col-lg-3">
                <input type="text" class="form-control" name="man_home">
              </div>
            </div>	 
                    
                
                <div class="row mb-3">
              		<label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">적요</label>
              		<div class="col-md-6 col-lg-6">
                    <textarea class="form-control" style="height: 100px;" name="remarks"></textarea>
                    </div>
                  </div>
                
                
                <div class="text-right" style="float: right;">
                  <button type="submit" class="btn btn-primary" onclick="fn_registerBuyer()">등록</button>
                  <button type="reset" class="btn btn-secondary">다시쓰기</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
                
              </form><!-- End floating Labels Form -->      
			</div>
		</div>
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>