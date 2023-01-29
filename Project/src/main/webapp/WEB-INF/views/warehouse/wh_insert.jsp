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
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
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
		});
	});
	
</script>


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="WareHouseInserPro.wh">
<table class="table table-bordered">
	<tr>
		<th><h1>창고 등록</h1></th>
	</tr>
	<tr>
		<td>
			<div>창고 코드</div>
			<input type="text" name="wh_cd"></td>
	</tr>
	<tr>		
		<td><div>창고명 </div>
			<input type="text" name="wh_name">
		</td><br>	
	</tr>	
	<tr>	
		<td>
			<div>구분</div>
			<input type="radio" name="wh_gubun" value="창고" checked="checked">창고		
			<input type="radio" name="wh_gubun" value="공장">공장		
		</td><br>	
	</tr>
	<tr>	
		<td>
			<div>위치 </div>
			<input type="radio" name="wh_location" value="외부" checked="checked">외부
			<input type="radio" name="wh_location" value="내부">내부		
		</td><br>	
	</tr>	
	<tr>
		<td id="address">
			<div>주소(* 외부 선택 시 필수 등록)</div>
			<input type="text" name="wh_addr" id="wh_address_kakao"> &nbsp;
			<br>
			<input type="text" name="wh_addr_detail" id ="wh_address_kakao2"> &nbsp;
			<br>
			<span style="color: gray;">(상세 주소를 입력해주세요.)</span>
		</td>
	</tr>
	<tr>	
		<td>
			<div>전화번호</div>
			<select name="wh_tel1">
				<option value="051">051</option>
				<option value="052">052</option>
				<option value="053">053</option>
			</select>-
		 	<input type="text" size="1" name="wh_tel2">-
		 	<input type="text" size="1" name="wh_tel3">
		</td><br>	
	</tr>	
	<tr>	
		<td>
			<div>관리자</div> 
			<input type="text" name="wh_man_name">
		</td><br>
	</tr>	
	<tr>	
		<td>
			<div>사용여부 </div> 
			<input type="radio" name="wh_use" value="1" checked="checked">사용
			<input type="radio" name="wh_use" value="2">미사용
		</td><br>
	</tr>	
	<tr>	
		<td>
			<div>비고:</div>
			<textarea name="remarks" rows="10" cols=50"></textarea>
		</td>
	</tr>
	<tr>	
		<td><input type="submit" value="신규"></td>
	</tr>	
</table>
</form>
</body>
</html>