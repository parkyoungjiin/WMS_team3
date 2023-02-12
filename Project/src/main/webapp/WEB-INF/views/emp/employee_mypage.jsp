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
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

<!------------------- 이미지 수정------------------ -->
<script type="text/javascript">

	function deleteFile(fileName, index) {
		var confirmAlert = confirm("사진을 삭제하시겠습니까?")
		if(confirmAlert == true){
			$("#profile").empty();
			// 파일 삭제를 AJAX 로 처리
			$.ajax({
				type: "POST",
				url: "DeleteImgFile",
				data: {
					"EMP_NUM" : index,
					"PHOTO" : fileName
				},
				success: function(data) {
						console.log(data)
					if(data == "true") {
						// 삭제 성공 시 파일명 표시 위치의 기존 항목을 제거하고
						// 파일 업로드를 위한 "파일 선택" 버튼 항목 표시
						$("#imgChange").html('<input type="file" name="file">');
						alert("파일이 삭제되었습니다!");
					} else if(data == "false") {
						alert("일시적인 오류로 파일 삭제에 실패했습니다!");
					} 
				}
			});
		}else{
			alert("이미지 삭제가 취소되었습니다!")
		}
	}
</script>
<script type="text/javascript">
<!-- 이미지 썸네일 -->

	function changeImage(event) {
		var reader = new FileReader();

        reader.onload = function(event) {
          var img = document.createElement("img");
          img.setAttribute("src", event.target.result);
          img.setAttribute("style", "width: 100px; height: 150px; object-fit: cover;");
          document.querySelector("div#image_container").innerHTML = '';
          document.querySelector("div#image_container").appendChild(img);
          console.log(image_container);
          console.log(img);
        };

        reader.readAsDataURL(event.target.files[0]);
}// changeImage 끝
</script>

</head>
<body>
<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
		<main id="main" class="main">
    <div class="pagetitle">
     <h1>마이페이지</h1>
   </div><!-- End Page Title -->

    <section class="section profile">
      <div class="row">
        <div class="col-xl-4">

          <div class="card">
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
<%--               <img src="${path}/resources/test_image.jpg" alt="Profile" class="rounded-circle" style="width:100px; height: 100px;"> --%>
				<img src=" ${pageContext.request.contextPath}/resources/upload/${emp.PHOTO }" onError="this.onerror=null; this.src='/resources/upload/noImg.png';" alt="Profile" class="rounded-circle" style="width:100px; height: 100px;">
              <h2 style="margin-bottom: 15px">${emp.EMP_NAME}</h2>
              <h3>${emp.GRADE_CD}</h3>
            </div>
          </div>

        </div>

        <div class="col-xl-8">

          <div class="card">
            <div class="card-body pt-3">
            
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">
<!-- 				 <li class="nav-item"> -->
<!--                   <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button> -->
<!--                 </li> -->

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                </li>

<!--                 <li class="nav-item"> -->
<!--                   <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-settings">Settings</button> -->
<!--                 </li> -->

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                </li>

              </ul>

              <!-- 마이페이지 Edit Profile--> 
                <div class="tab-pane fade show active profile-edit pt-3" id="profile-edit">

                  <!-- Profile Edit Form -->
                  <form action="updateMypageInfo.me" method="post" enctype="multipart/form-data">
                    <div class="row mb-3">
                    	<!-- 프로필 이미지 -->
                      <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">사원 이미지</label>
                      <div class="col-md-8 col-lg-9">
                        <div id="profile" >
                        <img src=" ${pageContext.request.contextPath}/resources/upload/${emp.PHOTO }"  width="400" onError="this.onerror=null; this.src='/resources/upload/noImg.png';" alt="Profile" >
                        </div>
                        <!-- 이미지 수정 버튼 -->
						<div id="imgChange" >
	                  		<c:choose>
								<c:when test="${emp.PHOTO ne '' }">
									<%-- 삭제 버튼 클릭 시 파일명과 인덱스번호 전달 --%>
									<input type="button" value="삭제" onclick="deleteFile('${emp.PHOTO}','${emp.EMP_NUM}')">
								</c:when>
								<c:otherwise>
									<input type="file" name="file" class="form-control" id="input_image" onchange="changeImage(event);">
								</c:otherwise>									
							</c:choose>
						</div>
		                </div>
		                <div></div>
		                	<!-- 썸네일 -->
							<label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">사진 미리보기</label>
							<div id="image_container" ></div> <!-- style="width: 250px; height: 250px;" -->
<!--                         <input name="file" type="file" class="form-control" id="input_image" onchange="changeImage(event);"> -->
                      </div>
                      
