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
<title>메인페이지</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	#leftDiv {
		float:left;
	}
	
	#rightDiv {
		float:right;	
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
	
	<%-- 회원 개별 상세 정보 --%>
	<section>
		<div id="leftDiv">
		${employee.PHOTO }
<%-- 			<img id="empImg" src="../resources/upload${emp.PHOTO }"  width="100px" > --%>
		</div>
		<div id="rightDiv">
			<table border="1" width="800px">
				<tr>
					<th>인덱스</th>
					<td>${employee.IDX }</td>
					<th>사번</th>
					<td>${employee.EMP_NUM }</td>
					<th>성명</th>
					<td>${employee.EMP_NAME }</td>
				</tr>
				<tr>
					<th>부서코드</th>
					<td>${employee.DEPT_CD }</td>
					<th>직급코드</th>
					<td>${employee.GRADE_CD }</td>
					<th>입사일</th>
					<td>${employee.HIRE_DATE }</td>
				</tr>
				<tr>
					<th>연락처(내선번호)</th>
					<td>${employee.EMP_DTEL }</td>
					<th>연락처(개인)</th>
					<td>${employee.EMP_TEL }</td>
					<th>이메일</th>
					<td>${employee.EMP_EMAIL }</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="5"><small>우)${employee.EMP_POST_NO }</small><br>${employee.EMP_ADDR}</td>
				</tr>
				<tr>
					<th>재직코드</th>
					<td>${employee.WORK_CD }</td>
					<th>권한코드</th>
					<td>${employee.PRIV_CD }</td>
					<th>관리</th>	
					<td>		
						<c:if test="${employee.WORK_CD ne 'C3' }">
							<input type="button" value="비밀번호 변경" onclick="location.href=''">
							<input type="button" value="사원정보 수정" onclick="location.href='EmployeeModifyForm.em?EMP_NUM=${employee.EMP_NUM }'">
						</c:if>	
					</td>
				</tr>
			</table>
		</div>
	</section>
</body> 
</html>