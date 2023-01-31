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

<!-- 이메일 클릭 시 자동입력 -->
<script type="text/javascript">
$(function() {
	$("#domain").on("change", function() {
		$("#email").val($(this).val());
		
		if($(this).val() == "") {
			$("#email").prop("readonly", false);
			$("#email").css("background-color", "white");
			$("#email").focus();
		} else {
			$("#email").prop("readonly", true);
			$("#email").css("background-color", "lightgray");
		}
	})
	
});
</script>
<!-- 이메일 쿠키 저장 -->
<script type="text/javascript">

//쿠키값 Set
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + 
    exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

//쿠키값 Delete
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

//쿠키값 가져오기
function getCookie(cookie_name) {
    var x, y;
    var val = document.cookie.split(';');
    
    for (var i = 0; i < val.length; i++) {
        x = val[i].substr(0, val[i].indexOf('='));
        y = val[i].substr(val[i].indexOf('=') + 1);
        x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
        
        if (x == cookie_name) {
          return unescape(y); // unescape로 디코딩 후 값 리턴
        }
    }
    
    
}

//이메일 저장 작업
	$(document).ready(function(){
		var userInputId = getCookie("userInputId");
		var setCookieYN	= getCookie("setCookieYN");
		
		//이메일 결합
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var save_email = email1 + "@" + email2;
		//Cookie값이 있을 때(Y) "이메일 저장" 체크박스 값을 true / N 일 때는 해제 작업
		if(setCookieYN == 'Y') {
	        $("#idSaveCheck").prop("checked", true);
	    } else {
	        $("#idSaveCheck").prop("checked", false);
	    }
		
		$("#loginid").val(save_email); // 저장할 이메일 값 세팅
		
		 //로그인 버튼 클릭
	    $('#loginbtn').click(function() {
	    	//체크 됐을 때 처리
	        if($("#idSaveCheck").is(":checked")){ 
	            var userInputId = $("#loginid").val();
	            setCookie("userInputId", userInputId, 60); //아이디 저장 
	            setCookie("setCookieYN", "Y", 60); // 쿠키여부 Y로 저장
	        } else {//체크 안됐을 때 쿠키 삭제
	            deleteCookie("userInputId"); 
	            deleteCookie("setCookieYN");
	        }
	        
	        document.fform.submit();
	    });
	})//document.ready 끝
</script>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<form action="EmpLoginPro.em" method="post" name ="fform">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="EMP_EMAIL">@
					<input type="text" id ="email" name ="EMP_EMAIL">
					<select name="selectDomain" id="domain"  style="padding: .4em .5em; ">
						<option value="">직접입력</option>	
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
						</select> &nbsp;
					
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name ="EMP_PASSWD">
					
				</td>
			</tr>
			<tr>
				<td><input type="checkbox" id ="idSaveCheck">이메일 저장</td>
			</tr>
			<tr>
				<td><input type="submit" class ="loginbtn" value="로그인"></td>
			</tr>
		</table>
	</form>
</body>
</html>