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
		window.opener.location.href ="EmpLoginForm.em";    //부모창 reload
		window.close();
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
<title>재고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<!-- moment.js 라이브러리  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.js"></script>

<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
function change_list_fn(){
	var control_type = $("#change_list").val()
	var stock_cd = ${stock_cd}
    var table = document.getElementById('datatablesSimples');
// 	alert(control_type);
// 	alert(stock_cd);
	
	$.ajax({
		//stock_cd, 해당 Filter_no를 파라미터로 넘겨서 ajax
		type: "POST",
		url: "StockHistoryListAjax.st",
		data: {"stock_cd" : stock_cd, "control_type" : control_type}, 
		dataType : "json"
	})//ajax 끝 
		.done(function(result) {
		//----------1. 조회 결과가 있을 경우 ------------
		if(result != ""){
		//테이블 길이 확인 
			 var trlength = $('#datatablesSimples tr').length;
			console.log("성공 : " + trlength)
		//테이블 길이만큼 행을 삭제
		     for(var t=trlength-1 ; t>0 ; t--){
		       table.deleteRow(t);
		     }
		//삭제 후 ajax결과를 행에 추가
			for(let stockHistory of result){
				//moment.js를 사용하여 stock_date를 반복할 때마다 형식을 변환! 
				var date_format = moment(stockHistory.stock_date).format("YYYY-MM-DD (dd) HH:mm:ss");
				console.log("date_format : " + date_format);
				let tr = 
					"<tr>"
					+ "<td>" + date_format + "</td>"
					+ "<td>" + stockHistory.stock_control_type_name + "</td>"
					+ "<td>" + stockHistory.product_name + "</td>"
					+ "<td>" + "<a href='StockHistoryList.st?stock_cd=" +stockHistory.source_stock_cd + "'>" + stockHistory.source_stock_cd + "</a>" + "</td>"
					+ "<td>" + "<a href='StockHistoryList.st?stock_cd=" +stockHistory.target_stock_cd + "'>" + stockHistory.target_stock_cd + "</a>" + "</td>"
					+ "<td>" + stockHistory.qty + "</td>"
					+ "<td>" + stockHistory.emp_name + "</td>"
					+ "<td>" + stockHistory.remarks + "</td>"
					+"</tr>";
			       $("#datatablesSimples").append(tr);
		//----------2. 조회 결과가 없을 경우 ------------
			}//for 끝 
		}else{
		//테이블 길이 확인 
		 var trlength = $('#datatablesSimples tr').length;
		//테이블 길이만큼 행을 삭제
		     for(var t=trlength-1 ; t>0 ; t--){
		       table.deleteRow(t);
		     }
		//삭제 후 ajax결과를 행에 추가
			let tr = 
				"<tr>"
				+ "<td colspan ='8'>"
				+ "<h3 style='text-align: center;'>조회결과가 없습니다.</h3>"
				+ "</td>"
				+"</tr>";
		       $("#datatablesSimples").append(tr);
				
			
		}//else 
// 			 alert("trlength : " + trlength);
		})//done 끝 	
		
}//function 끝 

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
      <h1>재고 이력</h1>
    </div><!-- End Page Title -->
    
    
            <div class="card mb-4">
                <div class="card-header">
                     재고 번호 : ${stock_cd} 
                 </div>
                 <div class="card-body">
                 	작업구분 
                 	<select class="form-control-sm" id="change_list" onchange="change_list_fn()">
                 		<option selected="selected" data-content="img/sliders.svg"  value="99">전체</option>
                 		<option value="0">입고</option>
                 		<option value="1">출고</option>
                 		<option value="2">조정</option>
                 		<option value="3">이동</option>
                 	</select>
                 	<hr>
                     <table class="table table-hover" id="datatablesSimples" style="">
                         <thead>
                             <tr>
                               <th>작업일자</th>
                               <th>작업구분</th>
                               <th>품목명</th>
                               <th>보낸 재고번호</th>
                               <th>받은 재고번호</th>
                               <th>작업 수량</th>
                               <th>작업 후 수량</th>
                               <th>작업자명</th>
                               <th>적요</th>
                           </tr>
                       </thead>
                      <tbody>
                                 <c:forEach var="stockHistory" items="${stockHistoryList }" varStatus="status">
							<tr>
<!-- 										<td><input type="checkbox"></td> -->
<!-- 										<td scope="row"></td> -->
								<td>
								<!-- 작업일자  -->
<%-- 								<a href="#" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_stock_history" onclick="save_stock_cd(this)" id="save_stock_cd${status.index}" > ${stockHistory.stock_date}</a> --%>
								<fmt:formatDate value="${stockHistory.stock_date}" pattern="yyyy-MM-dd (E) HH:mm:ss"/>
								</td>
								<!-- 작업구분  -->
								<td>${stockHistory.stock_control_type_name}</td>
								<!-- 품목명  -->
								<td>${stockHistory.product_name }</td>
								<!-- 보낸 재고번호 -->
								<td><a href="StockHistoryList.st?stock_cd=${stockHistory.source_stock_cd}">${stockHistory.source_stock_cd}</a></td>
									<!-- 받은 재고번호 -->
								<td><a href="StockHistoryList.st?stock_cd=${stockHistory.target_stock_cd}">${stockHistory.target_stock_cd}</a></td>
								<!-- 작업 수량 -->
								<td>${stockHistory.qty }</td> 
								<!-- 작업 후 수량 -->
								<td>${stockHistory.stock_qty }</td> 
								<!-- 작업자명 -->
								<td>${stockHistory.emp_name }</td> 
								<!-- 적요 -->
								<td>${stockHistory.remarks }</td> 
							
								
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