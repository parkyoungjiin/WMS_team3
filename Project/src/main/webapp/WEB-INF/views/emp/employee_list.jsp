<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>사원목록</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<%--<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" /> --%>
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<style type="text/css">
	.pageList {
		text-align: center;
	}
	
	#search {
		width: 150px;
/* 		padding-right: 200px; */
	}
</style>
<!-- 권한 여부 판별하여 인사부서인지 판별 -->
<script type="text/javascript">
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_emp = str.charAt(1); // 사원조회(1) 여부 판별할 값	
	//사원조회, 사원관리에 대한 권한이 있는 지 판별
	if(priv_cd_emp == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("권한이 없습니다");
		history.back();
	}
</script>
<!------------------- 이미지 수정------------------ -->
<!-- 권한 여부 판별하여 인사부서인지 판별 -->
<script type="text/javascript">
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_emp = str.charAt(1); // 사원조회(1) 여부 판별할 값
	var priv_cd_emp2 = str.charAt(2); // 사원관리(2) 여부 판별할 값
	
	//사원조회, 사원관리에 대한 권한이 있는 지 판별
	if(priv_cd_emp == '1' || priv_cd_emp2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("사원조회 권한이 없습니다");
		history.back();
	}
</script>
</head>
<body class="sb-nav-fixed">
<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
<main id="main" class="main">

	<div class="pagetitle">
      <h1>사원 목록</h1>
    </div><!-- End Page Title -->
    
            <div class="card mb-4">
                <div class="card-header">
                	사원 목록 <i class="bi bi-search"></i>
                 </div>
                 <div class="card-body">
                 <form action="EmployeeList.em" id="search" >
	                 <div class="input-group">
						 <input type="text" class="form-control" name="keyword" value="${param.keyword }">
						 <input type="submit" class="btn btn-sm btn-outline-secondary" value="검색">
					 </div>
				 </form>
                 <!-- Default Tabs -->
	              <ul class="nav nav-tabs" id="myTab" role="tablist">
	                <li class="nav-item" role="presentation">
	                  <button class="nav-link active tab-css" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" style="font-size:15px;" aria-selected="true">재직</button>
	                </li>
	                <li class="nav-item" role="presentation">
	                  <button class="nav-link tab-css" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" style="font-size:15px;" aria-selected="false">휴직</button>
	                </li>
	                <li class="nav-item" role="presentation">
	                  <button class="nav-link tab-css" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" style="font-size:15px;"  aria-controls="contact" aria-selected="false">퇴사</button>
	                </li>
	              </ul>
                 
               	   <div class="tab-content pt-2" id="myTabContent">
                	<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                     <table name="datatablesSimple" style="font-size:15px;" >
                         <thead>
                             <tr>
                                <th width="120">사진</th>
								<th width="90px">사원번호</th>
								<th width="120px">사원명</th>
								<th width="60">부서</th>
								<th width="60">직급</th>
								<th width="140px">연락처(휴대폰)</th>
								<th width="140px">연락처(내선번호)</th>
								<th width="200px">이메일</th>
								<th width="150">관리하기</th>
                          	</tr>
	                    </thead>
	                    <tbody>
	                    <c:forEach items="${empList }" var="emp">
	                    <c:if test="${emp.WORK_CD eq 'C1' }">
		                    <tr>
