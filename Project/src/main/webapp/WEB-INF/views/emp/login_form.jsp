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

$(document).ready(function(){
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var key = getCookie("key");
    $("#email").val(key); 
     
    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
    if($("#email").val() != ""){ 
        $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
        if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("key", $("#email").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("key");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#email").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("key", $("#email").val(), 7); // 7일 동안 쿠키 보관
        }
    });
});
// 쿠키 저장하기 
// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
function setCookie(cookieName, value, exdays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var cookieValue = escape(value)
			+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
	document.cookie = cookieName + "=" + cookieValue;
}

// 쿠키 삭제
function deleteCookie(cookieName) {
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires="
			+ expireDate.toGMTString();
}
 
// 쿠키 가져오기
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName); //찾는 문자열이 없으면 -1를 리턴함 indexOf
	var cookieValue = '';
	if (start != -1) { // 쿠키가 존재하면
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
			end = cookieData.length;
            console.log("end위치  : " + end);
		cookieValue = cookieData.substring(start, end);
            console.log("cookie값 : " + cookieValue)
	}
	return unescape(cookieValue);
}
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
				<td><input type="checkbox" id ="checkId">이메일 저장</td>
			</tr>
			<tr>
				<td><input type="submit" class ="loginbtn" value="로그인"></td>
			</tr>
		</table>
	</form>
</body>
</html>