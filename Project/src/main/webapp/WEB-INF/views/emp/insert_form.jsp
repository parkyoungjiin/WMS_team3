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
	function readImage(input) {
    // 인풋 태그에 파일이 있는 경우
    if(input.files && input.files[0]) {
        // 이미지 파일인지 검사 (생략)
        // FileReader 인스턴스 생성
        const reader = new FileReader()
        // 이미지가 로드가 된 경우
        reader.onload = e => {
            const previewImage = document.getElementById("preview_image")
            previewImage.src = e.target.result
        }
        // reader가 이미지 읽도록 하기
        reader.readAsDataURL(input.files[0])
    }
//----------input file에 change 이벤트 부여----------
	const inputImage = document.getElementById("input_image")
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	})

}// readImage 끝
</script>

<!-- 이메일 클릭 시 자동입력 -->
<script type="text/javascript">
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
	})
	
});

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
						<option value="">부서 선택</option>
						<option value="A1">총무팀</option>
						<option value="A2">인사팀</option>
						<option value="A3">기획팀</option>
						<option value="A4">영업팀</option>
						<option value="A5">회계팀</option>
						<option value="A6">개발팀</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>직급명</th>
				<td>
				<select name ="GRADE_CD" required="required">
					<option value="">직급 선택</option>
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
					<input type="text" size="1" value="010" name="EMP_TEL"> -
					<input type="text" size="1" name="EMP_TEL" required="required"> -
					<input type="text" size="1" name="EMP_TEL" required="required">
				</td>
			</tr>
			<tr>
				<th>연락처(사무실)</th>
				<td>
					<input type="text" size="1" value="051" name="EMP_DTEL" required="required"> -
					<input type="text" size="1" name="EMP_DTEL" required="required"> -
					<input type="text" size="1" name="EMP_DTEL" required="required">
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" size="5" id="email1" name="EMP_EMAIL" required="required"> @
					<input type="text" size="5" id="email2" name="EMP_EMAIL"  required="required">
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
						<option value="">재직여부 선택</option>
						<option value="C1">재직</option>
						<option value="C2">휴직</option>
						<option value="C3">퇴사</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>권한</th>
				<td>
					<select name="PRIV_CD" required>
						<option value="">권한 선택</option>
						<option value="D1">기본 등록</option>
						<option value="D2">사원 조회</option>
						<option value="D3">사원 관리</option>
						<option value="D4">재고 조회</option>
						<option value="D5">재고 관리</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>사진 업로드</th>
				<td>
					<div class="image_container" >
						<img src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image" width="500px" id ="preview_image"> <br>
						<input type="file" id ="input_image" name ="file" required>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="등록">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>