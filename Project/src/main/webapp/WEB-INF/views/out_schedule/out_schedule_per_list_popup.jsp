<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
<!-- 거래처(기본 등록) 권한 판별 -->
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_res = str.charAt(0); // 기본등록(0) 여부 판별할 값
	var priv_cd_pro = str.charAt(3); // 재고조회(3) 여부 판별할 값
	var priv_cd_pro2 = str.charAt(4); // 재고관리(4) 여부 판별할 값
	
	//기본등록에 대한 권한이 있는 지 판별
	if(priv_cd_res == '1' || priv_cd_pro == '1' || priv_cd_pro2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("권한이 없습니다");
		history.back();
	}
</script>

<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>출고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">

// 출고 막기
var outStatus = false;



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
	
	//-------------출고처리 시 팝업창 ----------------
	
// 	function in_schedule_process() {
// 		window.open("Out_Per_List_popup", "출고", "width=1200, height=750, top=50, left=50")
// 	}
	
	// ------------재고, 창고조회---------------
	function stock_num_search_fn() {
		
		let search_keyword = $("#search_keyword").val();
		
//	 	alert(buyer_keyword);
		
		$.ajax({
			type: "GET",
			url: "StockNumListJson_out?keyword=" + search_keyword,
			dataType: "json"
		})
		.done(function(stockList) { // 요청 성공 시
			 console.log(stockList)
//	 		$(".modal-body").append(buyerList);
			$("#modal-body-sto > table ").remove();   //테이블 비우고
			
				let set_table = "<table class='table table-hover' id='stock_search_table' style='margin-left: auto; margin-right: '>"
					+ "<tr style='cursor:pointer;'>"
	                + '<th scope=col">재고번호</th>'
	                + '<th scope=col">품목명</th>'
	                + '<th scope=col">구역명</th>'
	                + '<th scope=col">위치명</th>'
	                + '<th scope=col">수량</th>'
	                + '</tr>'
  			 		+ '</table>'
				
		         $("#modal-body-sto").append(set_table);
				
			for(let stock of stockList) {
		         let result = 
		        	 	"<tr style='cursor:pointer;'>"
		                  + "<td>" + stock.stock_cd + "</td>"
		                  + "<td>" + stock.product_name + "</td>"
		                  + "<td>" + stock.wh_name + "("+ stock.wh_area + "구역)" + "</td>"
		                  + "<td>" + stock.wh_loc_in_area + "</td>"
		                  + "<td>" + stock.stock_qty + "</td>"
		                  + "</tr>";

	 			$("#stock_search_table").append(result);
			}
		})
		.fail(function() {
	 			$("modal-body-sto").append("<h3>요청 실패!</h3>");
// 			$("#stock_search_table > tr").append("<h3>요청 실패!</h3>");
		});
	}
	
	
	function input_search_idx(cb) {

		var idx = cb.id.replace("stock_search_btn", "");
		var stock_idx = $(cb).val(); // 재고번호 넣어두기
		console.log("재고번호 : "  + stock_idx);
		
		$("#search_keyword").val(stock_idx);
		
		$("#modal-body-sto").on('click','tr',function(){
// 			alert("클릭 후 :" +idx);

// 			console.log("클릭된다.")
		   let td_arr = $(this).find('td');
		   console.log(td_arr);
		   
//		   $('#no').val($(td_arr[0]).text());
		   let stock_cd = $(td_arr[0]).text();
//		   $('#name').val($(td_arr[1]).text());
		   let wh_name = $(td_arr[2]).text();
		   let wh_loc_in_area = $(td_arr[3]).text();
		   let stock_qty = $(td_arr[4]).text();
		   console.log(stock_cd);
		   
		   // td 클릭시 모달 창 닫기
		   $('#stock_search').modal('hide');
		   $("#stock_cd_input" + idx).val(stock_cd);
		   $("#wh_area_loc_input" + idx).val(wh_name + "_" + wh_loc_in_area);
		   $("#stock_qty" + idx).val(stock_qty);
		   idx = "";
		   
		   $("#modal-body-sto > table ").remove();   //테이블 비우고
			
			let set_table = "<table class='table table-hover' id='stock_search_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer;'>"
               + '<th scope=col">재고번호</th>'
               + '<th scope=col">품목명</th>'
               + '<th scope=col">구역명</th>'
               + '<th scope=col">위치명</th>'
               + '<th scope=col">수량</th>'
               + '</tr>'
			 		+ '</table>'
			
	         $("#modal-body-sto").append(set_table);
	});	  
		
		
	}
	
	
	// ------------ 출고수량 작업 --------------
	function input_out_idx(cb) {
		
		var idx = cb.id.replace("out_qty_input",""); // 초기화된 idx 다시 저장
		console.log("qty_idx : " + idx);
		
		
		var inputElements = document.getElementsByClassName("stock_cd_cl");
		console.log(inputElements);
		
		var wh_area_loc = $("#wh_area_loc_input"+ idx).val();
		var stock_qty = $("#stock_qty" + idx); // 재고수량
		var out_qty = $("#out_qty_input" + idx); // 출고수량
		var stock_cd = $("#stock_cd_input" + idx); // 재고번호
		var os_qty = $("#os_qty" + idx); // 출고예정수량
		var out_not_input =  $("#out_not_input" + idx); // 미출고수량 (출고예정수량-출고수량)
		console.log("미출고수량 : " + out_not_input.val());
		
		// 재고 검색 후 수량 체크하도록!
		if(wh_area_loc === "" || stock_qty === ""){
			alert("재고 검색 후 입력해주세요.");
			out_qty.val("");
		}
		
		// 지시수량은 출고예정수량과 재고수량을 넘을 수 없음
// 		if(parseInt(os_qty.val()) < parseInt(out_qty.val())){
// 			alert("출고예정수량을 확인해주세요.");
// 			out_qty.val("");

		// 지시수량은 미출고수량을 넘을 수 없음
		if(parseInt(out_not_input.val()) < parseInt(out_qty.val())){
			alert("미출고 수량을 확인해주세요.");
			out_qty.val("");
		} else if(parseInt(stock_qty.val()) < parseInt(out_qty.val())){
			alert("재고수량을 확인해주세요.");
			out_qty.val("");
		}
		
		
	} // ------------ 출고수량 작업 끝 --------------
		
	
	//-------------수량 합계 계산--------------
	 function calculateSum() {
	     var sum = 0;
	     var inputElements = document.getElementsByClassName("sum_qty");
	     for (var i = 0; i < inputElements.length; i++) {
	       if (!isNaN(inputElements[i].value) && inputElements[i].value.length != 0) {
	         sum += parseFloat(inputElements[i].value);
	       }
	     }
	     document.getElementById("sum").innerHTML = sum;
	   }

	   var inputFields = document.querySelectorAll(".sum_qty");
	   inputFields.forEach(function(inputField) {
	     inputField.addEventListener("input", calculateSum);
	   }); 
	//-------------수량 합계 계산 끝--------------

