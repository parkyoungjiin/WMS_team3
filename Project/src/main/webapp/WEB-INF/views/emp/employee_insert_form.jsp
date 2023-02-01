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
<!-- css -->
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<!-- js -->
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<meta charset="UTF-8">

<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
<!-- 이미지 섬네일 -->
<script>
	function changeImage(event) {
		var reader = new FileReader();

        reader.onload = function(event) {
          var img = document.createElement("img");
          img.setAttribute("src", event.target.result);
          document.querySelector("div#image_container").appendChild(img);
        };

        reader.readAsDataURL(event.target.files[0]);
}// changeImage 끝
</script>

<!-- 이메일 클릭 시 자동입력 -->
<script type="text/javascript">

</script>
<!-- 권한 체크 : 1 / 권한 미체크 : 0 -->
<script type="text/javascript">
$(document).ready(function(){
	 $('input:checkbox[name="PRIV_CD"]').change(function(){
		if(document.getElementById("priv_cd1").checked) {
			$('#priv_cd1_hidden').prop('disabled', true);
		}
		if(document.getElementById("priv_cd2").checked){
			$('#priv_cd2_hidden').prop('disabled', true);
		}
		if(document.getElementById("priv_cd3").checked){
			$('#priv_cd3_hidden').prop('disabled', true);
		}
		if(document.getElementById("priv_cd4").checked){
			$('#priv_cd4_hidden').prop('disabled', true);
		}
		if(document.getElementById("priv_cd5").checked){
			$('#priv_cd5_hidden').prop('disabled', true);
		}
	 })
});

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
	
	
</script>

<script type="text/javascript">
	//이메일 중복 체크 여부 변수
	var emailStatus =false; 
	
	//===========이메일 입력 시 영어, 숫자만 입력 가능===============
	function onlyEngNumber(str) {
		var regType1 = /^[A-Za-z0-9+]*$/; // regex : 영어, 숫자만 입력
		if (regType1.test(str.value)) { //영어, 숫자만 입력했을 때
		}else{//영어, 숫자를 제외한 값 입력 시
			str.value = ""; // ""으로 초기화
		}
	}//onlyEngNumber 끝
	
	
	//==========이메일 도메인 선택 시 자동입력============
	
$(function() {
	$("#domain").on("change", function() {
		$("#email2").val($(this).val());
		
		if($(this).val() == "") {
			$("#email2").prop("readonly", false);
			$("#email2").css("background-color", "white");
			$("#email2").focus();
		} else {
			$("#email2").prop("readonly", true);
			$("#email2").css("background-color", "lightgray");
		}
	})//change
});//function
	//==========이메일 중복체크 ajax==========
	function checkEmail() {
	
			//이메일 결합
			var email1 = $("#email1").val();
			var email2 = $("#email2").val();
			var check_email = email1 + "@" + email2;
			
// 			alert(check_email);
			$.ajax({
				url: "EmpEmailCheck.em",
				type: "post",
				data: {
					check_email : check_email
					},
				success: function(data) {
					if(data > 0){
						$("#checkResultArea").html("이메일 사용 불가능").css("color", "red");
						emailStatus = false;
						$("#email1").focus();
					}else{
						$("#checkResultArea").html("이메일 사용 가능").css("color", "blue");
						emailStatus = true;
						$("#emp_address_zonecode").focus();
						
					}
				}//success
				
				
			});//ajax 끝
		};//checkEmail 끝
	//==========이메일 사용 불가능일 경우 폼 전송 X	=============
	function fn_insertMember() {
		var insertForm = document.emp;
		
		if(emailStatus == false){
			alert("중복확인 필수")
			event.preventDefault(); // submit 기능 막기
		}
		
	}//fn_insertMember 끝
</script>

