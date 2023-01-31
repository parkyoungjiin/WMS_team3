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
			var addInput = '<input type="text" name="uptae">&nbsp'
							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_uptae]:first");
			trHtml.before(addInput);
		});
		
		$("#plus_jongmok").on("click", function() {
			var addInput = '<input type="text" name="jongmok">&nbsp'
							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_jongmok]:first");
			trHtml.before(addInput);
		});
		
		
	});
	
	// 거래처 코드 중복 체크
	function checkCode() {
		let business_no = $('#business_no').val();
		
		if(business_no.length == 0){
			alert("거래처 코드를 입력해주세요");
		} else {
		
		 $.ajax({
	            url:'CodeCheck', //Controller에서 요청 받을 주소
	            type:'post', //POST 방식으로 전달
	            data:{business_no:business_no},
	            success:function(result){ //컨트롤러에서 넘어온 cnt값을 받는다 
	                if(result == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 코드 
	                	alert("사용 가능한 코드입니다.")
	                	codeStatus = true;
	                } else { // cnt가 1일 경우 -> 이미 존재하는 코드
	                    alert("이미 존재하는 코드입니다.");
	                    $('#business_no').val('');
	                    codeStatus = false;
	                }
	            },
	            error:function(){
	                alert("중복 체크 실패!");
	            }
	        });
		}
	};
	
	// 등록 작업 막기
	function fn_registerBuyer(){
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

	<form action="BuyerRegisterPro" method="post" >
		<table>
			<tr>
				<td>거래처코드</td>
				<td><input type="text" name="business_no" id="business_no" required="required" class="form-control"></td>
				<td><button type="button" onclick="checkCode()">fn</button></td>
			</tr>
			<tr>
				<td>거래처 코드 구분</td>
				<td>
				<label><input type="radio" name="g_gubun" value="01" checked="checked">&nbsp;01 사업자등록번호</label>&nbsp; 
				<label><input type="radio" name="g_gubun" value="02">&nbsp;02 해외사업자등록번호</label>&nbsp; 
				<label><input type="radio" name="g_gubun" value="03">&nbsp;03 주민등록번호</label>&nbsp;
				<label><input type="radio" name="g_gubun" value="04">&nbsp;04 외국인</label>
				</td>
			</tr>
			<tr>
				<td>상호</td>
				<td><input type="text" name="cust_name" required="required"></td>
			</tr>
			<tr>
				<td>대표자명</td>
				<td><input type="text" name="boss_name"></td>
			<tr />
			<tr>
				<td>업태</td>
				<td><input type="text" name="uptae">&nbsp;<i id="plus_uptae" name="orgInput_uptae" class="fa-solid fa-plus" style="cursor: pointer;"></i></td>
			</tr>
			<tr>
				<td>종목</td>
				<td><input type="text" name="jongmok">&nbsp;<i id="plus_jongmok" name="orgInput_jongmok" class="fa-solid fa-plus" style="cursor: pointer;"></i></td>
			</tr>
			<tr>
				<td>대표 전화번호</td>
				<td>
					<input type="text" size="1" name="tel"> -
					<input type="text" size="1" name="tel"> -
					<input type="text" size="1" name="tel">
				</td>
			</tr>
			<tr>
				<td>팩스</td>
				<td><input type="text" name="fax"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
				<input type="text" size="5" id="email1" name="email" > @ 
				<input type="text" size="5" id="email2" name="eamil" > 
				<select name="selectDomain" id="domain" style="padding: .4em .5em;">
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
				<td><input type="text" name="post_no" id="emp_address_zonecode" > &nbsp;
					<button id="address_kakao" type="button">우편번호 찾기</button></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="addr" id="emp_address_kakao" > &nbsp; <br> 
				<input type="text" name="addr" id="emp_address_kakao2" placeholder="(상세주소를 입력해주세요.)"> &nbsp; <br> 
			</tr>
			<tr>
				<td>홈페이지</td>
				<td><input type="text" name="man_home"></td>
			</tr>
			<tr>
				<td>담당자명</td>
				<td><input type="text" name="man_name"></td>
				<td>담당자 전화번호</td>
				<td>
					<input type="text" size="1" name="man_tel"> -
					<input type="text" size="1" name="man_tel"> -
					<input type="text" size="1" name="man_tel">
				</td>
				<td>담당자 이메일</td>
				<td>
				<input type="text" size="5" id="email1_man" name="man_email"> @ 
				<input type="text" size="5" id="email2_man" name="man_email"> 
				<select name="selectDomain" id="domain_man" style="padding: .4em .5em;">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
				</select> &nbsp;
				</td>
			</tr>
			<tr>
				<td>적요</td>
				<td><input type="text" name="remarks"></td>
			</tr>
			<tr>
				<td colspan="6"><input type="submit" value="등록" onclick="fn_registerBuyer()"> <input
					type="reset" value="다시쓰기"> <input type="button"
					onclick="history.back()" value="취소"></td>
			</tr>
		</table>
	</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>