</script>
</head>
<body class="sb-nav-fixed">
<header>
	<!-- top-->
<%-- 		<jsp:include page="../inc/top.jsp"/> --%>
	</header>
	<!-- side -->
<main id="main" class="main"  style="margin-left: 10px;">

	<div class="pagetitle" >
      <h1>출고 관리</h1>
    </div><!-- End Page Title -->
    	
    	<div class="modal fade" id="modalDialogScrollable_complete" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body" style="text-align: center;">
<!--                      	<div class="input-group mb-6"> -->
<!-- 			        	 </div> -->
			        	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: ">
				                <tr>
				                	<th scope="col">품목코드</th>
				                	<th scope="col">품목명[규격]</th>
				                	<th scope="col">출고예정수량</th>
				                	<th scope="col">미출고수량</th>
				                </tr>
<%-- 				                <c:forEach items="${outProdList }" var="outProdList"> --%>
<!-- 					                <tr> -->
<%-- 					                	<td>${outProdList.out_product_cd }</td> --%>
<%-- 					                	<td>${outProdList.out_product_name }</td>  --%>
<%-- 					                	<td>${outProdList.out_shedule_qty }</td> --%>
<%-- 					                	<td>${outProdList.out_shedule_qty - outProdList.out_qty }</td> --%>
<!-- 					                </tr> -->
<%-- 				                </c:forEach> --%>
			        	 </table>

                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
    	
    	
    	<form action="Out_Per_Schedule_Process" method="post" id="editFLForm"> 
            <div class="card mb-4">
                <div class="card-header">
                     출고 처리
                 </div>
               <div class="card-body">
                  <div class="input-group mb-6" id ="stock_history_div">
	                    <table class="table table-hover" id="stock_history_table" style="margin-left: auto; margin-right: ">
							<tr>
					 			<th scope="col">출고예정번호</th>
					 			<th scope="col">품목명</th>
					 			<th scope="col" width="150px;">재고번호</th>
					 			<th scope="col" width="180px;">구역명_선반위치</th>
					 			<th scope="col" width="120px;">재고수량</th>
					 			<th scope="col" width="120px;">출고예정수량</th>
					 			<th scope="col" width="120px;">미출고수량</th>
					 			<th scope="col" width="120px;">지시수량</th>
				 			</tr>
				 			<c:forEach var="list" items="${list }" varStatus="status">
				 			<input type="hidden" value="${list.out_schedule_cd }" name="out_schedule_cd">
				 			<input type="hidden" value="${list.out_schedule_per_cd }" name="out_schedule_per_cdArr">
				 			<input type="hidden" value="${list.product_cd }" name="product_cdArr">
				 			<input type="hidden" value="${list.out_complete }" name="out_completeArr">
				 			<tr>
					 			<td>${list.out_schedule_cd }</td>
					 			<td>${list.product_name }</td>
