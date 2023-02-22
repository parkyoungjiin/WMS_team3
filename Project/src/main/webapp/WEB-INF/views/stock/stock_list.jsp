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
<title>재고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

<!-- 권한 여부 판별하여 인사부서인지 판별 -->
<script type="text/javascript">
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_emp = str.charAt(3); // 재고조회(3) 여부 판별할 값
	var priv_cd_emp2 = str.charAt(4); // 사원관리(2) 여부 판별할 값
	
	//사원조회, 사원관리에 대한 권한이 있는 지 판별
	if(priv_cd_emp == '1' || priv_cd_emp2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("재고관리 권한이 없습니다");
		location.href ="EmpLoginForm.em";
	}
</script>
<!--체크박스 작업 -->
<script type="text/javascript">
// 체크박스 선택 jQuery
	$(document).ready(function() {
		$("#chkAll").click(function() {
			if($("#chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
			else $("input[name=chk]").prop("checked", false);
		
		});
	
		$("input[name=chk]").click(function() {
			var total = $("input[name=chk]").length;
			var checked = $("input[name=chk]:checked").length;
		
			if(total != checked) $("#chkAll").prop("checked", false);
			else $("#chkAll").prop("checked", true); 
		});
	});
	
	//-------------재고선택 후 조정버튼 클릭 시 팝업창 ----------------
	
	function stock_process() {
		var genreArray = new Array();

	    $('input:checkbox[name=chk]:checked').each(function() {
	        genreArray.push(this.value);
	    });
		alert(genreArray)
	    window.open("stockWork.st?stock_cdArr="+genreArray, "재고작업", "width=1200, height=750, top=50, left=50");
	}
	

</script>

<!-- 재고이력 확인  -->
<script type="text/javascript">
// ---------재고번호 클릭 시 해당 재고이력(History)을 모달(Modal) 창으로 출력---------------
function check_history1(cb) {
	var idx=cb.id.replace("save_stock_cd", "");
	alert(idx);
	var stock_cd =  $("#chk" + idx).val(); //현재 재고번호
	alert(stock_cd);
// 	alert($("#stock_cd_num0").val());
	$.ajax({
		url: 'StockHistoryList.st',
		type: 'post',
		data: {
			stock_cd : stock_cd
		},
		dataType: "json"
	})//ajax 끝
		.done(function(stockHistoryList) {
			if(stockHistoryList != null && stockHistoryList != ""){
				
				$("#stock_history_div > h3").remove();   
				$("#stock_history_div > table").remove();   
// 				$("#stock_history_div > table > h3").remove();   

				
				
				let result = '<table class="table table-hover" id="stock_history_table" style="margin-left: auto; margin-right: ">'
				+ "<tr>"
				+ "<h3 style='text-align: center;'>재고번호: " + stock_cd + "번</h3>"
				+ "</tr>"
				+ '<tr>'
	 			+ '<th scope="col">작업일자</th>'
	 			+ '<th scope="col">작업구분</th>'
	 			+ '<th scope="col">품목명</th>'
	 			+ '<th scope="col">보낸 재고번호</th>'
	 			+ '<th scope="col">받은 재고번호</th>'
	 			+ '<th scope="col">작업수량</th>'
	 			+ '<th scope="col">작업자 명</th>'
	 			+ '<th scope="col">적요</th>'
	 			+ '</tr>'
 				+ '</table>';

	 			
				$("#stock_history_div").append(result);

			
				for(let stockHistory of stockHistoryList) {
					
					let result2 = 
					
					"<tr style='cursor:pointer;'>"
	                + "<td>" + stockHistory.stock_date + "</td>"
	                + "<td>" + stockHistory.stock_control_type_name + "</td>"
	                + "<td>" + stockHistory.product_name + "</td>"
	                + "<td>" + stockHistory.source_stock_cd + "</td>"
	                + "<td>" + stockHistory.target_stock_cd + "</td>"
	                + "<td>" + stockHistory.qty + "</td>"
	                + "<td>" + stockHistory.emp_name + "</td>"
	                + "<td>" + stockHistory.remarks + "</td>"
           			+ "</tr>";

		             
					$("#stock_history_table").append(result2);
				}
			}else{
				$("#stock_history_div > h3").remove();   
				$("#stock_history_div > table").remove();   
// 				$("#stock_history_div > table > h3").remove();   

				
				
				let result = '<table class="table table-hover" id="stock_history_table" style="margin-left: auto; margin-right: ">'
				+ "<tr>"
				+ "<h3 style='text-align: center;'>재고번호: " + stock_cd + "번</h3>"
				+ "</tr>"
				+ '<tr>'
	 			+ '<th scope="col">작업일자</th>'
	 			+ '<th scope="col">작업구분</th>'
	 			+ '<th scope="col">품목명</th>'
	 			+ '<th scope="col">보낸 재고번호</th>'
	 			+ '<th scope="col">받은 재고번호</th>'
	 			+ '<th scope="col">작업수량</th>'
	 			+ '<th scope="col">작업자 명</th>'
	 			+ '<th scope="col">적요</th>'
	 			+ '</tr>'
 				+ '</table>';
 				
				$("#stock_history_div").append(result);
				
				let no_result = 
					"<tr style='cursor:pointer;'>"
					+ "<td colspan='8'><h3>재고 이력이 없습니다.</h3></td>"
           			+ "</tr>";

				$("#stock_history_table").append(no_result);

			}
			
		})//success 끝
 }
</script>
<!-- 재고이력 확인 ( 팝업창 )  -->
<script type="text/javascript">
function check_history(cb){
	var idx=cb.id.replace("save_stock_cd", "");
	alert(idx);
	var stock_cd =  $("#chk" + idx).val(); //현재 재고번호
	alert(stock_cd);
	
    window.open("StockHistoryList.st?stock_cd="+stock_cd, "재고이력", "width=1200, height=750, top=50, left=50");

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
      <h1>재고 관리</h1>
    	</div><!-- End Page Title -->
            <div class="card mb-4">
                <div class="card-header">
                     재고 조회
<!--                      <button class="btn btn-secondary" onclick="location.href='BuyerRegisterForm'" style="float: right;">재고조정</button> -->
<!--                      <button class="btn btn-secondary" onclick="location.href='BuyerRegisterForm'" style="float: right;">재고이동</button>&nbsp; -->
                 </div>
                 <div class="card-body">
                     <table id="datatablesSimple" style="">
                         <thead>
                             <tr>
                               <th><input type="checkbox" id="chkAll"></th>
                               <th>재고번호</th>
                               <th>품목코드</th>
                               <th>품목명</th>
                               <th>창고명(구역명)</th>
                               <th>위치명</th>
                               <th>재고수량</th>
                               
                           </tr>
                       </thead>
                      <tbody>
                                 <c:forEach var="stockList" items="${stockList }" varStatus="status">
							<tr>
								<!-- 체크박스  -->
								<td><input type="checkbox" id="chk${status.index }" name="chk" value="${stockList.stock_cd }"></td>
								<td>
								<!-- 재고번호  -->
<%-- 								<a href="#" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_history" onclick="check_history(this)" id="save_stock_cd${status.index}">${stockList.stock_cd}</a> --%>
								<a href="#" onclick="check_history(this)" id="save_stock_cd${status.index}">${stockList.stock_cd}</a>
								</td>
								<!-- 품목코드  -->
								<td>${stockList.product_cd }</td>
								<td>${stockList.product_name }</td>
								<td>${stockList.wh_name }(${stockList.wh_area })</td>
								<td>${stockList.wh_loc_in_area }</td>
								<td>${stockList.stock_qty }</td> 
							</tr> 
								<input type="hidden" id="stock_cd_num${status.index}" value="${stockList.stock_cd }">
								<input type="hidden" id="product_cd${status.index}" value="${stockList.product_cd }">
								<input type="hidden" id="stock_qty${status.index}" value="${stockList.stock_qty }">
								
							</c:forEach>
                        </tbody>
                    </table>
                       		<button id="search_stock" class="btn btn-primary" type="button" onclick="stock_process()">조정</button>
                </div>
            </div>
            
             <!-- Modal Dialog Scrollable -->
			 <!-- 이동재고번호 검색 -->
              <div class="modal fade" id="modalDialogScrollable_stock_cd" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">이동재고번호 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id ="modal-body-stock">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="stock_keyword" placeholder="검색 후 이용 바랍니다.">
				         <button id="search_stock" class="btn btn-primary" type="button" onclick="load_stockList()">검색</button>
			        	 </div>
			        	 	<table class='table table-hover' id="stock_table" style="margin-left: auto; margin-right:; text-align: left: ;">
				        	 		<tr>
				        	 			<th scope="col" width="151px">재고번호</th>
				        	 			<th scope="col" width="157px">창고명(구역명)</th>
				        	 			<th scope="col" width="157px">창고위치</th>
				        	 		</tr>
			        	 	</table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
              
			<!-- 재고 번호 클릭 시 재고이력 목록 -->              
              <!-- Extra Large Modal -->
         
              <div class="modal fade" id="modalDialogScrollable_stock_history" tabindex="-1">
                <div class="modal-dialog modal-xl">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" style="text-align: center;">재고이력</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-stockHistory" style="text-align: center;">
                    
	                    <div class="input-group mb-6" id ="stock_history_div">
	                    <!-- 조회 클릭 시 table이 ajax로 들어가는 영역 -->
			        	 </div>
				        	 
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Extra Large Modal-->
              
             
</main>		


  <!-- 테이블 템플릿 css/js -->
  <script src="${path}/resources/js/scripts.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
  <script src="${path}/resources/js/datatables-simple-demo.js"></script>
<!--   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
  
</body>
</html>