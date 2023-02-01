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
		      <h1>거래처</h1>
		    	</div><!-- End Page Title -->
		            <div class="card mb-4">
		                <div class="card-header">
		                     거래처 조회
		                     <button class="btn btn-secondary" onclick="location.href='BuyerRegisterForm'" style="float: right;">신규등록</button>
		                 </div>
		                 <div class="card-body">
		                     <h5 class="card-title">Table with hoverable rows</h5>
		
		              <!-- Table with hoverable rows -->
		              <table class="table table-hover">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
		                    <th scope="col">Name</th>
		                    <th scope="col">Position</th>
		                    <th scope="col">Age</th>
		                    <th scope="col">Start Date</th>
		                  </tr>
		                </thead>
		                <tbody>
		                  <tr>
		                    <th scope="row">1</th>
		                    <td>Brandon Jacob</td>
		                    <td>Designer</td>
		                    <td>28</td>
		                    <td>2016-05-25</td>
		                  </tr>
		                  <tr>
		                    <th scope="row">2</th>
		                    <td>Bridie Kessler</td>
		                    <td>Developer</td>
		                    <td>35</td>
		                    <td>2014-12-05</td>
		                  </tr>
		                  <tr>
		                    <th scope="row">3</th>
		                    <td>Ashleigh Langosh</td>
		                    <td>Finance</td>
		                    <td>45</td>
		                    <td>2011-08-12</td>
		                  </tr>
		                  <tr>
		                    <th scope="row">4</th>
		                    <td>Angus Grady</td>
		                    <td>HR</td>
		                    <td>34</td>
		                    <td>2012-06-11</td>
		                  </tr>
		                  <tr>
		                    <th scope="row">5</th>
		                    <td>Raheem Lehner</td>
		                    <td>Dynamic Division Officer</td>
		                    <td>47</td>
		                    <td>2011-04-19</td>
		                  </tr>
		                </tbody>
		              </table>
		              <!-- End Table with hoverable rows -->
		
		            </div>
		          </div>
		          
		           <div class="card">
            <div class="card-body">
              <h5 class="card-title">Bordered Table</h5>
              <p>Add <code>.table-bordered</code> for borders on all sides of the table and cells.</p>
              <!-- Bordered Table -->
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Position</th>
                    <th scope="col">Age</th>
                    <th scope="col">Start Date</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row">1</th>
                    <td>Brandon Jacob</td>
                    <td>Designer</td>
                    <td>28</td>
                    <td>2016-05-25</td>
                  </tr>
                  <tr>
                    <th scope="row">2</th>
                    <td>Bridie Kessler</td>
                    <td>Developer</td>
                    <td>35</td>
                    <td>2014-12-05</td>
                  </tr>
                  <tr>
                    <th scope="row">3</th>
                    <td>Ashleigh Langosh</td>
                    <td>Finance</td>
                    <td>45</td>
                    <td>2011-08-12</td>
                  </tr>
                  <tr>
                    <th scope="row">4</th>
                    <td>Angus Grady</td>
                    <td>HR</td>
                    <td>34</td>
                    <td>2012-06-11</td>
                  </tr>
                  <tr>
                    <th scope="row">5</th>
                    <td>Raheem Lehner</td>
                    <td>Dynamic Division Officer</td>
                    <td>47</td>
                    <td>2011-04-19</td>
                  </tr>
                </tbody>
              </table>
              </div>
              </div>
              <!-- End Bordered Table -->
		</main>	
</body>
</html>	