<%-- 					 			<td>${list.out_schedule_qty }</td> --%>
					 			
					 			<td>
					 			    <div class="input-group input-group-sm mb-1">
					 				<!-- 재고번호 자동 입력될 칸 -->
									<input type="text" class="form-control form-control-sm stock_cd_cl" id ="stock_cd_input${status.index}" name="stock_cdArr" size="1" value="${list.stock_cd }" readonly="readonly">
									<!-- 재고번호 검색 버튼 -->					 			
                      				<button type="button" class="btn btn-secondary" id ="stock_search_btn${status.index}" value="${list.stock_cd }"  data-bs-toggle="modal" data-bs-target="#stock_search" onclick="input_search_idx(this)">검색</button>
					 				</div>
					 			<td>
					 				<!-- 구역명_선반위치 -->
									<input type="text" class="form-control form-control-sm" id ="wh_area_loc_input${status.index}" name="wh_area_wh_loc" readonly="readonly">					 			
					 			</td>
					 			<td>
					 				<!-- 재고수량 -->
									<input type="text" class="form-control form-control-sm" id ="stock_qty${status.index}" name="stock_qty" size="1" readonly="readonly" required="required">					 			
					 			</td>
					 			<td>
					 				<!-- 출고예정수량 -->
									<input type="text" class="form-control form-control-sm" id ="os_qty${status.index}"  value="${list.out_schedule_qty }" size="1" readonly="readonly" required="required" name="out_schedule_qtyArr">					 			
					 			</td>
					 			<td>
					 				<!-- 미출고수량 -->
					 				<input type="text" class="form-control form-control-sm" size="1" id="out_not_input${status.index}" size="1" name="out_not" required="required" value="${list.out_schedule_qty - list.out_qty}" readonly="readonly">
					 			</td>
					 			<td>
					 				<!-- 출고처리할 수량 입력칸 -->
					 				<input type="text" class="form-control form-control-sm sum_qty" size="1" id="out_qty_input${status.index}" name="out_qtyArr" required="required" oninput="input_out_idx(this)" onchange="calculateSum();">
					 			</td>
				 			</tr>
				 			</c:forEach>
		 				</table>
		        	 </div>
	           	 	<div>
	           	 		  <span style="font-size: 15px; float: left;">지시수량 합계 : &nbsp;</span> <span id="sum" style="padding-right: 50px; font-size: 15px;"></span>
			              <button class="btn btn-primary" type="submit" style="float: right;" id="in_submit">출고</button>
	           	 	</div>
           	 </div>
		 </div>
       </form>     
              <!-- Extra Large Modal -->
         
              
              
      		 <!-- 재고 검색 시 나오는 모달 -->
              <div class="modal fade" id="stock_search" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 id="pro_search_sto" style="text-align: center;">재고번호 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-sto">
           	            <div class="input-group mb-6"  style="margin-bottom: 10px">
                    	
	             		<input name="search_keyword" type="text" class="form-control" id="search_keyword" placeholder="검색 후 이용 바랍니다." readonly="readonly">
   						<button id="search_buyer" class="btn btn-primary" type="button" onclick="stock_num_search_fn()">검색</button>
   						</div>
                    	<table class='table table-hover' id="stock_search_table" style="margin-left: auto; margin-right: ">
				                <tr>
				                  <th scope="col">재고번호</th>
				                  <th scope="col">품목명</th>
				                  <th scope="col">구역명</th>
				                  <th scope="col">위치명</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Vertically centered Modal-->	
              
</main>		


  <!-- 테이블 템플릿 css/js -->
  <script src="${path}/resources/js/scripts.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
  <script src="${path}/resources/js/datatables-simple-demo.js"></script>
<!--   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
  
</body>
</html>