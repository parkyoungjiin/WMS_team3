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
<title>사원정보 수정</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	#leftDiv {
		float:left;
	}
	
	#rightDiv {
		float:right;	
	}
	
</style>
<script type="text/javascript">
	function deleteConfirm() {
		var deleteCheck = "정말로 삭제하시겠습니까?"
		 if(confirm(deleteCheck)) {
			 location.href="EmployeeDelete.em";
		 } else {
			 alert("삭제가 취소되었습니다.");
			 hisory.back();
		 }
	}
</script>
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
	<form action="EmployeeModifyPro.em" name="employeeForm" method="post" enctype="multipart/form-data">
<%--   	수	<input type="hidden" value="${employee.EMP_NUM }" name="old_num"> --%>
<%-- 	정	<input type="hidden" value="${employee.EMP_NAME }" name="old_name"> --%>
<%-- 		<input type="hidden" value="${employee.EMP_DEPT_CD }" name="old_dept_cd"> --%>
<%-- 	예	<input type="hidden" value="${employee.EMP_GRADE_CD }" name="old_grade_cd"> --%>
<%-- 	정	<input type="hidden" value="${employee.EMP_HIRE_DATE }" name="old_hire_date"> --%>
<%-- 		<input type="hidden" value="${employee.EMP_DTEL }" name="old_dtel"> --%>
<%-- 		<input type="hidden" value="${employee.EMP_TEL }" name="old_tel"> --%>
<%-- 		<input type="hidden" value="${employee.EMP_POST_NO }" name="old_post_no"> --%>
<%-- 		<input type="hidden" value="${employee.EMP_ADDR }" name="old_addr"> --%>
<%-- 		<input type="hidden" value="${employee.EMP_WORK_CD }" name="old_work_cd"> --%>
<%-- 		<input type="hidden" value="${employee.EMP_PRIV_CD }" name="old_priv_cd"> --%>
		<div id="leftDiv">
			${employee.PHOTO }
		</div>
		<div id="rightDiv">
		
			<table border="1" width="800px">
				<tr>
					<th>인덱스</th>
					<td>${employee.IDX }</td>
					<th>사번</th>
					<td><input type="text" placeholder="${employee.EMP_NUM }"></td>
					<th>성명</th>
					<td><input type="text" placeholder="${employee.EMP_NAME }"></td>
				</tr>
				<tr>
					<th>부서코드</th>
					<td><input type="text" placeholder="${employee.DEPT_CD }"></td>
					<th>직급코드</th>
					<td><input type="text" placeholder="${employee.GRADE_CD }"></td>
					<th>입사일</th>
					<td><input type="text" placeholder="${employee.HIRE_DATE }"></td>
				</tr>
				<tr>
					<th>연락처(내선번호)</th>
					<td colspan="2"><input type="text" placeholder="${employee.EMP_DTEL }"></td>
					<th>연락처(개인)</th>
					<td colspan="2"><input type="text" placeholder="${employee.EMP_TEL }"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="5"><textarea placeholder="우)${employee.EMP_POST_NO }&#13;&#10;${employee.EMP_ADDR }"></textarea></td>
				</tr>
				<tr>
					<th>재직코드</th>
					<td>
						<select>
							<option value="C1" <c:if test="${employee.WORK_CD eq 'C1' }">selected</c:if>>C1</option>
							<option value="C2" <c:if test="${employee.WORK_CD eq 'C2' }">selected</c:if>>C2</option>
							<option value="C3" <c:if test="${employee.WORK_CD eq 'C3' }">selected</c:if>>C3</option>
						</select>
					</td>
					<th>권한코드</th>
					<td><input type="text" placeholder="${employee.PRIV_CD }"></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="6">
						<input type="submit" value="수정" onclick="location.href='EmployeeModifyPro.em'">
					</td>
				</tr>
			</table>
		</div>
		</form>	
	</section>
</body> 
</html>