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
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

<script type="text/javascript">
// function newBuyer() {
// 	let width = 800;
// 	let height = 400;
// 	let left = (window.screen.width / 2) - (width / 2);;
//     let top = Math.ceil(( window.screen.height - height )/2); 
	
// 	url = "BuyerRegisterForm"; 
// 	let name = "BuyterRegister";
// 	let attr = "width=800, height=400, top="+top + ", left=" + left;
// 	window.open(url, name, attr);
// }

</script>
</head>
<body>
<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
                        <h3>거래처 조회</h3>
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>거래처코드</th>
                                            <th>거래처명</th>
                                            <th>대표자명</th>
                                            <th>전화번호</th>
                                            <th>담당자 전화번호</th>
                                            <th>주소</th>
                                            <th>홈페이지</th>
                                            <th>비고</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                    </tfoot>
                                    <tbody>
                                      <c:forEach var="buyerList" items="${buyerList }">
										<tr>
										<td><a href="BuyerDetail?business_no=${buyerList.business_no }"> ${buyerList.business_no }</a></td>
										<td><a href="BuyerDetail?business_no=${buyerList.business_no }">${buyerList.cust_name }</a></td>
										<td>${buyerList.boss_name }</td>
										<td>${buyerList.tel }</td>
										<td>${buyerList.man_tel }</td>
										<td>${buyerList.addr }</td>
										<td>${buyerList.man_home }</td>
										<td>${buyerList.remarks }</td>
										</tr> 
										</c:forEach>  
                                    </tbody>
                                </table>
<!-- 	<button onclick="newBuyer()">신규등록</button> -->
	<button onclick="location.href='BuyerRegisterForm'">신규등록</button>
	
	


  <!-- 테이블 템플릿 css/js -->
  <script src="${path}/resources/js/scripts.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
  <script src="${path}/resources/js/datatables-simple-demo.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>