<!--                    <div></div> -->
                    <div class="row mb-3">
                      <label for="EMP_NAME" class="col-md-4 col-lg-3 col-form-label">사원코드</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="EMP_NAME" type="text" class="form-control" id="EMP_CD" value="${emp.EMP_NUM} " readonly>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="EMP_NAME" class="col-md-4 col-lg-3 col-form-label">사원명</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="EMP_NAME" type="text" class="form-control" id="EMP_NAME" value="${emp.EMP_NAME}" readonly>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="DEPT_CD" class="col-md-4 col-lg-3 col-form-label">부서명</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="DEPT_CD" type="text" class="form-control" id="DEPT_CD" value="${emp.DEPT_CD}" readonly>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="GRADE_CD" class="col-md-4 col-lg-3 col-form-label">직급</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="GRADE_CD" type="text" class="form-control" id="GRADE_CD" value="${emp.GRADE_CD}" readonly>
                      </div>
                    </div>


                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">연락처(개인)</label>
  	                    <div class="col-md-8 col-lg-4">
       	                  <div class="input-group mb-6">
  	                    	<input type="text" class="form-control" name="EMP_TEL" value="010" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="4" value="${emp_phone_number1}">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="4" value="${emp_phone_number2}">
     					   </div>                 
     					</div>
                    </div>

                    <div class="row mb-3">
                     <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">연락처(사무실)</label>
   	                    <div class="col-md-8 col-lg-4">
       	                  <div class="input-group mb-6">
  	                    	<input type="text" class="form-control" name="EMP_DTEL" value="051" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_DTEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="3" value="${emp_dtel_number1}">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_DTEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="4" value="${emp_dtel_number2}"> 
     					   </div>                 
     					</div>
                    </div>

                    <div class="row mb-3">
                      <label for="email" id="title_label" class="col-md-4 col-lg-3 col-form-label">이메일</label>
                      <div class="col-md-8 col-lg-3">
	                      <div class="input-group mb-4">
			                      <input type="text" class="form-control" id="email1" name="EMP_EMAIL" onkeyup="onlyEngNumber(this)" required="required" value="${emp.EMP_EMAIL}" readonly>
			                      	
		                    </div>
	                    </div>
                    </div>
                    

                    <div class="row mb-3">
                       <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" >입사일</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="HIRE_DATE" type="text" class="form-control" id="" value="${emp.HIRE_DATE}" readonly>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">재직여부</label>
                       <div class="col-md-8 col-lg-2">
		                 <c:choose>
	                       <c:when test="${emp.WORK_CD eq 'C1'}">
                       			 <input name="WORK_CD" type="text" class="form-control" id="" value="재직" readonly>
	                       </c:when>
	                       <c:when test="${emp.WORK_CD eq 'C2'}">
                       			 <input name="WORK_CD" type="text" class="form-control" id="" value="휴직" readonly>
	                       </c:when>
	                       <c:when test="${emp.WORK_CD eq 'C3'}">
                      			  <input name="WORK_CD" type="text" class="form-control" id="" value="퇴사" readonly>
	                       </c:when>
	                  </c:choose>
	                    </div>
                    </div>
					

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                  </form><!-- End Profile Edit Form -->



<!--                 <div class="tab-pane fade pt-3" id="profile-settings"> -->

<!--                   Settings Form -->
<!--                   <form> -->

<!--                     <div class="row mb-3"> -->
<!--                       <label for="fullName" class="col-md-4 col-lg-3 col-form-label">Email Notifications</label> -->
<!--                       <div class="col-md-8 col-lg-9"> -->
<!--                         <div class="form-check"> -->
<!--                           <input class="form-check-input" type="checkbox" id="changesMade" checked> -->
<!--                           <label class="form-check-label" for="changesMade"> -->
<!--                             Changes made to your account -->
<!--                           </label> -->
<!--                         </div> -->
<!--                         <div class="form-check"> -->
<!--                           <input class="form-check-input" type="checkbox" id="newProducts" checked> -->
<!--                           <label class="form-check-label" for="newProducts"> -->
<!--                             Information on new products and services -->
<!--                           </label> -->
<!--                         </div> -->
<!--                         <div class="form-check"> -->
<!--                           <input class="form-check-input" type="checkbox" id="proOffers"> -->
<!--                           <label class="form-check-label" for="proOffers"> -->
<!--                             Marketing and promo offers -->
<!--                           </label> -->
<!--                         </div> -->
<!--                         <div class="form-check"> -->
<!--                           <input class="form-check-input" type="checkbox" id="securityNotify" checked disabled> -->
<!--                           <label class="form-check-label" for="securityNotify"> -->
<!--                             Security alerts -->
<!--                           </label> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                     </div> -->

<!--                     <div class="text-center"> -->
<!--                       <button type="submit" class="btn btn-primary">Save Changes</button> -->
<!--                     </div> -->
<!--                   </form>End settings Form -->

<!--                 </div> -->

                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <form action="ChangePasswd.em" method="post">
                  <!-- Change Password Form -->

<!--                     <div class="row mb-3"> -->
<!--                       <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">현재 패스워드</label> -->
<!--                       <div class="col-md-8 col-lg-9"> -->
<!--                         <input name="inputpasswd" type="password" class="form-control" id="currentPassword" placeholder="확인을 위해 패스워드를 입력 해주세요"> -->
<!--                       </div> -->
<!--                     </div> -->

<!--                     <div class="row mb-3"> -->
<!--                       <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">새 패스워드</label> -->
<!--                       <div class="col-md-8 col-lg-9"> -->
<!--                         <input name="newpasswd" type="password" class="form-control" id="newPassword" placeholder="새 비밀번호"> -->
<!--                       </div> -->
<!--                     </div> -->

<!--                     <div class="row mb-3"> -->
<!--                       <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">새 패스워드 재입력</label> -->
<!--                       <div class="col-md-8 col-lg-9"> -->
<!--                         <input name="renewpasswd" type="password" class="form-control" id="renewPassword" placeholder="새 비밀번호 재입력"> -->
<!--                       </div> -->
<!--                     </div> -->

<!--                     <div class="text-center"> -->
<!--                       <button type="submit" class="btn btn-primary">Change Password</button> -->
<!--                     </div> -->

                  </form><!-- End Change Password Form -->

                </div>

              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->
</body>
</html>	