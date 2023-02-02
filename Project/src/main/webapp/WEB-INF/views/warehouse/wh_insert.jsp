<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
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
<!-- 테이블 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 테이블 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>	
<!-- 다음 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("wh_address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("wh_address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=wh_addr_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
<!--제이쿼리  -->
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
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
	$("#wh_cd").change(function() {
			alert("변경 감지");
			let wh_cd = $("#wh_cd").val();
			$.ajax({
				type: "get",
				url: "WhCodeCheck.wh?wh_cd="+wh_cd,
				data: wh_cd,
				dataType: "html",
				success: function(data){
					alert(data);
					if(data == 0){
						alert("중복 아님");
						$("#checkCdResult").html("사용 가능 코드").css("color","green");
						$("#fr").attr("onsubmit","return true");
					}else if(data == 1){
						alert("중복");
						$("#checkCdResult").html("이미 존재 하는 창고 코드 ").css("color","red");
						$("#wh_cd").focus();
						$("#fr").attr("onsubmit","return false");				
					}
				}
			}).fail(function(result) {
				alert("중복아님");
			});
		});// 코드 중복 확인 끝	
	
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
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
	<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
<form action="WareHouseInserPro.wh" id="fr">
<table class="table" style="width: 1200px; height:100px;">
	<tr>
		<th colspan="2"><h3>창고 등록</h3></th>
	</tr>
	<tr>
		<th>창고 코드</th>
		<td style="width:250px ">
		<input type="text" name="wh_cd" id="wh_cd" required="required"><div id="checkCdResult"></div>
		</td>
	</tr>
	<tr>		
		<th>창고명</th>
		<td>
			<input type="text" name="wh_name" required="required">
		</td>
	</tr>	
	<tr>	
		<th>구분</th>
		<td>
			<input type="radio" name="wh_gubun" value="창고" checked="checked">창고		
			<input type="radio" name="wh_gubun" value="공장">공장		
		</td>
	</tr>
	<tr>	
		<th>위치</th>
		<td>
			<input type="radio" name="wh_location" value="외부" checked="checked">외부
			<input type="radio" name="wh_location" value="내부">내부		
		</td>
	</tr>	
	<tr>
		<th>주소(* 외부 선택 시 필수 등록)</th>
		<td id="address">
			<input type="text" name="wh_addr" id="wh_address_kakao" required="required"> &nbsp;
			<br>
			<input type="text" name="wh_addr_detail" id ="wh_address_kakao2" required="required" placeholder="(상세 주소를 입력해주세요.)"> &nbsp;
		</td>
	</tr>
	<tr>	
		<th>전화번호</th>
		<td>
			<select name="wh_tel1">
				<option value="051" selected="selected">051</option>
				<option value="052">052</option>
				<option value="053">053</option>
			</select>-
		 	<input type="text" size="1" name="wh_tel2" required="required" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">-
		 	<input type="text" size="1" name="wh_tel3" required="required" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
		</td>	
	</tr>	
	<tr>	
		<th>관리자</th>
		<td>
			<input type="text" name="wh_man_name" required="required">
		</td>
	</tr>	
	<tr>	
		<th>사용여부</th>
		<td>
			<input type="radio" name="wh_use" value="1" checked="checked">사용
			<input type="radio" name="wh_use" value="2">미사용
		</td>
	</tr>	
	<tr>	
		<th>비고:</th>
		<td>
			<textarea name="remarks" rows="3" cols="50" required="required"></textarea>
		</td>
	</tr>
	<tr>	
		<td colspan="2"><input type="submit" id="submit" value="등록"></td>
	</tr>	
</table>
</form>
</body>
</html>