<%-- 		                    	<td><img src="${path}/resources/${emp.PHOTO}" alt="등록된 사진이 없습니다."></td> --%>
		                    	<td><img src=" ${pageContext.request.contextPath}/resources/upload/${emp.PHOTO }" onError="this.onerror=null; this.src='resources/upload/noProfile.png';" alt="Profile" style="width:50px; height: 50px;"></td>
		                    	<td>${emp.EMP_NUM }</td>
		                    	<td>${emp.EMP_NAME }</td>
		                    	<td>${emp.DEPT_NAME }</td>
		                    	<td>${emp.GRADE_NAME }</td>
		                    	<td>${emp.EMP_TEL }</td>
		                    	<td>${emp.EMP_DTEL }</td>
		                    	<td>${emp.EMP_EMAIL }</td>
		                    	<td>
		                    		<input type='button' class='btn btn-secondary btn-sm' value='수정' onclick="location.href='EmployeeModifyForm.em?EMP_NUM=${emp.EMP_NUM }'">
            						<input type='button' class='btn btn-secondary btn-sm' value='상세정보조회' onclick="location.href='EmployeeDetail.em?EMP_NUM=${emp.EMP_NUM }'">
		                    	</td>
		                    </tr>
		                 </c:if>   
		                 </c:forEach>  
						</tbody>
                    </table>
                    <section class="pageList">
						<c:choose>
							<c:when test="${pageNum > 1}">
								<input type="button" value="이전" class="btn btn-sm btn-secondary" onclick="location.href='EmployeeList.em?pageNum=${pageNum - 1}'">
							</c:when>
							<c:otherwise>
								<input type="button" class="btn btn-sm btn-secondary" value="이전">
							</c:otherwise>
						</c:choose>
							
						<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
						<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
							<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
							<c:choose>
								<c:when test="${pageNum eq i}">
									${i }
								</c:when>
								<c:otherwise>
									<a href="EmployeeList.em?pageNum=${i }">${i }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
				
						<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
						<c:choose>
							<c:when test="${pageNum < pageInfo.maxPage}">
								<input type="button" class="btn btn-sm btn-secondary" value="다음" onclick="location.href='EmployeeList.em?pageNum=${pageNum + 1}'">
							</c:when>
							<c:otherwise>
								<input type="button" class="btn btn-sm btn-secondary" value="다음">
							</c:otherwise>
						</c:choose>
					</section>
           			<button class="btn btn-primary" onclick="location.href='EmpInsertForm.em'" style="float: right;">신규등록</button>
                    
                    </div> <%--1번탭 끝 --%>
                    
                    <div class="tab-pane fade show" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                     <table name="datatablesSimple" >
                         <thead>
                             <tr>
                             	<th width="120">사진</th>
								<th width="90px">사원번호</th>
								<th width="120px">사원명</th>
								<th width="60">부서</th>
								<th width="60">직급</th>
								<th width="140px">연락처(휴대폰)</th>
								<th width="140px">연락처(내선번호)</th>
								<th width="200px">이메일</th>
								<th width="150">관리하기</th>
                          	</tr>
	                    </thead>
	                    <tbody>
	                    <c:forEach items="${empList }" var="emp">
	                    <c:if test="${emp.WORK_CD eq 'C2' }">
		                    <tr>
		                    	<td><img src=" ${pageContext.request.contextPath}/resources/upload/${emp.PHOTO }" onError="this.onerror=null; this.src='resources/upload/noProfile.png';" alt="Profile" style="width:50px; height: 50px;"></td>
		                    	<td>${emp.EMP_NUM }</td>
		                    	<td>${emp.EMP_NAME }</td>
		                    	<td>${emp.DEPT_NAME }</td>
		                    	<td>${emp.GRADE_NAME }</td>
		                    	<td>${emp.EMP_TEL }</td>
		                    	<td>${emp.EMP_DTEL }</td>
		                    	<td>${emp.EMP_EMAIL }</td>
		                    	<td>
		                    		<input type='button' class='btn btn-secondary btn-sm' value='수정' onclick="location.href='EmployeeModifyForm.em?EMP_NUM=${emp.EMP_NUM }'">
            						<input type='button' class='btn btn-secondary btn-sm' value='상세정보조회' onclick="location.href='MyPage.em?EMP_NUM=${emp.EMP_NUM }'">
		                    	</td>
		                    </tr>
		                 </c:if>   
		                 </c:forEach>  
						</tbody>
                    </table>
                    	<section class="pageList">
								<c:choose>
									<c:when test="${pageNum > 1}">
										<input type="button" value="이전" class="btn btn-sm btn-secondary" onclick="location.href='EmployeeList.em?pageNum=${pageNum - 1}'">
									</c:when>
									<c:otherwise>
										<input type="button" value="이전" class="btn btn-sm btn-secondary">
									</c:otherwise>
								</c:choose>
									
								<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
								<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
									<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
									<c:choose>
										<c:when test="${pageNum eq i}">
											${i }
										</c:when>
										<c:otherwise>
											<a href="EmployeeList.em?pageNum=${i }">${i }</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						
								<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
								<c:choose>
									<c:when test="${pageNum < pageInfo.maxPage}">
										<input type="button" value="다음" class="btn btn-sm btn-secondary" onclick="location.href='EmployeeList.em?pageNum=${pageNum + 1}'">
									</c:when>
									<c:otherwise>
										<input type="button" value="다음" class="btn btn-sm btn-secondary">
									</c:otherwise>
								</c:choose>
							</section>
                       <button class="btn btn-primary" onclick="location.href='EmpInsertForm.em'" style="float: right;">신규등록</button>
                    
                    </div><!-- 2번탭  -->
                	
                   <div class="tab-pane fade active" id="contact" role="tabpanel" aria-labelledby="contact-tab"> <!-- 3번탭 시작  -->
                		<table name="datatablesSimple">
                         <thead>
                             <tr>
                                <th width="120">사진</th>
								<th width="90px">사원번호</th>
								<th width="120px">사원명</th>
								<th width="60">부서</th>
								<th width="60">직급</th>
								<th width="140px">연락처(휴대폰)</th>
								<th width="140px">연락처(내선번호)</th>
								<th width="200px">이메일</th>
								<th width="150">관리하기</th>
                          	</tr>
	                    </thead>
	                    <tbody>
	                    <c:forEach items="${empList }" var="emp">
	                    <c:if test="${emp.WORK_CD eq 'C3' }">
	                    	<td><img src=" ${pageContext.request.contextPath}/resources/upload/${emp.PHOTO }" onError="this.onerror=null; this.src='/resources/upload/noProfile.png';" alt="Profile" style="width:50px; height: 50px;"></td>
	                    	<td>${emp.EMP_NUM }</td>
	                    	<td>${emp.EMP_NAME }</td>
	                    	<td>${emp.DEPT_NAME }</td>
	                    	<td>${emp.GRADE_NAME }</td>
	                    	<td>${emp.EMP_TEL }</td>
	                    	<td>${emp.EMP_DTEL }</td>
	                    	<td>${emp.EMP_EMAIL }</td>
	                    	<td>
	                    		<input type='button' class='btn btn-secondary btn-sm' value='수정' onclick="location.href='EmployeeModifyForm.em?EMP_NUM=${emp.EMP_NUM }'">
           						<input type='button' class='btn btn-secondary btn-sm' value='상세정보조회' onclick="location.href='EmployeeDetail?EMP_NUM=${emp.EMP_NUM }'">
	                    	</td>
		                 </c:if>   
		                 </c:forEach>  
						</tbody>
                    </table>
                    	<button class="btn btn-primary" onclick="location.href='EmpInsertForm.em'" style="float: right;">신규등록</button>
                   </div> <%--3번 탭 끝 --%>
                 </div><!-- End Default Tabs -->
                </div>
            </div> 
</main>		


  <!-- 테이블 템플릿 css/js -->
  <script src="${path}/resources/js/scripts.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
  <script src="${path}/resources/js/datatables-simple-demo.js"></script>
<!--   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
 
</body>
</html>