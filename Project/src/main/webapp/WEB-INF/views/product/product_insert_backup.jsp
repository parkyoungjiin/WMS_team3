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

<meta charset="UTF-8">
<title>품목 등록</title>
</head>
<body>

<table class="table table-bordered" style="width: 800px; margin: 100px;">
	<tr>
		<th colspan="2" style="text-align: center;">품목 등록</th>
	</tr>
	<tr style="text-align: center">
		<tr>
			<th>품목 코드</th>
			<td><input type="text" value=""> </td>
		</tr>
		<tr>
			<th>품목명</th>
			<td><input type="text" placeholder="품목명"> </td>
		</tr>
		<tr>
			<th>품목 그룹</th>
			<td><input type="radio" value="data1"/> </td>
			<td><input type="text"> </td>
		</tr>
		<tr>
			<th>규격</th>
			<td><input type="text"> </td>
		</tr>
		<tr>
			<th>바코드</th>
			<td><input type="text"> </td>
		</tr>
		<tr>
			<th>입고 단가</th>
			<td><input type="text"> </td>
		</tr>
		<tr>
			<th>출고 단가</th>
			<td><input type="text"> </td>
		</tr>
		<tr>
			<th>품목 구분</th>
			<td><input type="text"> </td>
		</tr>
		<tr>
			<th>대표 이미지</th>
			<td><input type="text"> </td>
		</tr>
	</tr>
	<c:forEach var="products" items="${product }">
	<tr>
		<td><input type="checkbox">${product.prod_idx }</td>	
		<td><a href="javascript:void(0);" onclick="">${product.prod_code }</a></td>	
		<td><a href="javascript:void(0);" onclick="">${product.prod_name }</a></td>	
		<td><a href="javascript:wh_infoName('${warehouse.wh_cd}','${warehouse.wh_name}');">${warehouse.wh_name }</a></td>	
		<td>${warehouse.wh_gubun }</td>	
		<td>${warehouse.wh_man_name }</td>	
		<c:if test="${warehouse.wh_use eq '1'}">
		<td>사용</td>	
		</c:if>
		<c:if test="${warehouse.wh_use eq '2'}">
		<td>미사용</td>
		</c:if>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="2" align="right">
			<input type="submit" value="저장">
		</td>	
	</tr>	
	
</table>



</body>
</html>