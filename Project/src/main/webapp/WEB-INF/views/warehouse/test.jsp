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
    document.getElementById("wh_addr").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("wh_addr").value = data.address; // 주소 넣기
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
	//외부,내부 처리
	$("input:radio[name='location']").change(function() {
		var location = $("input:radio[name='location']:checked").val();
		alert(location);
			if(location == '내부'){
				$("#address").hide();
			}else if(location == '외부'){
				$("#address").show();
			}
			
		});
	//수정 처리
	$("#updatebutton").click(function() {
		var params = $("#fr").serialize();
		$.ajax({
			type: "post",
			url: "WhModify.wh",
			data:params,
			dataType: "html"
		})
		.done(function() { // 요청 성공 시
			alert("성공");
		})
		.fail(function() {
			alert("실패");	
		});
	
	});// 수정처리	
// 	//코드 중복 확인 처리
// 	$("#wh_cd").change(function() {
// 			alert("변경 감지");
// 			let wh_cd = $("#wh_cd").val();
// 			$.ajax({
// 				type: "get",
// 				url: "WhCodeCheck.wh?wh_cd="+wh_cd,
// 				data: wh_cd,
// 				dataType: "html",
// 				success: function(data){
// 					alert(data);
// 					if(data == 0){
// 						alert("중복 아님");
// 						$("#checkCdResult").html("사용 가능 코드").css("color","green");
// 						$("#fr").attr("onsubmit","return true");
// 					}else if(data == 1){
// 						alert("중복");
// 						$("#checkCdResult").html("이미 존재 하는 창고 코드 ").css("color","red");
// 						$("#fr").attr("onsubmit","return false");
// 					}
// 				}
// 			}).fail(function(result) {
// 				alert("중복아님");
// 			});
// 		});//코드 중복
		 

	
	});//jquery 끝!
	

	
	
</script>

<style type="text/css">
	title { 
		background-color: black; 
		}
</style>
<meta charset="UTF-8">
<title>내용</title>
</head>
<body>
<!-- top-->
	<header>
	<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>

<form  name="fr" id="fr">
 <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputEmail4">Email</label>
      <input type="email" class="form-control" id="inputEmail4" placeholder="Email">
    </div>
    <div class="form-group col-md-6">
      <label for="inputPassword4">Password</label>
      <input type="password" class="form-control" id="inputPassword4" placeholder="Password">
    </div>
  </div>
  <div class="form-group">
    <label for="inputAddress">Address</label>
    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
  </div>
  <div class="form-group">
    <label for="inputAddress2">Address 2</label>
    <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputCity">City</label>
      <input type="text" class="form-control" id="inputCity">
    </div>
    <div class="form-group col-md-4">
      <label for="inputState">State</label>
      <select id="inputState" class="form-control">
        <option selected>Choose...</option>
        <option>...</option>
      </select>
    </div>
    <div class="form-group col-md-2">
      <label for="inputZip">Zip</label>
      <input type="text" class="form-control" id="inputZip">
    </div>
  </div>
  <div class="form-group">
    <div class="form-check">
      <input class="form-check-input" type="checkbox" id="gridCheck">
      <label class="form-check-label" for="gridCheck">
        Check me out
      </label>
    </div>
  </div>
  <button type="submit" class="btn btn-primary">Sign in</button>
</form>
</body>
</html>