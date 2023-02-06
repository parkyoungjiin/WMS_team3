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
<!-- 재고 수량 조정작업 -->
<script type="text/javascript">
	function updateStock(cb) {
// 		//조정 수량
// 		var updateStockNum = $("#updateStockNum0").val();
// 		//재고 번호
		
		//버튼에 status.index 해둔 값을 추출 하는 작업
		var idx = cb.id.replace("updateButton", "");//updateButton을 공백으로 만들어서 status.index 값 출력 
		console.log("index_ck : " + idx)
		var updateStockNum = $("#updateStockNum" + idx).val();
		var stock_cd = $("#stock_cd" + idx).val();
// 		alert("updateStockNum : " + updateStockNum);
// 		alert("stock_cd : " + stock_cd);
		
// 			alert(updateStockNum);
// 			alert(stock_cd_num);
			
		
			
			//--------배열을 사용하여 input 박스 값을 넣음.
// 		let chk_arr = new Array();
		
//  		for(var i=0; i<${fn:length(stockList)}; i++ ){
// 			var updateStockNum = $("#updateStockNum" + i).val();
// 			chk_arr.push(updateStockNum);
			
// // 			var stock_cd = $("#stock_cd" + i).val();
// 		}
// 			alert(chk_arr);
		
		
		if(updateStockNum == ""){
			alert("조정 할 수량을 입력하세요")
			$('#updateStockNum' + idx).focus();
		}else{
			let confirmUpdate = confirm("재고를 "+updateStockNum +"개로 조정하시겠습니까?");
			
			if(confirmUpdate){
				$.ajax({
					url: 'stockUpdate.st',
					type: 'post',
					data: {
						updateStockNum : updateStockNum,
						stock_cd : stock_cd
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
	
	//--------모달창에서 재고번호, 창고위치 클릭 시 해당 값을 이동재고번호/이동위치 input 박스 안에 값 넣는 함수-----------
	
	
	
	
</script>
<script type="text/javascript">
function saveIdx(cb) {
	var idx = cb.id.replace("search_move_cd", "");
	alert(idx)
		$("#stock_table").on('click','tr',function(){
		   let td_arr = $(this).find('td');
		   console.log(td_arr);
		   
	//	   $('#no').val($(td_arr[0]).text());
		   let stock_no = $(td_arr[0]).text(); //재고번호
	//	   $('#name').val($(td_arr[1]).text());
		   let move_wh_loc_in_area = $(td_arr[1]).text(); //창고위치
		   console.log(move_wh_loc_in_area);
		   
		
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_stock_cd').modal('hide');
		   $("#move_stock_cd" + idx).val(stock_no);
		   $("#move_wh_loc_in_area" + idx).val(move_wh_loc_in_area);
		});
	
}//saveIdx 끝

function move_stock(move_cb) {
		var idx = move_cb.id.replace("moveButton",""); //index 값 저장
		var current_stock_cd = $("#stock_cd" + idx).val(); //현재 재고번호
		var move_stock_cd = $("#move_stock_cd" + idx).val(); //이동 할 재고번호
		var move_wh_loc_in_area = $("#move_wh_loc_in_area" + idx).val();//이동 위치
		var move_stock_num = $("#move_stock_num" + idx).val();//이동할 수량
		
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
						move_stock_num : move_stock_num
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
// 		}
		
		
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
                     <table id="datatablesSimple" style="font-size: small;">
                         <thead>
                             <tr>
<!--                               				<th scope="col">#</th> -->
                               <th>재고번호</th>
                               <th>품목코드</th>
                               <th>품목명</th>
                               <th>창고명</th>
                               <th>구역명</th>
                               <th>위치명</th>
                               <th>재고수량</th>
                               <th>조정수량 </th>
                               <th>이동재고번호</th>
                               <th>이동위치</th>
                               <th>이동수량</th>
                               <th>재고 이동하기</th>
                           </tr>
                       </thead>
                      <tbody>
                                 <c:forEach var="stockList" items="${stockList }" varStatus="status">
							<tr>
<!-- 										<td><input type="checkbox"></td> -->
<!-- 										<td scope="row"></td> -->
								<td>
								<a href="#"> ${stockList.stock_cd}</a>
								</td>
								<td><a href="#">${stockList.product_cd }</a></td>
								<td>${stockList.product_name }</td>
								<td>${stockList.wh_name }</td>
								<td>${stockList.wh_area }</td>
								<td>${stockList.wh_loc_in_area }</td>
								<td>${stockList.stock_qty }</td> 
								<td>
								<!-- 재고조정에 필요한 조정개수 -->
								<input type="number" id="updateStockNum${status.index}" size="3" max="${stockList.stock_qty }" min="0">
								<!-- 재고조정에 필요한 재고번호 -->
								<input type="hidden" id="stock_cd${status.index}" value="${stockList.stock_cd}">
								<c:set var="indexNum" value="${status.index}" />
								
<%-- 								${requestScope[stock_cd]}  --%>
<%-- 								${stock_cd.a } --%>
								<!-- 재고조정 버튼 -->
								<button id="updateButton${status.index}" class="btn btn-secondary" type="button" onclick="updateStock(this)">재고조정</button>
								</td>
								<!-- 이동재고번호 input, 검색 button -->
								<td>
								<input type="text" size="3" id ="move_stock_cd${status.index}">
								<button id="search_move_cd${status.index}" class="btn btn-secondary" type="button" onclick="saveIdx(this)"  data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_cd">검색</button>
								</td>
								<!-- 이동 위치 -->
								<td>
								<input type="text" size="3" id ="move_wh_loc_in_area${status.index}">
								</td>
								<!-- 이동 수량 -->
								<td><input type="text" size="3" id ="move_stock_num${status.index}"></td>
								<!-- 재고이동버튼 -->
								<td><button id="moveButton${status.index}" class="btn btn-secondary" type="button" onclick="move_stock(this)">재고이동</button></td>
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
                    <div class="modal-body">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="stock_keyword" >
				         <button id="search_stock" class="btn btn-primary" type="button" onclick="load_stockList">검색</button>
			        	 </div>
			        	 <div style="text-align: center;">
			        	 	<table class='table table-hover' id="stock_table" style="margin-left: auto; margin-right: ">
				        	 		<tr>
				        	 			<th scope="col">재고번호</th>
				        	 			<th scope="col">창고위치</th>
				        	 		</tr>
	                                 <c:forEach var="stockList" items="${stockList }" varStatus="status">
			        	 			<tr>
				        	 				<td>${stockList.stock_cd }</td>
				        	 				<td>${stockList.wh_loc_in_area}</td>
			        	 			</tr>
	                                 </c:forEach>
			        	 	
			        	 	</table>
			        	 </div>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
              
               <!-- Modal Dialog Scrollable -->
			 <!-- 재고 이동 모달 -->
              <div class="modal fade" id="modalDialogScrollable_stock_cd" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">재고 이동</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body" style="text-align: center;">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="move_keyword" >
				         <button id="search_buyer" class="btn btn-secondary" type="button" onclick="load_stockList">검색</button>
			        	 </div>
			        	 
			        	 <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
              
              
              <!-- 거래처 검색 -->
              <div class="modal fade" id="modalDialogScrollable_buyer" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">거래처 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body" style="text-align: center;">
                     	<div class="input-group mb-6">
		             		<input name="buyer_keyword" type="text" class="form-control" id="buyer_keyword" >
				         <button id="search_buyer" class="btn btn-secondary" type="button" onclick="load_buyerList()">검색</button>
			        	 </div>
<!-- 			        	 <div id="modal-body-result" style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
			        	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: ">
				                <tr>
				                  <th scope="col">거래처코드</th>
				                  <th scope="col">상호명</th>
				                </tr>
<!-- 				                <tbody> -->
				                
<!-- 				                </tbody> -->
<!-- 				                <tr> -->
<!-- 				                	<td colspan="2" style="text-align: center;" id="buyer_search">검색 후 이용 바랍니다.</td> -->
<!-- 				                </tr> -->
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
</main>		


  <!-- 테이블 템플릿 css/js -->
  <script src="${path}/resources/js/scripts.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
  <script src="${path}/resources/js/datatables-simple-demo.js"></script>
<!--   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
  
</body>
</html>