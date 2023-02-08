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
		history.back();
	}
</script>
<!-- 재고 수량 조정작업 -->
<script type="text/javascript">
	function updateStock(cb) {
// 		//조정 수량
// 		var updateStockNum = $("#updateStockNum0").val();
// 		//재고 번호
		
		//버튼에 status.index 해둔 값을 추출 하는 작업
		var idx = cb.id.replace("updateButton", "");//updateButton을 공백으로 만들어서 status.index 값 출력 
		console.log("index_ck : " + idx)
		var updateStockNum = $("#updateStockNum" + idx).val(); //조정 수량
		var stock_cd = $("#stock_cd" + idx).val();//재고 번호
		var product_cd = $("#product_cd" + idx).val();//품목 번호
		
		
		if(updateStockNum == ""){
			alert("조정 할 수량을 입력하세요")
			$('#updateStockNum' + idx).focus();
		}else{
			let confirmUpdate = confirm("재고를 "+updateStockNum +"개로 조정하시겠습니까?");
			
			if(confirmUpdate){
				$.ajax({
					url: 'StockUpdate.st',
					type: 'post',
					data: {
						updateStockNum : updateStockNum,
						stock_cd : stock_cd,
						product_cd : product_cd
					},
					success: function(result) {
						if(result > 0){
							alert("재고가 조정 되었습니다.")
							location.reload();
						}else{
							alert("재고 조정에 실패했습니다.")
							location.reload();
						}
					}//success 끝
				})//ajax 끝
			}else{
				alert("재고 조정작업이 취소되었습니다.")		
			}
		}
		
		

	}//updateStock 끝
	
	
	
	
	
</script>
<script type="text/javascript">
	//--------모달창에서 재고번호, 창고위치 클릭 시 해당 값을 이동재고번호/이동위치 input 박스 안에 값 넣는 함수-----------
function saveIdx(cb) {
		var idx = cb.id.replace("search_move_cd", ""); //클릭한 버튼의 idx값 출력 -> 이동재고번호, 이동위치에 넣을 위치 !
		alert("tr클릭 전 idx : " + idx)
		$("#stock_table").on('click','tr',function(){

		   let td_arr = $(this).find('td');
		   console.log(td_arr);
		   
		   let stock_no = $(td_arr[0]).text(); //재고번호
		   let move_wh_loc_in_area = $(td_arr[1]).text(); //창고위치
		   console.log(move_wh_loc_in_area);
		   
			
		   // td 클릭시 모달 창 닫기
		   alert("tr클릭 후 idx : " + idx)
		   $('#modalDialogScrollable_stock_cd').modal('hide');
		   $("#move_stock_cd" + idx).val(stock_no);
		   $("#move_wh_loc_in_area" + idx).val(move_wh_loc_in_area);
		});
	
}//saveIdx 끝

//재고번호 목록 조회(모달)
function load_stockList() {
	
	let stock_keyword = $("#stock_keyword").val();
	
// 	alert(buyer_keyword);
	
	$.ajax({
		type: "GET",
		url: "StockListJson?keyword=" + stock_keyword,
		dataType: "json"
	})
	.done(function(stockList) { // 요청 성공 시
// 			$(".modal-body").append(buyerList);
		console.log(stockList)
		if(stockList.length == 0){
			$("#buyer_search").html("<div>등록된 데이터가 없습니다.</div>");
			$("#buyer_search").css("color","#B9062F");
		} 
// 		else {
// 			$("#buyer_search").remove();
// 		}
//             $("#modal-body > td").empty();	
// 		 $("#modal-body-stock > table").empty();   //테이블 비우기
	
// 	  let result1 = "<table class='table table-hover' id='stock_table' style='margin-left: auto; margin-right:'>"
//              	 + "<tr>"
//                  + "<th scope='col'>재고번호</th>"
//                  + "<th scope='col'>창고명(구역명)</th>"
//                  + "<th scope='col'>창고위치</th>"
//                   + "</tr>";

                  
//  	         $("#modal-body-stock > table").append(result1);

// 	         $("#modal-body-stock > table > td").html("");
		 
		for(let stock of stockList) {
			console.log(stock.stock_cd)
			console.log(stock.wh_name)
			console.log(stock.wh_area)
			console.log(stock.wh_loc_in_area)
	         let result = "<tr style='cursor:pointer;'>"
		                      + "<td id='stock_cd'>" + stock.stock_cd + "</td>"
		                      + "<td id='wh_name'>" + stock.wh_name + "(" + stock.wh_area + "구역)" + "</td>"
		                      + "<td id='wh_loc_in_area'>" + stock.wh_loc_in_area + "</td>"
                        + "</tr>"
                        + "</table>";
                        
	         $("#modal-body-stock > table").append(result);
		}
	})//done 끝
	.fail(function() {
		$("#modal-body-stock > table").append("<h3>요청 실패!</h3>");
	});//fail 끝
}//stockList 끝
//========================재고 이동 작업=====================================
function move_stock(move_cb) {
		var idx = move_cb.id.replace("moveButton",""); //index 값 저장
		var current_stock_cd = $("#stock_cd" + idx).val(); //현재 재고번호
		var move_stock_cd = $("#move_stock_cd" + idx).val(); //이동 할 재고번호
		var move_wh_loc_in_area = $("#move_wh_loc_in_area" + idx).val();//이동 위치
		var move_stock_num = $("#move_stock_num" + idx).val();//이동할 수량
		var product_cd = $("#product_cd" + idx).val();//품목 번호
		
// 		alert(current_stock_cd)
// 		alert(move_stock_cd);
// 		alert(move_wh_loc_in_area);
// 		alert("move_stock_num : " + move_stock_num);
		
		
// 		if(move_stock_cd == ""){
// 			alert("이동 재고번호를 입력하세요")
// 			$('#move_stock_cd' + idx).focus();
// 		}else if(move_wh_loc_in_area ==""){
// 			alert("이동 위치를 입력하세요")
// 			$('#move_wh_loc_in_area' + idx).focus();
// 		}else if(move_stock_num =""){
// 			alert("이동 수량을 입력하세요")
// 			$('#move_stock_num' + idx).focus();
// 		}else{
		if(move_stock_cd == "" || move_wh_loc_in_area =="" || move_stock_num==""){
			alert("빈칸을 채워주세요")
		}else if(move_stock_cd == current_stock_cd){
			alert("이동재고번호가 현재 재고번호입니다. 다시 수정해주세요")
		}else{
			console.log(" move_stock_num : 개수 " + move_stock_num);
			let confirmMove = confirm("재고번호" + current_stock_cd + "에서 재고번호" + move_stock_cd + "로 재고" + move_stock_num +"개를 이동하시겠습니까?");
			
			if(confirmMove){
				$.ajax({
					url: 'stockMove.st',
					type: 'post',
					data: {
						current_stock_cd : current_stock_cd,
						move_stock_cd : move_stock_cd,
						move_wh_loc_in_area : move_wh_loc_in_area,
						move_stock_num : move_stock_num,
						product_cd : product_cd
					},
					success: function(result) {
						if(result > 0){
							alert("재고가 이동 되었습니다.")
							location.reload();
						}else{
							alert("재고 이동에 실패했습니다.")
							location.reload();
						}
					}//success 끝
				})//ajax 끝
			}else{
				alert("재고 조정작업이 취소되었습니다.")		
			}
		}
		
		
}//move_stock 끝

