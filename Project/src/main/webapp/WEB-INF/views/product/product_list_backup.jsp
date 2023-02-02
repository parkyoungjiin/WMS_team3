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
<!-- css -->
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<!-- 테이블 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 테이블 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>	

<meta charset="UTF-8">

<script type="text/javascript">
	// 상품 등록 창
	function prod_insert() {
		 var popUrl = "ProductInsertForm.pr";
		 var name = "product insert";
		 var attr = "width=900, height=600, top=200, left=510"
		window.open(popUrl,name,attr);
	}

</script>




<title>품목 등록 리스트</title>
</head>
<body>
	<header>
	<!-- top-->
	<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>

<table class="table table-bordered" style="width: 800px; margin-top: 50px;">
	<tr>
		<th colspan="10" style="text-align: center;">품목 등록 리스트</th>
	</tr>
	<tr style="text-align: center">
		<th></th>
		<th>품목 코드</th>
		<th>품목명</th>
		<th>품목 그룹</th>
		<th>규격</th>
		<th>바코드</th>
		<th>입고 단가</th>
		<th>출고 단가</th>
		<th>품목 구분</th>
		<th>대표 이미지</th>
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
		<td colspan="10" align="right">
			<input type="button" value="신규 등록" onclick="prod_insert()">
		</td>	
	</tr>	
	
</table>



</body>
</html>