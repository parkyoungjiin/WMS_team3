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
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
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
<script type="text/javascript">

	
	// 권한여부 판별하는 자바스크립
	var str = '${priv_cd}' // 세션에 저장된 권한코드
		
	var priv_cd_emp = str.charAt(1); // 사원조회(1) 여부 판별할 값
	var priv_cd_emp2 = str.charAt(2); // 사원관리(2) 여부 판별할 값
	
	//사원조회, 사원관리에 대한 권한이 있는 지 판별
	if(priv_cd_emp == '1' || priv_cd_emp2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("사원상세정보 권한이 없습니다");
		history.back();
	} //권한여부 판별
</script>
<style type="text/css">
	#title_label{
		font-weight: bold;
	}
</style>
<title>사원 등록</title>
</head>
<body>
	<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
	<%-- 회원 개별 상세 정보 --%>
	<section>
		<div id="leftDiv">
		${employee.PHOTO }
<%-- 			<img id="empImg" src="../resources/upload${emp.PHOTO }"  width="100px" > --%>
<main id ="main" class="main">
   <div class="pagetitle">
     <h1>사원 관리</h1>
   </div>
	<div class="card-header">
            사원 상세 정보
        </div>
		<div class="card mb-4">
			<div><img src=></div>
		<!-- Profile Edit Form -->
		       <div class="card-body">
                  <input type="hidden" name="EMP_PASSWD" value="${employee.EMP_PASSWD }">
                  <input type="hidden" name="IDX" value="${employee.IDX }">
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">사원번호</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="EMP_NUM" type="text" class="form-control" id="fullName" readonly value="${employee.EMP_NUM }">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">사원명</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="EMP_NAME" type="text" class="form-control" id="fullName" value="${employee.EMP_NAME }"readonly>
                      </div>
                    </div>
				<c:if test="${sessionScope.emp_num eq employee.EMP_NUM }">
					<form action="ChangePasswd.em" method="post">

                    <div class="row mb-3">
                      <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">현재 패스워드</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="inputpasswd" type="password" class="form-control" id="currentPassword" placeholder="확인을 위해 패스워드를 입력 해주세요">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="newPassword " class="col-md-4 col-lg-3 col-form-label">새 패스워드</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="newpasswd" type="password" class="form-control" id="newPassword" placeholder="새 비밀번호">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">새 패스워드 재입력</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="renewpasswd" type="password" class="form-control" id="renewPassword" style="padd" placeholder="새 비밀번호 재입력">
	                  </div>  
	                  <div class="col-md-8 col-lg-2">
	                      <button type="submit" class="btn btn-primary">Change Password</button>
	                  </div>    
                    </div>

                  </form>
					</c:if>
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">부서명</label>
                      <div class="col-md-8 col-lg-2">
                      <input type="text" class="form-control" value="${employee.DEPT_CD}" readonly>	
						</div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">직급명</label>
                      <div class="col-md-8 col-lg-2">
   						<input type="text" class="form-control" value="${employee.GRADE_CD}" readonly>
						</div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">연락처(개인)</label>
  	                    <div class="col-md-8 col-lg-3">
       	                  <div class="input-group mb-6">
  	                    	<input type="text" class="form-control" name="EMP_TEL" value="010" onkeyup="inputOnlyNumberFormat(this)" readonly maxlength="3">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" readonly maxlength="4" value="${tel1 }">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" readonly maxlength="4" value="${tel2 }">
     					   </div>                 
     					</div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">연락처(사무실)</label>
   	                    <div class="col-md-8 col-lg-3">
       	                  <div class="input-group mb-6">
  	                    	<input type="text" class="form-control" name="EMP_DTEL" value="051" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_DTEL" onkeyup="inputOnlyNumberFormat(this)" readonly maxlength="4" value="${dTel1 }">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_DTEL" onkeyup="inputOnlyNumberFormat(this)" readonly maxlength="4" value="${dTel2 }">
     					   </div>                 
     					</div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">이메일</label>
                		  <div class="col-md-8 col-lg-5">
                		
		                	<div class="input-group mb-5">
		                      <input type="text" class="form-control" id="email1" name="EMP_EMAIL" onkeyup="onlyEngNumber(this)" required="required" value=${email1 } readonly>
		                      <span class="input-group-text">@</span>
		                      <input type="text" class="form-control" id="email2" name="EMP_EMAIL" required value=${email2 } readonly>
		                    </div>
		                   		 <div id ="checkResultArea" class="col-md-8 col-lg-5"></div>
	                    </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">우편번호</label>
                      <div class="col-md-8 col-lg-2">
	                	<div class="input-group mb-6">
                        <input name="EMP_POST_NO" type="text" class="form-control" id="emp_address_zonecode" value="${employee.EMP_POST_NO }" readonly >
	                    </div>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">주소</label>
                      <div class="col-md-8 col-lg-3">
                        <input name="EMP_ADDR" type="text" class="form-control" id="emp_address_kakao" required value="${addr1 }" readonly>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">상세주소</label>
                      <div class="col-md-8 col-lg-3">
                        <input name="EMP_ADDR" type="text" class="form-control" id="emp_address_kakao2" value="${addr2 }" readonly>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" >입사일</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="HIRE_DATE" type="text" class="form-control" value="${employee.HIRE_DATE }"readonly>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">재직여부</label>
                       <div class="col-md-8 col-lg-2">
                       <c:choose>
							<c:when test="${employee.WORK_CD eq 'C1' }"><input type="text" class="form-control" value="재직" readonly></c:when>
							<c:when test="${employee.WORK_CD eq 'C2' }"><input type="text" class="form-control" value="휴직" readonly></c:when>
							<c:otherwise>
								<input type="text" class="form-control" value="퇴사" readonly>
							</c:otherwise>
						</c:choose>	
	                    </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">권한</label>
                       <div class="col-md-8 col-lg-5">
		                	<div class="input-group mb-6">
		                        <label class="form-check-label" style="margin-right: 30px">
		                        	<input type="checkbox" class="form-check-input" id="priv_cd1" name="PRIV_CD" value="1" style="margin-right: 10px">
		                        	기본등록
		                        </label>
								<input type="hidden" id="priv_cd1_hidden"  name="PRIV_CD" value="0">
								<label class="form-check-label" style="margin-right: 30px">
									<input type="checkbox" class="form-check-input" id="priv_cd2" name="PRIV_CD" value="1" style="margin-right: 10px">
									사원조회
								</label>
								<input type="hidden" id="priv_cd2_hidden"  name="PRIV_CD" value="0">
								
								<label class="form-check-label" style="margin-right: 30px">
									<input type="checkbox" class="form-check-input" id="priv_cd3" name="PRIV_CD" value="1" style="margin-right: 10px">
									사원관리
								</label>
								<input type="hidden" id="priv_cd3_hidden" name="PRIV_CD" value="0">
								
								<label class="form-check-label" style="margin-right: 30px">
									<input type="checkbox" class="form-check-input" id="priv_cd4" name="PRIV_CD" value="1" style="margin-right: 10px">
									재고조회
								</label>
								<input type="hidden" id="priv_cd4_hidden"  name="PRIV_CD" value="0">
								
								<label class="form-check-label" style="margin-right: 30px">
									<input type="checkbox" class="form-check-input" id="priv_cd5" name="PRIV_CD" value="1" style="margin-right: 10px">
									재고관리
								</label>
								<input type="hidden" id="priv_cd5_hidden"  name="PRIV_CD" value="0">
		                    </div>
	                    </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">사진 업로드</label>
                    </div>
					
<!--                     <div class="text-left"> -->
<!--                       <button type="submit" class="btn btn-primary">수정하기</button> -->
<!--                       <button type="reset" class="btn btn-secondary">다시 쓰기</button> -->
<!--                       <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button> -->
<!--                     </div> -->
                	<!-- End Profile Edit Form -->
                </div>
		</div>
</main>
</body>
</html>