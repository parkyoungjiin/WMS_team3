<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<!-- 거래처(기본 등록) 권한 판별 -->
<style type="text/css">
*{margin:0; padding:0;}
ul{list-style:none;}
a{text-decoration:none; color:#333;}
.wrap{padding:15px; letter-spacing:-0.5px;}
.tab_menu{position:relative;}
.tab_menu .list{overflow:hidden;}
.tab_menu .list li{float:left; margin-right:14px;}
.tab_menu .list .btn{font-size:13px;}
.tab_menu .list .cont{display:none; position:absolute; top:25px; left:0; background:#555; color:#fff; text-align:center; width:250px; height:100px; line-height:100px;}
.tab_menu .list li.is_on .btn{font-weight:bold; color:green;}
.tab_menu .list li.is_on .cont{display:block;}
</style>
<script type="text/javascript">
// 	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
// 	var priv_cd_res = str.charAt(0); // 기본등록(0) 여부 판별할 값
// 	var priv_cd_pro = str.charAt(3); // 재고조회(3) 여부 판별할 값
// 	var priv_cd_pro2 = str.charAt(4); // 재고관리(4) 여부 판별할 값
	
// 	//기본등록에 대한 권한이 있는 지 판별
// 	if(priv_cd_res == '1' || priv_cd_pro == '1' || priv_cd_pro2 == '1'){//권한이 있을 경우
		
// 	}else{//없을 경우
// 		alert("권한이 없습니다");
// 		history.back();
// 	}
	
	// 체크박스 선택 jQuery
// 	$(document).ready(function() {
// 		$("#chkAll").click(function() {
// 			if($("#chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
// 			else $("input[name=chk]").prop("checked", false);
// 		});
	
// 		$("input[name=chk]").click(function() {
// 			var total = $("input[name=chk]").length;
// 			var checked = $("input[name=chk]:checked").length;
		
// 			if(total != checked) $("#chkAll").prop("checked", false);
// 			else $("#chkAll").prop("checked", true); 
// 		});
// 	});

	// 종결 상태 변경 (DB에도 값 변경해야함)
	function compCng(cc){
		var cIdx = cc.id.replace("btnComp", "");
		var btnVal = $("#btnComp" + cIdx).val();
		var in_cd = $("#IN_SCHEDULE_CD" + cIdx).val();
		console.log("확인 작업 : " + btnVal + cIdx);
		
			if(btnVal=="취소") { // 취소버튼이 활성화일때는 해당상태가 1 > 클릭시 0(미완료 상태)으로 변경
// 				alert(btnVal);
				$.ajax({
					type: "get",
					url: "InComplete?IN_SCHEDULE_CD=" + in_cd,
					data: {
						IN_COMPLETE: "0" // 미완료 상태로 변경
					},
					dataType: "html",
					success: function(data) {
						var check = confirm('종결된 입고를 취소하시겠습니까?');
						 if (check) {
						 	alert('입고가 완료되지 않았습니다.');
							$("#btnComp" + cIdx).attr("value","종결");
						 }
						 else {
						     alert('입고상태 변경이 취소되었습니다.');
						 }
					},
					error: function(xhr, textStatus, errorThrown) {
	 					alert("진행상황 변경 실패"); 
		 				}
				});
			} else if(btnVal=="종결") { // 종결버튼이 활성화 되어있다는 것은 미완료 상태라는 뜻
// 				alert(btnVal);
				$.ajax({
					type: "get",
					url: "InComplete?IN_SCHEDULE_CD=" + in_cd,
					data: {
						IN_COMPLETE: "1"
					},
					dataType: "html",
					success: function(data) {
						 var check = confirm('해당 입고를 종결하시겠습니까?');
						 if (check) {
						 	alert('입고가 완료되었습니다.');
							$("#btnComp" + cIdx).attr("value","취소");
						 }
						 else {
						     alert('입고상태 변경이 취소되었습니다.');
						 }
					},
					error: function(xhr, textStatus, errorThrown) {
	 					alert("진행상황 변경 실패"); 
		 				}
				});
			}

	}
</script>

<!-- 진행상태 조회 -->
<script type="text/javascript">
	function checkIdx(cb) {
		var ck_idx = cb.id.replace("scSearch", ""); // checkIdx 함수의 id 값 scSearch 를 공백으로 바꾸면 남는 값이 idx값이 됨
		var in_cd = $("#IN_SCHEDULE_CD" + ck_idx).val(); // out_cd hidden 으로 숨겨져 있는 input의 out_schedule~+위의 구해진 idx값이 id인 곳으로 가서 value값 가져옴
		alert(ck_idx);	
		alert(in_cd);

		$.ajax({
			type:"GET"
			,url: "InListProd?IN_SCHEDULE_CD=" + in_cd
// 			,data: {
// 				out_schedule_cd: out_cd
// 			} // 컨트롤러에 @Responsebody 없으니까 fail 리턴됨
			,dataType: "json"
		})
		.done(function(inProdList) {
			console.log(inProdList);
			for(let prod of inProdList) {
// 				let product_cd = ${prod.out_product_cd}
				$("#out > tbody").empty();
				var inList = '<tr>' 
							  + '<td>' + prod.PRODUCT_CD + '</td>'
							  + '<td>' + prod.PRODUCT_NAME + '</td>'
							  + '<td>' + prod.IN_SCHEDULE_QTY + '</td>'
							  + '<td>' + prod.IN_SCHEDULE_QTY + '</td>'
							  + '</tr>'
				console.log(inList);				
				$("#in > tbody").append(inList);
			}
		})
		.fail(function() {
// 			console.log(osut_cd);
			$("#modal-body").html("<h5>요청 실패!</h5>");
		});
		
	}
	
	
	
</script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>입고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>



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
      <h1>입고 관리</h1>
    </div><!-- End Page Title -->
    
    <div class="card mb-4">
  <div class="card-header">
                     입고 예정 목록
                     <button class="btn btn-primary" onclick="location.href='InRegisterForm'" style="float: right;">신규등록</button>
                 </div>
              
  
                 <div class="card-body" style="padding-top:30">
                 
                  <!-- Default Tabs -->
              <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                  <button class="nav-link active tab-css" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" style="font-size:15px;" aria-selected="true">전체</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link tab-css" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" style="font-size:15px;" aria-selected="false">진행중</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link tab-css" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" style="font-size:15px;"  aria-controls="contact" aria-selected="false">완료</button>
                </li>
              </ul>
              <div class="tab-content pt-2" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                 	<table class="table table-hover">
		                <thead>
		                  <tr>
		                    <th scope="col"></th>
		                    <th scope="col"></th>
		                    <th scope="col">입고예정번호</th>
		                    <th scope="col">유형</th>
		                    <th scope="col">보낸곳명</th>
		                    <th scope="col">담당자명</th>
		                    <th scope="col">품목명[규격]</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">입고예정수량합계</th>
		                    <th scope="col">종결여부</th>
		                    <th scope="col">진행상태</th>
		                  </tr>
		                </thead>
		                 <tbody>
                          <c:forEach var="isList" items="${islist }" varStatus="status">
							<tr>
										
<%-- 	<td>${idx.count }</td> --%>
							<th scope="row"></th>
							<td> 
							<input type="hidden" id="IN_SCHEDULE_CD${status.index}" value="${isList.IN_SCHEDULE_CD }">
		                    <input type="hidden" id="InComplete${status.index}" value="${isList.IN_COMPLETE }">
		                    </td>
						<td><a href="InDetail?IN_SCHEDULE_CD=${isList.IN_SCHEDULE_CD }">${isList.IN_SCHEDULE_CD }</a></td> <!-- 입고예정번호 -->
		                    <td>${isList.IN_TYPE_CD }</td> <!-- 유형 -->
		                    <td>${isList.CUST_NAME}</td> <!-- 보낸곳명 -->
		                    <td>${isList.EMP_NAME}</td>	<!-- 담당자명 -->
		                    <td>${isList.PRODUCT_NAME }</td> <!-- 품목명 pro--> 
		                    <td>${isList.IN_DATE}</td> <!-- 납기일자 -->
		                    <td></td> <!-- 입고예정량합계 -->
		                       <td>
		                    	<c:choose>
		                    		<c:when test="${isList.IN_COMPLETE eq '1'}">
										<input type="button"  id="btnComp${status.index}" class="btn btn-sm btn-secondary" value="취소" onclick="compCng(this)">
		                    		</c:when>
		                    		<c:when test="${isList.IN_COMPLETE eq '0'}">
		                    			<input type="button" id="btnComp${status.index}" class="btn btn-secondary btn-sm" value="종결" onclick="compCng(this)">
		                    		</c:when>
		                    	</c:choose>
		                    </td> 
		                    <td><button class="btn btn-secondary btn-sm" id="scSearch${status.index}" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_complete" onclick="checkIdx(this)">조회</button></td>
								
							</tr> 
							</c:forEach>  
                        </tbody>
		              </table>
           </div> <!-- 1번탭 끝 -->
           
            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab"> <%-- 진행 --%>
            <table class="table table-hover">
		                <thead>
		                  <tr>
		                    <th scope="col"></th>
		                    <th scope="col"></th>
		                    <th scope="col">입고예정번호</th>
		                    <th scope="col">유형</th>
		                    <th scope="col">보낸곳명</th>
		                    <th scope="col">담당자명</th>
		                    <th scope="col">품목명[규격]</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">입고예정수량합계</th>
		                    <th scope="col">종결여부</th>
		                    <th scope="col">진행상태</th>
		                  </tr>
		                </thead>
		                 <tbody>
                          <c:forEach var="isList" items="${islist }" varStatus="idx">
                          <c:if test="${isList.IN_COMPLETE eq '1' }">

							<tr>
							<th scope="row"></th>
										
<%-- 	<td>${idx.count }</td> --%>
							<td> 
							<input type="hidden" id="IN_SCHEDULE_CD${status.index}" value="${isList.IN_SCHEDULE_CD }">
		                    <input type="hidden" id="InComplete${status.index}" value="${isList.IN_COMPLETE }"></td>
						<td><a href="InDetail?IN_SCHEDULE_CD=${isList.IN_SCHEDULE_CD }">${isList.IN_SCHEDULE_CD }</a></td> <!-- 입고예정번호 -->
		                    <td>${isList.IN_TYPE_CD }</td> <!-- 유형 -->
		                    <td>${isList.CUST_NAME}</td> <!-- 보낸곳명 -->
		                    <td>${isList.EMP_NAME}</td>	<!-- 담당자명 -->
		                    <td>${isList.PRODUCT_NAME }</td> <!-- 품목명 pro--> 
		                    <td>${isList.IN_DATE}</td> <!-- 납기일자 -->
		                    <td></td> <!-- 입고예정량합계 -->
		                       <td>
		                    	<c:choose>
		                    		<c:when test="${isList.IN_COMPLETE eq '1'}">
										<input type="button"  id="btnComp${status.index}" class="btn btn-sm btn-secondary" value="취소" onclick="compCng(this)">
		                    		</c:when>
		                    		<c:when test="${isList.IN_COMPLETE eq '0'}">
		                    			<input type="button" id="btnComp${status.index}" class="btn btn-secondary btn-sm" value="종결" onclick="compCng(this)">
		                    		</c:when>
		                    	</c:choose>
		                    </td> 
		                    <td><button class="btn btn-secondary btn-sm" id="scSearch${status.index}" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_complete" onclick="checkIdx(this)">조회</button></td>
								
							</tr>
							</c:if> 
							</c:forEach>  
                        </tbody>
		              </table>
           </div> <!-- 2번탭 끝 -->
            
            <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab"> <%--3번탭 시작 --%> 
             <table class="table table-hover">
		                <thead>
		                  <tr>
		                    <th scope="col"></th>
		                    <th scope="col"></th>
		                    <th scope="col">입고예정번호</th>
		                    <th scope="col">유형</th>
		                    <th scope="col">보낸곳명</th>
		                    <th scope="col">담당자명</th>
		                    <th scope="col">품목명[규격]</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">입고예정수량합계</th>
		                    <th scope="col">종결여부</th>
		                    <th scope="col">진행상태</th>
		                  </tr>
		                </thead>
		                <tbody>
		                
		                </tbody>
		                 <tbody>
                          <c:forEach var="isList" items="${islist }" varStatus="status">
                          <c:if test="${isList.IN_COMPLETE eq '0' }">

							<tr>
										
	<td>${idx.count }</td>
							<td> 
							<input type="hidden" id="IN_SCHEDULE_CD${status.index}" value="${isList.IN_SCHEDULE_CD }">
		                    <input type="hidden" id="InComplete${status.index}" value="${isList.IN_COMPLETE }"></td>
						<td><a href="InDetail?IN_SCHEDULE_CD=${isList.IN_SCHEDULE_CD }">${isList.IN_SCHEDULE_CD }</a></td> <!-- 입고예정번호 -->
		                    <td>${isList.IN_TYPE_CD }</td> <!-- 유형 -->
		                    <td>${isList.CUST_NAME}</td> <!-- 보낸곳명 -->
		                    <td>${isList.EMP_NAME}</td>	<!-- 담당자명 -->
		                    <td>${isList.PRODUCT_NAME }</td> <!-- 품목명 pro--> 
		                    <td>${isList.IN_DATE}</td> <!-- 납기일자 -->
		                    <td></td> <!-- 입고예정량합계 -->
		                       <td>
		                    	<c:choose>
		                    		<c:when test="${isList.IN_COMPLETE eq '1'}">
										<input type="button"  id="btnComp${status.index}" class="btn btn-sm btn-secondary" value="취소" onclick="compCng(this)">
		                    		</c:when>
		                    		<c:when test="${isList.IN_COMPLETE eq '0'}">
		                    			<input type="button" id="btnComp${status.index}" class="btn btn-secondary btn-sm" value="종결" onclick="compCng(this)">
		                    		</c:when>
		                    	</c:choose>
		                    </td> 
		                    <td><button class="btn btn-secondary btn-sm" id="scSearch${status.index}" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_complete" onclick="checkIdx(this)">조회</button></td>
								
							</tr>
							</c:if> 
							</c:forEach>  
                        </tbody>
		              </table>
            
            
   			</div> <!-- 3번탭 끝 -->
   			  </div> 
   			  </div>
   			   </div>
   			

<script>
  const tabList = document.querySelectorAll('.tab_menu .list li');
  
  for(var i = 0; i < tabList.length; i++){
    tabList[i].querySelector('.btn').addEventListener('click', function(e){
      e.preventDefault();
      for(var j = 0; j < tabList.length; j++){
        tabList[j].classList.remove('is_on');
      }
      this.parentNode.classList.add('is_on');
    });
  }
</script>
    
    
    
    
          
</main>		


  <!-- 테이블 템플릿 css/js -->
  <script src="${path}/resources/js/scripts.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
  <script src="${path}/resources/js/datatables-simple-demo.js"></script>
<!--   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
  
</body>
</html>