<title>사원 등록</title>
</head>
<body>
	<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<form action="EmpInsertPro.em" method="post" enctype="multipart/form-data" id="emp">
		<table>
			<tr>
				<th>사원명</th>
				<td>
				<input type="text" name="EMP_NAME" required="required">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
				<input type="password" name="EMP_PASSWD" required="required">
				</td>
			</tr>
			<tr>
				<th>부서명</th>
				<td>
					<select name ="DEPT_CD" required="required">
						<option value="">===부서 선택===</option>
						<option value="A1">자재팀</option>
						<option value="A2">구매관리팀</option>
						<option value="A3">창고관리팀</option>
						<option value="A4">인사팀</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>직급명</th>
				<td>
				<select name ="GRADE_CD" required="required">
					<option value="">===직급 선택===</option>
					<option value="B1">사원</option>
					<option value="B2">대리</option>
					<option value="B3">과장</option>
					<option value="B4">부장</option>
					<option value="B5">이사</option>
					<option value="B6">대표</option>
				</select>
				</td>
			</tr>
			<tr>
				<th>연락처(개인)</th>
				<td>
					<input type="text" size="1" value="010" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="3"> -
					<input type="text" size="1" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="4" required="required"> -
					<input type="text" size="1" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="4" required="required">
				</td>
			</tr>
			<tr>
				<th>연락처(사무실)</th>
				<td>
					<input type="text" size="1" value="051" name="EMP_DTEL" required="required" onkeyup="inputOnlyNumberFormat(this)" maxlength="3"> -
					<input type="text" size="1" name="EMP_DTEL" required="required" onkeyup="inputOnlyNumberFormat(this)" maxlength="3"> -
					<input type="text" size="1" name="EMP_DTEL" required="required" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td id ="checkArea">
					<input type="text" size="5" id="email1" name="EMP_EMAIL" onkeyup="onlyEngNumber(this)" required="required"> @
					<input type="text" size="5" id="email2" name="EMP_EMAIL"  required="required">
					<select name="selectDomain" id="domain"  style="padding: .4em .5em; ">
						<option value="">직접입력</option>	
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
						</select> &nbsp;
					<button onclick="checkEmail();">이메일 중복 확인</button>
					<div id ="checkResultArea"></div>
				</td>
				<td></td>
					
			</tr>
			<tr>
				<th>우편번호</th>
				<td>
				<input type="text" name="EMP_POST_NO" id="emp_address_zonecode" required > &nbsp;
				<button id="address_kakao">우편번호 찾기</button>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="EMP_ADDR" id="emp_address_kakao" required> &nbsp;
					<br>
					<input type="text" name="EMP_ADDR" id ="emp_address_kakao2"> &nbsp;
					<br>
					<span style="color: gray;">(상세 주소를 입력해주세요.)</span>
				</td>
			</tr>
			<tr>
				<th>입사일</th>
				<td>
					<input type="date" name="HIRE_DATE" required>
				</td>
			</tr>
			<tr>
				<th>재직여부</th>
				<td>
					<select name="WORK_CD" required>
						<option value="">===재직여부 선택===</option>
						<option value="C1">재직</option>
						<option value="C2">휴직</option>
						<option value="C3">퇴사</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>권한</th>
				<td>
					<input type="checkbox" id="priv_cd1" name="PRIV_CD" value="1"><label>기본등록</label>
					<input type="hidden" id="priv_cd1_hidden"  name="PRIV_CD" value="0">
					
					<input type="checkbox" id="priv_cd2" name="PRIV_CD" value="1"><label>사원조회</label>
					<input type="hidden" id="priv_cd2_hidden"  name="PRIV_CD" value="0">
					
					<input type="checkbox" id="priv_cd3" name="PRIV_CD" value="1"><label>사원관리</label>
					<input type="hidden" id="priv_cd3_hidden"  name="PRIV_CD" value="0">
					
					<input type="checkbox" id="priv_cd4" name="PRIV_CD" value="1"><label>재고조회</label>
					<input type="hidden" id="priv_cd4_hidden"  name="PRIV_CD" value="0">
					
					<input type="checkbox" id="priv_cd5" name="PRIV_CD" value="1"><label>재고관리</label>
					<input type="hidden" id="priv_cd5_hidden"  name="PRIV_CD" value="0">
				</td>
			</tr>
			<tr>
				<th>사진 업로드</th>
				<td>
					<div class="image_form" >
						<input type="file" id ="input_image" name ="file" onchange="changeImage(event);" required>
					</div>
					<div id="image_container"></div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" id ="insertForm" value="등록" onclick="fn_insertMember()">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>