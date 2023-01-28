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
<meta charset="UTF-8">

<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao2").value = data.address; // 주소 넣기
                document.getElementById("address_zonecode").value = data.zonecode; // 우편번호 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
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
<title>사원 등록</title>
</head>
<body>
	<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<table>
		<tr>
			<th>사원명</th>
			<td>
			<input type="text">
			</td>
		</tr>
		<tr>
			<th>부서명</th>
			<td>
				<select>
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
			<select>
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
				<input type="text" size="1" value="010"> -
				<input type="text" size="1"> -
				<input type="text" size="1">
			</td>
		</tr>
		<tr>
			<th>연락처(사무실)</th>
			<td>
				<input type="text" size="1" value="051"> -
				<input type="text" size="1"> -
				<input type="text" size="1">
			</td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td>
			<input type="text" name="address" id="address_zonecode" required > &nbsp;
			<button id="address_kakao">우편번호 찾기</button>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<input type="text" name="address" id="address_kakao2" required> &nbsp;
				<br>
				<input type="text" name="address_detail"> &nbsp;
				<br>
				<span style="color: gray;">(상세 주소를 입력해주세요.)</span>
			</td>
		</tr>
		<tr>
			<th>입사일</th>
			<td>
				<input type="date">
			</td>
		</tr>
		<tr>
			<th>재직여부</th>
			<td>
				<select>
					<option>재직여부 선택</option>
					<option value="1">재직</option>
					<option value="2">휴직</option>
					<option value="3">퇴사</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>권한</th>
			<td>
				<select>
					<option>권한 선택</option>
					<option>기본 등록</option>
					<option>사원 조회</option>
					<option>사원 관리</option>
					<option>재고 조회</option>
					<option>재고 관리</option>
				</select>
			</td>
		</tr>
		<tr>
			<th><label for="PHOTO">사진 업로드</label></th>
			<td>
				<div class="image_container">
					<img src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image" width="500px" id ="preview_image"> <br>
					<input type="file" name ="file" id ="input_image">
				</div>
			</td>
			
			
		</tr>
	</table>
</body>
</html>