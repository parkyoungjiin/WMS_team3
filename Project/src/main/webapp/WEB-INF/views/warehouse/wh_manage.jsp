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
<!-- css -->
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<meta charset="UTF-8">
<!-- 테이블  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 테이블 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>	
<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 창고 등록 창 뜨게 하기 -->
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
//업태, 종목 항목 input 태그 추가
	$(function() {
		$("#plusid").click(function() {
			let result = 
				"<tr><td colspan='6'><input type='text' name='wh_area' id='wh_area' required='required'> &nbsp;"
				+ "<input type='text' name='wh_area_cd' id='wh_area_cd' required='required'>"
				+"</td></tr>";
				$("#tr").after(result);				
		});
	});		
</script>
<title>창고 등록</title>
</head>
<body>
<header>
	<!-- top-->
	<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>

<table id="table" class="table" style="width: 500px; margin-top: 50px;">
	<tr>
		<th colspan="6" style="text-align: center;">창고 등록</th>
	</tr>
	<tr>
		<th>창고코드</th>
		<th>창고명</th>
		<th>구분</th>
		<th>관리자명</th>
		<th>사용여부</th>
		<th>상세</th>
	</tr>
	<c:forEach var="warehouse" items="${whlist }">
	<c:if test="${warehouse.wh_use eq '1' }">
	<tr id="tr">
		<td><a href="javascript:void(0);" onclick="wh_info('${warehouse.wh_cd}')">${warehouse.wh_cd }</a></td>	
		<td><a href="javascript:wh_infoName('${warehouse.wh_cd}','${warehouse.wh_name}');">${warehouse.wh_name }</a></td>	
		<td>${warehouse.wh_gubun }</td>	
		<td>${warehouse.wh_man_name }</td>	
		<c:if test="${warehouse.wh_use eq '1'}">
		<td>사용</td>	
		</c:if>
		<c:if test="${warehouse.wh_use eq '2'}">
		<td>미사용</td>
		</c:if>
		<td>
			 <button class="btn" id="plusid">
			    <div class="inline-flex items-center space-x-2">
			      <div>+</div>
			    </div>
  			</button>
		</td>
	</tr>
	
	</c:if>
	</c:forEach>
	<tr>
		<td colspan="6" align="right">
			<input type="button" value="신규" onclick="wh_insert()">
		</td>	
	</tr>	
</table>



</body>
</html>