</script>
<script type="text/javascript">
// ---------재고번호 클릭 시 해당 재고이력을 모달 창으로 출력---------------
function save_stock_cd(cb) {
	var idx = cb.id.replace("save_stock_cd", "");
	var stock_cd = $("#stock_cd" + idx).val(); //현재 재고번호  cbf
	alert(stock_cd)
	$.ajax({
		url: 'StockHistoryList.st',
		type: 'post',
		data: {
			stock_cd : stock_cd
		},
		dataType: "json"
	})//ajax 끝
		.done(function(stockHistoryList) {
			if(stockHistoryList != null){
				
				$("#stock_history_div > table").remove();   
				$("#stock_history_div > table > tr").remove();   

				
				
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
				alert("목록 없음")
			}
			
		})//success 끝
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
<!--                               				<th scope="col">#</th> -->
                               <th>재고번호</th>
                               <th>품목코드</th>
                               <th>품목명</th>
                               <th>창고명(구역명)</th>
                               <th>위치명</th>
                               <th>재고수량</th>
                               <th>조정수량 </th>
                               <th>이동재고번호</th>
                               <th>이동위치</th>
                               <th>이동수량</th>
                               <th>재고조정 및 이동</th>
                           </tr>
                       </thead>
                      <tbody>
                                 <c:forEach var="stockList" items="${stockList }" varStatus="status">
							<tr>
<!-- 										<td><input type="checkbox"></td> -->
<!-- 										<td scope="row"></td> -->
								<td>
								<a href="#" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_history" onclick="save_stock_cd(this)" id="save_stock_cd${status.index}"> ${stockList.stock_cd}</a>
								</td>
								<td><a href="#" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_history">${stockList.product_cd }</a></td>
								<td>${stockList.product_name }</td>
								<td>${stockList.wh_name }(${stockList.wh_area }구역)</td>
								<td>${stockList.wh_loc_in_area }</td>
								<td>${stockList.stock_qty }</td> 
								<td>
								<!-- 재고조정에 필요한 재고번호(히든) -->
								<input type="hidden" id="stock_cd${status.index}" value="${stockList.stock_cd}">
								<!-- 재고조정에 필요한 품목번호(히든) -->
								<input type="hidden" id="product_cd${status.index}" value="${stockList.product_cd}">
								<!-- 재고조정에 필요한 조정수량 -->
								<input type="number" class="form-control-sm" id="updateStockNum${status.index}" max="${stockList.stock_qty }" min="0">
								
								</td>
								<!-- 이동재고번호 input, 검색 button -->
								<td>
								<input type="text" size="3" class="form-control-sm" id ="move_stock_cd${status.index}">
								<button id="search_move_cd${status.index}" class="btn btn-secondary btn-sm" type="button" onclick="saveIdx(this)"  data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_cd">검색</button>
								</td>
								<!-- 이동 위치 -->
								<td>
								<input type="text" size="5" class="form-control-sm" id ="move_wh_loc_in_area${status.index}" >
								</td>
								<!-- 이동 수량 -->
								<td><input type="text" size="3" class="form-control-sm" id ="move_stock_num${status.index}"></td>
								<!-- 재고이동버튼 -->
								<td>
								<!-- 재고조정 버튼 -->
								<button id="updateButton${status.index}" class="btn btn-secondary btn-sm" type="button" onclick="updateStock(this)">재고조정</button>
								<button id="moveButton${status.index}" class="btn btn-secondary btn-sm" type="button" onclick="move_stock(this)">재고이동</button>
								</td>
							</tr> 
							</c:forEach>  
                        </tbody>
                    </table>
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
			        	 	<table class='table table-hover' id="stock_table" style="margin-left: auto; margin-right: ">
				        	 		<tr>
				        	 			<th scope="col">재고번호</th>
				        	 			<th scope="col">창고명(구역명)</th>
				        	 			<th scope="col">창고위치</th>
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