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
		$("#plus_uptae").on("click", function() {
			
			var addInput = '<div class="col-md-2">'
							+ '<div class="form-floating">'
            				+ '<input type="text" class="form-control" name="uptae" placeholder="업태">'
            				+ '</div></div>';
			
// 			var addInput = '<input type="text" class="form-control" name="uptae">&nbsp';
// 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_uptae]:last");
			trHtml.before(addInput);
		});
		
		$("#plus_jongmok").on("click", function() {
			
			var addInput = '<div class="col-md-2">'
							+ '<div class="form-floating">'
							+ '<input type="text" class="form-control" name="jongmok" placeholder="종목">'
							+ '</div></div>';
			
// 			var addInput = '<input type="text" class="form-control" name="jongmok">&nbsp';
// 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_jongmok]:last");
			trHtml.before(addInput);
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
            거래처 수정
        </div>
        
       <div class="card-body">
         <!-- Floating Labels Form -->
      <form action="BuyerModifyPro" method="post" class="row g-3">
            
        <!-- 사용 여부 --> 
         <div class="col-lg-12"> 
           <div class="col-md-1">
	            <select class="form-select" name="by_use" >
					<option value="1" <c:if test="${buyer.by_use eq'1'}"> selected="selected" </c:if>>사용</option>
					<option value="2" <c:if test="${buyer.by_use eq'2'}"> selected="selected" </c:if>>비사용</option>
	            </select>
            </div> 
          </div>
          
              <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="business_no" id="business_no" value="${buyer.business_no }" readonly placeholder="거래처코드">
                    <label for="floatingName">거래처코드</label>
                  	</div>
<!--                     <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button> -->
                  </div>
                </div>
               </div> 
                
<!--                 <div class="col-md-3"> -->
<!--                     <button type="button" class="btn btn-primary" onclick="checkCode()">fn</button> -->
<!--                 </div> -->
                
               <div class="col-lg-6">  
                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="cust_name" value="${buyer.cust_name }" placeholder="상호">
                    <label for="floatingName">상호</label>
                  </div>
                </div>
               </div>
                
                <fieldset class="row mb-6">
                  <div class="col-sm-10">
                      <input class="form-check-input" type="radio" name="g_gubun"  value="01" <c:if test="${buyer.g_gubun eq'01'}"> checked="checked"</c:if>>
                        &nbsp;01 사업자등록번호&nbsp;
                      <input class="form-check-input" type="radio" name="g_gubun"  value="02" <c:if test="${buyer.g_gubun eq'02'}"> checked="checked"</c:if>>
                        &nbsp;02 해외사업자등록번호&nbsp;
                      <input class="form-check-input" type="radio" name="g_gubun"  value="03" <c:if test="${buyer.g_gubun eq'03'}"> checked="checked"</c:if>>
                        &nbsp;03 주민등록번호&nbsp;
                      <input class="form-check-input" type="radio" name="g_gubun" value="04" <c:if test="${buyer.g_gubun eq'04'}"> checked="checked"</c:if>>
                        &nbsp;04 외국인&nbsp;
                  </div>
                </fieldset>
                
               
                
                 <div></div>
                 <div class="col-md-4">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="uptae" placeholder="업태" value="${buyer.uptae }">
                    <label>업태</label>
                  </div>
                </div>
                  <div class="col-md-2" name="orgInput_uptae" >
                  <div class="form-floating">
                	<button id="plus_uptae" class="btn btn-secondary" type="button">+</button>
                  </div>
                 </div>
                
                
                <div></div>
                 <div class="col-md-4">
                  <div class="form-floating">
                    <input type="text" name="jongmok" class="form-control" value="${buyer.jongmok }">
                    <label>종목</label>
                  </div>
                </div>
                 <div class="col-md-2" name="orgInput_jongmok" >
                  <div class="form-floating">
                	<button id="plus_jongmok" class="btn btn-secondary" type="button">+</button>
                  </div>
                 </div>
                
                
                <div></div>
              <div class="col-lg-3">  
                <div></div>
                  <label class="form-label">대표자명</label>
                 	<div class="col-md-10">
                  <div class="input-group mb-3">
                      <input type="text" class="form-control" name="boss_name" value="${buyer.boss_name }">
                    </div>
                </div>
              </div>
              
              <div class="col-lg-3">  
                <div></div>
                  <label class="form-label">대표 전화번호</label>
                 	<div class="col-md-11">
                  <div class="input-group mb-6">
                      <input type="text" class="form-control" name="tel" value="${buyer.telArr[0]}" onkeyup="inputOnlyNumberFormat(this)">
                      <span class="input-group-text">-</span>
                      <input type="text" class="form-control" name="tel" value="${buyer.telArr[1]}" onkeyup="inputOnlyNumberFormat(this)">
                      <span class="input-group-text">-</span>
                      <input type="text" class="form-control" name="tel" value="${buyer.telArr[2]}" onkeyup="inputOnlyNumberFormat(this)">
                    </div>
                </div>
              </div>
              
              <div class="col-lg-6">  
                <div></div>
                 <label class="form-label">대표 이메일</label>
                  <div class="col-md-12">
                	<div class="input-group mb-3">
                      <input type="text" class="form-control" id="email1" name="email" value="${buyer.emailArr[0]}" onkeyup="onlyEngNumber(this)">
                      <span class="input-group-text">@</span>
                      <input type="text" class="form-control" id="email2" name="email" value="${buyer.emailArr[1]}">
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
              
              
                <div></div>
              <div class="col-lg-3">  
                <div></div>
                  <label class="form-label">담당자명</label>
                 	<div class="col-md-10">
                  <div class="input-group mb-3">
                      <input type="text" class="form-control" name="man_name" value="${buyer.man_name }">
                    </div>
                </div>
              </div>
              
              <div class="col-lg-3">  
                <div></div>
                  <label class="form-label">담당자 전화번호</label>
                 	<div class="col-md-11">
                  <div class="input-group mb-6">
                      <input type="text" class="form-control" name="man_tel" value="${buyer.man_telArr[0]}" onkeyup="inputOnlyNumberFormat(this)">
                      <span class="input-group-text">-</span>
                      <input type="text" class="form-control" name="man_tel" value="${buyer.man_telArr[1]}" onkeyup="inputOnlyNumberFormat(this)">
                      <span class="input-group-text">-</span>
                      <input type="text" class="form-control" name="man_tel" value="${buyer.man_telArr[2]}" onkeyup="inputOnlyNumberFormat(this)">
                    </div>
                </div>
              </div>
              
              <div class="col-lg-6">  
                <div></div>
                 <label class="form-label">담당자 이메일</label>
                  <div class="col-md-12">
                	<div class="input-group mb-3">
                      <input type="text" class="form-control" id="email1_man" name="man_email" value="${buyer.man_emailArr[0]}" onkeyup="onlyEngNumber(this)">
                      <span class="input-group-text">@</span>
                      <input type="text" class="form-control" id="email2_man" name="man_email" value="${buyer.man_emailArr[1]}">
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
              
                <div class="col-lg-12">  
                <div></div>
                 <label class="form-label">주소</label>
                  <div class="col-md-12">
                	<div class="input-group mb-1">
                      <div class="form-floating">
		                    <input type="text" class="form-control" name="post_no" id="emp_address_zonecode"  placeholder="거래처코드" value="${buyer.post_no}">
		                    <label for="floatingName">우편번호</label>
                  	  </div>
                      <button id="address_kakao" class="btn btn-secondary" type="button">검색</button>
                      <input type="text" class="form-control" name="addr" id="emp_address_kakao" value="${buyer.addrArr[0]}">
	                    <div class="form-floating">
	                    <input type="text" class="form-control" name="addr" id="emp_address_kakao2" placeholder="거래처코드" value="${buyer.addrArr[1]}">
	                    <label for="floatingName">상세주소</label>
	                   </div>
                    </div>
                   </div>
              </div>  
              
              <div class="col-lg-6">  
                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="fax" value="${buyer.fax }" placeholder="팩스" onkeyup="inputOnlyNumberFormat(this)">
                    <label for="floatingName">팩스</label>
                  </div>
                </div>
               </div> 
               
               <div class="col-lg-6">  
                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="man_home" value="${buyer.man_home }" placeholder="홈페이지">
                    <label for="floatingName">홈페이지</label>
                  </div>
                </div>
               </div> 
               
                
                <div class="col-12">
                  <div class="form-floating">
                    <textarea class="form-control" placeholder="적요" id="floatingTextarea" style="height: 100px;" name="remarks">${buyer.remarks }</textarea>
                    <label for="floatingTextarea">적요</label>
                  </div>
                </div>
                
                <div class="text-left">
                  <button type="submit" class="btn btn-primary" >수정</button>
                  <button type="reset" class="btn btn-secondary">다시쓰기</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
                
              </form><!-- End floating Labels Form -->      
			</div>
		</div>
	</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>