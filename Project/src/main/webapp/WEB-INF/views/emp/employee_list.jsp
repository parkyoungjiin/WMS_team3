<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title></title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	#dropdownArea {
	 	text-align: right;
	 	padding-right: 50px;
	}
	
	table {
		padding-left: 20px;
	}
	
</style>
</head>
<body>
	<header>
	<!-- top-->
	<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
	<%-- 사원목록 조회 작업 --%>
	<div>
		<h3>사원 목록</h3>
		<!-- ***************************사원 검색 (추가사항)******************************************-->
<!-- 		<section id="buttonArea"> -->
<!-- 			<form action="EmployeeList.em"> -->
<!-- 				<select name="searchType"> -->
<%-- 					<option value="EMP_NUM" <c:if test="${param.searchType eq 'EMP_NUM'}">selected</c:if>>사원번호</option> --%>
<%-- 					<option value="EMP_NAME" <c:if test="${param.searchType eq 'EMP_NAME'}">selected</c:if>>사원이름</option> --%>
<%-- 					<option value="EMP_TEL" <c:if test="${param.searchType eq 'EMP_TEL'}">selected</c:if>>전화번호</option> --%>
<%-- 					<option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>작성자</option> --	%> --%>
					
<!-- 				</select> -->
<!-- 				<input type="text" name="keyword"> -->
<!-- 				<input type="submit" value="검색"> -->
<!-- 				&nbsp;&nbsp; -->
<!-- 			</form> -->
<!-- 		</section> -->
		<section id="dropdownArea">
			<select name="workCodeCategory">
				<option value="C1">재직</option>
				<option value="C2">휴직</option>
				<option value="C3">퇴사</option>
			</select>
		</section>
		<br>
		<table>
			<tr>
				<th width="120">사진</th>
				<th>인덱스</th>
				<th width="90px">사원번호</th>
				<th width="120px">사원명</th>
				<th width="60">부서코드</th>
				<th width="60">직급코드</th>
				<th width="140px">연락처(휴대폰)</th>
				<th width="140px">연락처(내선번호)</th>
				<th width="200px">이메일</th>
				<th width="150">관리하기</th>
			</tr>
			<c:forEach var="employee" items="${employeeList }">
			<c:if test="${employee.WORK_CD eq 'C1'}">
				<tr style="text-align:center;">
					<td><img id="empImg" src="${path }/resources/upload${employee.PHOTO }" width="100px" ></td>
					<td>${employee.IDX }</td>
					<td>${employee.EMP_NUM }</td>
					<td>${employee.EMP_NAME }</td>
					<td>${employee.DEPT_CD }</td>
					<td>${employee.GRADE_CD }</td>
					<td>${employee.EMP_TEL }</td>
					<td>${employee.EMP_DTEL }</td>
					<td>${employee.EMP_EMAIL }</td>
					<td>
						<input type="button" value="상세조회" onclick="location.href='EmployeeDetail.em?EMP_NUM=${employee.EMP_NUM}'">
						<c:if test="${employee.WORK_CD ne 'C3' }">
							<input type="button" value="수정" onclick="location.href='EmployeeModifyForm.em?EMP_NUM=${employee.EMP_NUM}'">
						</c:if>	
					</td>
				</tr>
			</c:if>
			</c:forEach>
		</table>
		<input type="button" value="신규등록" onclick="location.href='EmpInsertForm.em'">
	</div>
	<!-- 사원 목록 조회 작업 끝 -->
</body> 
</html>