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
<title>재고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
// 체크박스 선택 jQuery
	
	
	$(document).ready(function() {
		if($("input[name=STOCK_CDArr]").val() == ""){
			$("input[name=STOCK_CDArr]").attr("readonly",true);
		}
		
		//체크 박스 전체 선택
		$("#chkAll").click(function() {
			if($("#chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
			else $("input[name=chk]").prop("checked", false);
		});
		
		//??
		$("input[name=chk]").click(function() {
			var total = $("input[name=chk]").length;
			var checked = $("input[name=chk]:checked").length;
		
			if(total != checked) $("#chkAll").prop("checked", false);
			else $("#chkAll").prop("checked", true); 
		});
		
		
	});
	
	
	

	
		
	 function calculateSum(cb) {
		    var idx = cb.id.replace("in_qty_input","");
// 			   alert(idx);
			var check_qty = parseInt($("#in_qty_input" + idx).val());
// 			alert("check_qty: " + check_qty);
			var in_schedule_qty = parseInt($("#in_qty_hidden" + idx).val());
			var in_qty_checkval = parseInt($("#in_qty_check" + idx).val());
// 			alert("in_schedule_qty : " + in_schedule_qty);
				if(check_qty> in_schedule_qty){
					alert("입고예정수량보다 많은 수량입니다.");
					$("#in_qty_input" + idx).val("");
					//초기화
					idx="";
					check_qty="";
					in_schedule_qty="";
				}else if(check_qty > in_qty_checkval){
					alert("미입고재고보다 많은 수량입니다.");
					$("#in_qty_input" + idx).val("");
					//초기화
					idx="";
					check_qty="";
					in_schedule_qty="";
				}else{
				     var sum = 0;
				     var inputElements = document.getElementsByClassName("out_schedule_qty");
				     for (var i = 0; i < inputElements.length; i++) {
				       if (!isNaN(inputElements[i].value) && inputElements[i].value.length != 0) {
				         sum += parseFloat(inputElements[i].value);
				       }
				     }
				     document.getElementById("sum").innerHTML = sum;
					
				   //초기화
					idx="";
					check_qty="";
					in_schedule_qty="";
				}
				
	   }//function 끝

	   var inputFields = document.querySelectorAll(".out_schedule_qty");
	   inputFields.forEach(function(inputField) {
	     inputField.addEventListener("input", calculateSum);
	     
	   });
	   
	   
</script>

<!-- 권한 여부 판별하여 인사부서인지 판별 -->
<script type="text/javascript">
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_emp = str.charAt(3); // 재고조회(3) 여부 판별할 값
	var priv_cd_emp2 = str.charAt(4); // 사원관리(2) 여부 판별할 값
	
	//사원조회, 사원관리에 대한 권한이 있는 지 판별
	if(priv_cd_emp == '1' || priv_cd_emp2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("권한이 없습니다");
		window.opener.location.reload();    //부모창 reload
		window.close();
	}
</script>
<!-- selectbox 조정, 이동 클릭에 따른 작업 -->
<script type="text/javascript">
	function stock_work_control(cb){
		//idx 값 가져오기 
		var idx = cb.id.replace("stock_control_id","");
		//변경된 selectbox의 value 값 가져오기 
		var value_control = $("#stock_control_id" + idx).val();
		//------------조정 작업-------------
		//값이 2일 경우(조정) -> 이동재고번호, 이동위치, 이동수량을 readonly 처리
		if(value_control == '2'){ // 2 = 조정 
// 			alert("2작업 ")
			//로딩 시 걸려있는 readonly 해제 
			
			//이동 관련 input disabled 적용  
			$("#move_stock_cd" + idx).attr("disabled",true)
			$("#search_move_cd" + idx).attr("disabled",true)
			$("#move_wh_loc_in_area" + idx).attr("disabled",true)
			$("#move_stock_num" + idx).attr("disabled",true)
			//조정수량은 disabled 해제 
			$("#updateStockNum" + idx).attr("disabled",false)
			$("#updateStockNum" + idx).attr("readonly",false)
			$("#updateStockNum" + idx).attr("required",true)
			//값 초기화 
			$("#move_stock_cd" + idx).val("");
			$("#move_wh_loc_in_area" + idx).val("");
			$("#move_stock_num" + idx).val("");
			$("#updateStockNum" + idx).val("");
			//조정 시 이동재고번호, 이동위치 히든 값을 0으로 세팅.
			$("#move_wh_loc_in_area_hidden" + idx).val("0");
			$("#move_stock_cd_hidden" + idx).val("0");
			
			//------------이동 작업-------------
		}else if(value_control == '3'){ // 3 = 이동 
			//이동 관련 input disabled 해제 + required 적용 
			$("#move_stock_cd" + idx).attr("disabled",false)
			$("#move_stock_cd" + idx).attr("required",true)
			$("#search_move_cd" + idx).attr("disabled",false)
			$("#move_wh_loc_in_area" + idx).attr("disabled",false)
			$("#move_wh_loc_in_area" + idx).attr("required",true)
			$("#move_stock_num" + idx).attr("disabled",false)
			$("#move_stock_num" + idx).attr("readonly",false)
			$("#move_stock_num" + idx).attr("required",true)
			//이동 시 hidden 값은 disable처리하여 값을 1개만 넘기도록 설정 
			$("#move_stock_cd_hidden" + idx).attr("disabled",true)

			//조정수량은 disabled 적용 	
			$("#updateStockNum" + idx).attr("disabled",true)
			//값 초기화 
			$("#move_stock_cd" + idx).val("");
			$("#move_wh_loc_in_area" + idx).val("");
			$("#move_stock_num" + idx).val("");
			$("#updateStockNum" + idx).val("");
			
		}else{
			$("#move_stock_cd" + idx).attr("disabled",false)
			$("#search_move_cd" + idx).attr("disabled",true)
			$("#move_wh_loc_in_area" + idx).attr("disabled",false)
			$("#move_stock_num" + idx).attr("disabled",false)
			$("#updateStockNum" + idx).attr("disabled",false)
		}
	}

</script>

<script type="text/javascript">
	//--------모달창에서 재고번호, 창고위치 클릭 시 해당 값을 이동재고번호/이동위치 input 박스 안에 값 넣는 함수-----------


//---------------재고번호 목록 조회(모달)--------------
function load_stockList() {
	
	let stock_keyword = $("#stock_keyword").val();
	
// 	alert(buyer_keyword);
	
	$.ajax({
		type: "GET",
		url: "StockListJson?keyword=" + stock_keyword,
		dataType: "json"
	})
	.done(function(stockList) { // 요청 성공 시
		console.log(stockList)
		if(stockList.length == 0){
			
			 $("#modal-body-stock > table").remove();   //테이블 비우기
		
		 let no_result = "<table class='table table-hover' id='stock_table' style='margin-left: auto; margin-right:'>"
				+ "<tr style='cursor:pointer; text-align: left;'>"
	            + '<th scope="col" style ="width:151px">재고번호</th>'
	            + '<th scope="col" style ="width:157px">창고명(구역명)</th>'
	            + '<th scope="col" style ="width:157px">창고위치</th>'
	            + '</tr>'
				+ "<tr style='cursor:pointer; text-align: left;'>"
				+ "<td colspan ='3'>"
				+ "<h6 style='font-weight: bold; text-align: center;'>" + "'" +  stock_keyword + "'" +  " 에 대한 검색결과가 없습니다."
				+ "</h6>"
				+ "</td>"
				+ "</tr>";
		 		+ '</table>';

	         $("#modal-body-stock").append(no_result);
	         $("#stock_keyword").focus();

		}else{
			$("#modal-body-stock > table ").remove();   //테이블 비우고
					
			let set_table = 
				"<table class='table table-hover' id='stock_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer; text-align: left;'>"
				+ '<th scope="col" style ="width:151px">재고번호</th>'
	            + '<th scope="col" style ="width:157px">창고명(구역명)</th>'
	            + '<th scope="col" style ="width:157px">창고위치</th>'
                + '</tr>'
		 		+ '</table>';
			 		
	         $("#modal-body-stock").append(set_table);
					
			for(let stock of stockList) {
				console.log(stock.stock_cd)
				console.log(stock.wh_name)
				console.log(stock.wh_area)
				console.log(stock.wh_loc_in_area)
		         let result = "<tr style='cursor:pointer;'>"
			                      + "<td id='stock_cd'>" + stock.stock_cd + "</td>"
			                      + "<td id='wh_name'>" + stock.wh_name + "(" + stock.wh_area + ")" + "</td>"
			                      + "<td id='wh_loc_in_area'>" + stock.wh_loc_in_area + "</td>"
	                        + "</tr>"
	                        + "</table>";
	                        
		         $("#modal-body-stock > table").append(result);
			}//for 끝
		}//else 끝
	})//done 끝
	.fail(function() {
		$("#modal-body-stock > table").append("<h3>요청 실패!</h3>");
	});//fail 끝
}//stockList 끝

//-------tr 클릭 시 이동재고번호, 이동위치가 자동으로 입력되는 함수---------
function saveIdx(cb) {
	var idx = cb.id.replace("search_move_cd", ""); //클릭한 버튼의 idx값 출력 -> 이동재고번호, 이동위치에 넣을 위치 !
// 	alert("tr클릭 전 idx : " + idx)
	$("#modal-body-stock").on('click','tr',function(){

	   let td_arr = $(this).find('td');
	   console.log(td_arr);
	   
	   let stock_no = $(td_arr[0]).text(); //재고번호
	   let move_wh_name = $(td_arr[1]).text(); //창고명
	   let move_wh_loc_in_area = $(td_arr[2]).text(); //창고위치
	   let current_stock_no = $("#stock_cd" + idx).val(); //현재 재고번호 
	   console.log("stock_no : " + stock_no);
	   console.log("current_stock_no : " + current_stock_no);
	   if(stock_no == current_stock_no){
		   $('#modalDialogScrollable_stock_cd').modal('hide');
		   alert("현재 재고번호입니다. 다시 선택해주세요.")
		   $("#move_stock_cd" + idx).val("");
		   $("#move_wh_loc_in_area" + idx).val("");
	   }else{
		   // td 클릭시 모달 창 닫기
	// 	   alert("tr클릭 후 idx : " + idx)
		   $('#modalDialogScrollable_stock_cd').modal('hide');
		   $("#move_stock_cd" + idx).val(stock_no);
		   $("#move_wh_loc_in_area" + idx).val(move_wh_name + "_" +move_wh_loc_in_area);
		   idx="";
	   }
	});

}//saveIdx 끝

//이동수량 입력 값이 현재재고보다 많을 경우 입력 불가능 하도록 하는 함수
function check_move_stock_num(cb){
	var idx = cb.id.replace("move_stock_num", ""); //클릭한 버튼의 idx값 출력 -> 이동재고번호, 이동위치에 넣을 위치 !
	var move_num = parseInt($("#move_stock_num" + idx).val());
	var stock_num = parseInt($("#stock_qty" + idx).val());
	alert(move_num);
	alert(stock_num);
	if(move_num > stock_num){
		alert("이동수량이 현재재고보다 많습니다.");
		$("#move_stock_num" + idx).val("");
		$("#move_stock_num" + idx).focus();
	}
	
}


</script>
<style type="text/css">
/* th, td { */
/*   text-align: center; */
/* } */
</style>
</head>
<body class="sb-nav-fixed">
<header>
	<!-- top-->
	</header>
	<!-- side -->
<main id="main" class="main"  style="margin-left: 10px;">

	<div class="pagetitle" >
      <h1>재고 관리</h1>
    </div><!-- End Page Title -->
    <form action="stockMoveUpdate.st" method="get">
    
    
            <div class="card mb-4">
                <div class="card-header">
                     재고 처리 
                 </div>
                 <div class="card-body">
                     <table id="datatablesSimple" style="">
                         <thead>
                             <tr>
                               <th>재고번호</th>
                               <th>품목코드</th>
                               <th>품목명</th>
                               <th>창고명(구역명)</th>
                               <th>위치명</th>
                               <th>재고수량</th>
                               <th>작업구분</th>
                               <th>조정수량</th>
                               <th>이동재고번호</th>
                               <th>이동위치</th>
                               <th>이동수량</th>
<!--                                <th>재고조정 및 이동</th> -->
                           </tr>
                       </thead>
                      <tbody>
                                 <c:forEach var="stockList" items="${stolist }" varStatus="status">
							<tr>
<!-- 										<td><input type="checkbox"></td> -->
<!-- 										<td scope="row"></td> -->
								<td>
								<!-- 재고번호  -->
								<a href="#" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_history" onclick="save_stock_cd(this)" id="save_stock_cd${status.index}" > ${stockList.stock_cd}</a>
								</td>
								<!-- 품목코드  -->
								<td>${stockList.product_cd }</td>
								<!-- 품목명  -->
								<td>${stockList.product_name }</td>
								<td>${stockList.wh_name }(${stockList.wh_area })</td>
								<td>${stockList.wh_loc_in_area }</td>
								<td>${stockList.stock_qty }</td> 
								<td>
								<select id="stock_control_id${status.index }" name="stock_controlArr" required="required" class="form-select" onchange="stock_work_control(this)">
									<option value="">작업 선택</option>
									<option value="2">조정</option>
									<option value="3">이동</option>
								</select>
								</td> 
								<td>
								<!-- 재고조정에 필요한 재고번호(히든) -->
								<input type="hidden" id="stock_cd${status.index}" name="stock_cdArr" value="${stockList.stock_cd}">
								<!-- 재고조정에 필요한 품목번호(히든) -->
								<input type="hidden" id="product_cd${status.index}" name="product_cdArr" value="${stockList.product_cd}">
								<!-- 재고이동에 필요한 현재재고개수(히든) -->
								<input type="hidden" id="stock_qty${status.index}" name="stock_qtyArr" value="${stockList.stock_qty}">
								<!-- 재고조정에 필요한 조정수량 -->
								<input type="text" class="form-control-sm" id="updateStockNum${status.index}" name="update_qtyArr" size="3" min="0" readonly>
								
								</td>
								<!-- 이동재고번호 input, 검색 button -->
								<td>
								<input type="text" size="3" class="form-control-sm" id ="move_stock_cd${status.index}" name="move_stock_cdArr" readonly>
								<input type="hidden" id="move_stock_cd_hidden${status.index}" name="move_stock_cdArr">
								<button id="search_move_cd${status.index}" class="btn btn-secondary btn-sm" type="button" onclick="saveIdx(this)"  data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_cd" disabled>검색</button>
								</td>
								<!-- 이동 위치 -->
								<td>
								<input type="text" size="18" class="form-control-sm" id ="move_wh_loc_in_area${status.index}" readonly>
								<input type="hidden" id="move_wh_loc_in_area_hidden${status.index}" name ="move_wh_loc_in_areaArr">
								</td>
								<!-- 이동 수량 -->
								<td><input type="text" size="3" class="form-control-sm" id ="move_stock_num${status.index}" name="update_qtyArr" readonly onchange="check_move_stock_num(this)"></td>
							</tr> 
							</c:forEach>  
                        </tbody>
                    </table>
                    <button type="submit" id="stock_work" class="btn btn-primary" onclick="check_value()">조정</button>
                    <button type="reset" id="reset_btn" class="btn btn-primary">초기화</button>
                    
                </div>
            </div>
            
       	</form>
            
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
                    	
	             		<input name="search_keyword" type="text" class="form-control" id="search_keyword" placeholder="검색 후 이용 바랍니다.">
   						<button id="search_buyer" class="btn btn-primary" type="button" onclick="stock_num_search_fn()">검색</button>
   						</div>
                    	<table class='table table-hover' id="stock_search_table" style="margin-left: auto; margin-right: ;font-size: 13px"">
				                <tr>
				                  <th scope="col" width="70px">재고번호</th>
				                  <th scope="col" width="160px">품목명</th>
				                  <th scope="col" width="100px">구역명</th>
				                  <th scope="col" width="70px">위치명</th>
				                  <th scope="col" width="70px">위치코드</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Vertically centered Modal-->	
              
      		 <!-- 창고 검색 시 나오는 모달 -->
              <div class="modal fade" id="warehouse_search" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 id="pro_search_sto" style="text-align: center;">창고번호 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-wh">
           	            <div class="input-group mb-6"  style="margin-bottom: 10px">
                    	
	             		<input name="search_keyword_wh" type="text" class="form-control" id="search_keyword_wh" placeholder="검색 후 이용 바랍니다.">
   						<button id="search_buyer" class="btn btn-primary" type="button" onclick="warehouse_search_fn()">검색</button>
   						</div>
                    	<table class='table table-hover' id="warehouse_search_table" style="margin-left: auto; margin-right: ;">
				                <tr>
				                  <th scope="col" width="200px">창고명(구역명)</th>
				                  <th scope="col" width="157px">위치명</th>
				                  <th scope="col" width="80px">위치코드</th>
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