<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<!-- 거래처(기본 등록) 권한 판별 -->
<script type="text/javascript">
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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>출고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">




// var date = new Date();
// var yyyy = date.getFullYear();
// var mm = date.getMonth()+1 > 9 ? date.getMonth()+1 : '0' + date.getMonth()+1;
// var dd = date.getDate() > 9 ? date.getDate() : '0' + date.getDate();
 
// $("#out_schedule_date").val(yyyy+"-"+mm+"-"+dd);


var idx = 0;
var selectIdx;



//-------------------거래처 목록 조회(모달)-----------------
function load_buyerList() {
	
	let buyer_keyword = $("#buyer_keyword").val();
	
// 	alert(buyer_keyword);
	
	$.ajax({
		type: "GET",
		url: "BuyerListJson?keyword=" + buyer_keyword,
		dataType: "json"
	})
	.done(function(buyerList) { // 요청 성공 시
// 			$(".modal-body").append(buyerList);
// 		$("#modal-body > table").empty();
		if(buyerList.length == 0){
			$("#modal-body-buyer > table ").remove();   //테이블 비우고

			let no_result = "<table class='table table-hover' id='buyer_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer; text-align: center;'>"
                + '<th scope="col" style ="width:180px">거래처 코드</th>'
                + '<th scope="col" style ="width:285px">상호명</th>'
                + '</tr>'
				+ "<tr style='cursor:pointer; text-align: center;'>"
				+ "<td colspan ='2'>"
				+ "<h6 style='font-weight: bold; text-align: center;'>" + "'" +  buyer_keyword + "'" +  " 에 대한 검색결과가 없습니다."
				+ "</h6>"
				+ "</td>"
				+ "</tr>";
		 		+ '</table>';

// // 			$("#buyer_search").append("<div></div>");
// 			$("#buyer_search").html("<div>등록된 데이터가 없습니다.</div>");
// 			$("#buyer_search").css("color","#B9062F");
	         $("#modal-body-buyer").append(no_result);
	         $("#buyer_keyword").focus();



		}else{
			
		$("#modal-body-buyer > table ").remove();   //테이블 비우고
			
				let set_table = "<table class='table table-hover' id='buyer_table' style='margin-left: auto; margin-right: '>"
					+ "<tr style='cursor:pointer; text-align: center;'>"
	                + '<th scope="col" style ="width:180px">거래처 코드</th>'
	                + '<th scope="col" style ="width:285px">상호명</th>'
	                + '</tr>'
  			 		+ '</table>';
  			 		
		         $("#modal-body-buyer").append(set_table);
				
		
// 		else {
// 			$("#buyer_search").remove();
// 		}
		for(let buyer of buyerList) {
			console.log("buyer.business_no : " + buyer.business_no);
			let result = "<tr style='cursor:pointer; text-align: center;'>"
		                + "<td>" + buyer.business_no + "</td>"
		                + "<td id='cust_name'>" + buyer.cust_name + "</td>"
               			+ "</tr>";
             
			$("#buyer_table").append(result);
		}
		}

	})
	.fail(function() {
		$("#modal-body-buyer").append("<h3>요청 실패!</h3>");
	});
}// //-------------------거래처 목록 조회(모달) 끝-----------------




//------------------사원 목록 조회(모달)-------------------------
function load_empList() {
	
	let emp_keyword = $("#emp_keyword").val();
	
	$.ajax({
		type: "GET",
		url: "EmpListJson?keyword=" + emp_keyword,
		dataType: "json"
	})
	.done(function(empList) { // 요청 성공 시
		
		if(empList.length == 0){
			$("#modal-body-emp > table ").remove();   //테이블 비우고
			
			
			let no_result = "<table class='table table-hover' id='emp_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer; text-align: center;'>"
					+'<th scope="col" style="width: 151px">사원번호</th>'
		            +'<th scope="col" style="width: 157px">부서</th>'
		            +'<th scope="col" style="width: 157px">사원명</th>'
	            + '</tr>'
				+ "<tr style='cursor:pointer;'>"
				+ "<td colspan ='3'>"
				+ "<h6 style='font-weight: bold; text-align: center;'>" + "'" +  emp_keyword + "'" +  " 에 대한 검색결과가 없습니다."
				+ "</h6>"
				+ "</td>"
				+ "</tr>";
		 		+ '</table>';

// // 			$("#buyer_search").append("<div></div>");
// 			$("#buyer_search").html("<div>등록된 데이터가 없습니다.</div>");
// 			$("#buyer_search").css("color","#B9062F");
	         $("#modal-body-emp").append(no_result);
	         $("#emp_keyword").focus();



		}else{
			
			$("#modal-body-emp > table ").remove();   //테이블 비우고

			let set_table = "<table class='table table-hover' id='emp_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer; text-align: center;'>"
				+'<th scope="col" style="width: 151px">사원번호</th>'
	            +'<th scope="col" style="width: 157px">부서</th>'
	            +'<th scope="col" style="width: 157px">사원명</th>'
	            + '</tr>'
		         $("#modal-body-emp").append(set_table);

			for(let emp of empList) {
				
				let result = "<tr style='cursor:pointer; text-align: center;'>"
				  + "<td style='width: 151px'>" + emp.EMP_NUM + "</td>"
	              + "<td style='width: 157px'>" + emp.DEPT_NAME + "</td>"
	              + "<td style='width: 157px'>" + emp.EMP_NAME + "</td>"
	              
	  			$("#modal-body-emp > table").append(result);
	
			}//for 끝
	
		}//else 끝
	})//done 끝
	.fail(function() {
			$("#modal-body-emp > table").append("<h3>요청 실패!</h3>");
	});
}//---------------사원 조회 끝----------------------


// -----------------품목 목록 조회(모달)-------------------

function load_proList() {
	
	let pro_keyword = $("#pro_keyword").val();
	
	$.ajax({
		type: "GET",
		url: "ProListJson?keyword=" + pro_keyword,
		dataType: "json"
	})
		.done(function(proList) { // 요청 성공 시
		console.log(proList);
		if(proList.length == 0){
			$("#modal-body-pro > table").remove();   //테이블 비우고
			
			
			let no_result = "<table class='table table-hover' id='pro_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer;text-align: center;'>"
				+'<th scope="col" style="width: 151px">품목번호</th>'
	            +'<th scope="col" style="width: 157px">품목명</th>'
	            +'<th scope="col" style="width: 157px">규격</th>'
	            + '</tr>'
				+ "<tr style='cursor:pointer; text-align: center;'>"
				+ "<td colspan ='3'>"
				+ "<h6 style='font-weight: bold; text-align: center;'>" + "'" +  pro_keyword + "'" +  " 에 대한 검색결과가 없습니다."
				+ "</h6>"
				+ "</td>"
				+ "</tr>";
		 		+ '</table>';

// // 			$("#buyer_search").append("<div></div>");
// 			$("#buyer_search").html("<div>등록된 데이터가 없습니다.</div>");
// 			$("#buyer_search").css("color","#B9062F");
	         $("#modal-body-pro").append(no_result);
	         $("#pro_keyword").focus();



		}else{
			
			$("#modal-body-pro > table").remove();   //테이블 비우고

			let set_table = "<table class='table table-hover' id='pro_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer; text-align: center;'>"
				+'<th scope="col" style="width: 151px">품목번호</th>'
	            +'<th scope="col" style="width: 157px">품목명</th>'
	            +'<th scope="col" style="width: 157px">규격</th>'
	            + '</tr>'
		         $("#modal-body-pro").append(set_table);

			for(let pro of proList) {
				
				let result = "<tr style='cursor:pointer; text-align: center;'>"
				  + "<td style='width: 151px'>" + pro.product_cd + "</td>"
	              + "<td style='width: 157px'>" + pro.product_name + "</td>"
	              + "<td style='width: 157px'>" + pro.size_des + "</td>"
	              
	  			$("#pro_table").append(result);
	
			}//for 끝
	
		}//else 끝
	})//done 끝
	.fail(function() {
			$("#modal-body-pro > table").append("<h3>요청 실패!</h3>");
	});
	
	

}


// 재고 목록 조회(모달)
function load_stoList() {
	
	
	let sto_keyword = $(".pro_cd").eq(selectIdx).val();
// 	alert(sto_keyword);

// 	if(sto_keyword === ""){
// 		alert("품목을 먼저 선택해주세요!");
// 		return;
// 	}
	
	$.ajax({
		type: "GET",
		url: "StoListJson?keyword=" + sto_keyword,
		dataType: "json"
	})
	.done(function(stoList) { // 요청 성공 시
		
		if(stoList.length == 0){
			$("#modal-body-sto > table ").remove();   //테이블 비우고
		
			let no_result = "<table class='table table-hover' id='sto_table' style='margin-left: auto; margin-right: '>"
				+ "<tr style='cursor:pointer; text-align: center;'>"
					+'<th scope="col" style="width: 157px"></th>'
		            +'<th scope="col" style="width: 157px"></th>'
		            +'<th scope="col" style="width: 151px"></th>'
	            + '</tr>'
				+ "<tr style='cursor:pointer;'>"
				+ "<td colspan ='3'>"
// 				+ "<h6 style='font-weight: bold; text-align: center;'>" + "'" +  sto_keyword + "'" +  " 에 대한 검색결과가 없습니다."
				+ "<h6 style='font-weight: bold; text-align: center;'>" + "품목을 선택해주세요."
				+ "</h6>"
				+ "</td>"
				+ "</tr>";
		 		+ '</table>';

// 			let no_result = "<h6 style='font-weight: bold; text-align: center;'>" + "품목을 선택해주세요." + "</h6>";
		 		
		 		
		 		 $("#modal-body-sto").append(no_result);
		         $("#sto_keyword").focus();
		}else{	
		
			$("#modal-body-sto > table ").remove();   //테이블 비우고
			
			let set_result = "<table class='table table-hover' id='sto_table' style='margin-left: auto; margin-right: '>" 
					+ "<tr style='cursor:pointer; text-align: center;'>"
					+'<th scope="col" style="width: 157px">품목코드</th>'
		            +'<th scope="col" style="width: 157px">재고번호</th>'
		            +'<th scope="col" style="width: 151px">수량</th>'
	            + '</tr>'
	            
	            $("#modal-body-sto").append(set_result);
	            
			for(let sto of stoList) {
			
			let result = "<tr style='cursor:pointer; text-align: center;'>"
		                + "<td style='width: 157px'>" + sto.product_cd + "</td>"
		                + "<td style='width: 157px'>" + sto.stock_cd + "</td>"
		                + "<td style='width: 151px'>" + sto.stock_qty + "</td>"
             
			$("#sto_table").append(result);
		}
	  }
	})
	.fail(function() {
		$("#modal-body-sto > table").append("<h3>요청 실패!</h3>");
	});
}
	


//td 클릭 시 해당 value 가져오기
$(function() {
	
	//출고 처리 날짜 계산
	var today = new Date();

	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var dateString = year + '-' + month  + '-' + day;

	//alert(dateString); 
	$("#out_schedule_date").val(dateString);
	
	
	// 거래처
	$("#modal-body-buyer").on('click','tr',function(){
		  let td_arr = $(this).find('td');
		  console.log(td_arr);
			   
//		  $('#no').val($(td_arr[0]).text());
		  let no = $(td_arr[0]).text();
//		  $('#name').val($(td_arr[1]).text());
	      let cust_name = $(td_arr[1]).text();
		  console.log(no);
		  console.log(cust_name);
			   
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_buyer').modal('hide');
		   $("#cust_name").val(cust_name);
		   $("#business_no").val(no);
	});	 
	
	
	// 담당자
	$("#modal-body-emp").on('click','tr',function(){
		   let td_arr = $(this).find('td');
		   console.log(td_arr);
		   
// 		   $('#no').val($(td_arr[0]).text());
		   let emp_num = $(td_arr[0]).text();
		   let dept_cd = $(td_arr[1]).text();
		   let emp_name = $(td_arr[2]).text();
		   console.log(emp_name);
		   
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_emp').modal('hide');
		   $("#emp_name").val(emp_name);
		   $("#emp_num").val(emp_num);
	});	 
	
	
	
	// 품목
	$("#modal-body-pro").on('click','tr',function(){
		   let td_arr = $(this).find('td');
		   
// 		   console.log(td_arr);
		   
		   let pro_cd = $(td_arr[0]).text();
		   let pro_name = $(td_arr[1]).text();
		   let pro_size = $(td_arr[2]).text();
		   
		   $.ajax({
				type: "GET",
				url: "StoListJson?keyword=" + pro_cd,
				dataType: "json"
			})
			.done(function(stoList) { // 요청 성공 시
				
					if(stoList.length === 0){
						alert("재고가 없는 품목입니다.");
						return;
					}
					
			
					// td 클릭시 모달 창 닫기
					   $('#modalDialogScrollable_pro').modal('hide');
					   $(".pro_cd").eq(selectIdx).val(pro_cd);
					   $(".pro_name").eq(selectIdx).val(pro_name + " ["+pro_size+"]");
					   $(".product_nameArr").eq(selectIdx).val(pro_name); // hidden input 에 품목명 넣기
					   $(".product_sizeArr").eq(selectIdx).val(pro_size); // hidden input 에 규격 넣기
//			 		   $("#pro_search_sto").text("품목코드 : " + pro_cd);
// 					$(".stoContent").eq(selectIdx).html("재고 번호 : " +stoList[0].stock_cd + "<br> 재고 수량 : " + stoList[0].stock_qty);
// 					$(".stock_cd").eq(selectIdx).val(stoList[0].stock_cd);
// 					$(".stock_qty").eq(selectIdx).val(stoList[0].stock_qty);
			})
			.fail(function() {
				$("#modal-body-sto > table").append("<h3>요청 실패!</h3>");
			});
		   
	});	   
	
	
	// 재고
	$("#modal-body-sto").on('click','tr',function(){
		   let td_arr = $(this).find('td');
		   console.log(td_arr);
		   
// 		   $('#no').val($(td_arr[0]).text());
		   let pro_cd = $(td_arr[0]).text();
		   let sto_cd = $(td_arr[1]).text();
		   let sto_qty = $(td_arr[2]).text();
		   console.log(pro_cd);
		   
		   // td 클릭시 모달 창 닫기
		   $('#modalDialogScrollable_sto').modal('hide');
		   $(".stock_cd").eq(selectIdx).val(sto_cd);
// 		   $("#emp_num").val(emp_num);
	});	   
	
	
	// 테이블 추가하기
	$("#plus_out").on("click", function() {
		
		if($("#testDate").val().length == 0){
			alert("납기일자를 입력해주세요.");
			$("#testDate").focus();
			return;
		}
// 		if($("#testDate").val().length == 0 || $("#remarks").val().length == 0){
// 			return;
// 		}
		
		var date = $("#testDate").val();
		var remarks = $("#remarks").val();
		
// 		var count = 0; // 0부터 시작 
// 		var n = $("#pro_cd" + count); // 현재 pro_cd 항목을 얻음 
// 		count = count + 1; // 새로운 number를 할당 
// 		n.attr("pro_cd" + count); // 새로운 number 할당 
		
		
// 		alert(date);
			var addInput =  
							'<tr  style="text-align: center">'
// 							+ '<td><input type="checkbox" name="chk"></td>'
							+ '<td>'
							+ '<div class="input-group input-group-sm mb-10">'
         					+ '<input type="text" style="text-align:center;" class="form-control form-control-sm pro_cd" name="product_cdArr" required="required" readonly="readonly">'
	         				+ '<button class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_pro" onclick="selectIdx='+idx+'">검색</button>'
          					+ '</div></td>'
							+ '<td style="text-align: center;"><input type="text" class="form-control form-control-sm pro_name" required="required" readonly="readonly">' + '</td>'
// 							+ '<td>' + '규격' + '</td>'
							+ '<td style="text-align:center;"><input type="number" style="text-align:center;" class="form-control form-control-sm out_schedule_qty" name="out_schedule_qtyArr" required="required" id="out_schedule_qty" onchange="calculateSum();"></td>'
							+ '<td style="text-align:center;"><input type="date" style="text-align:center;" class="form-control form-control-sm" style="border:none" value="' + date + '" name="out_dateArr" required="required"></td>'
							+ '<td style="text-align:center;"><input type="text" style="text-align:center;" class="form-control form-control-sm" value="' + remarks + '" name="remarks_proArr"></td>'
							+ '<td>'
							+ '<div class="input-group input-group-sm mb-10">'
         					+ '<input type="text" style="text-align:center;" class="form-control form-control-sm stock_cd" name="stock_cdArr" required="required" readonly="readonly">'
	         				+ '<button id="" class="btn btn-secondary btn-sm" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_sto" onclick="load_stoList()">검색</button>'
          					+ '</div></td>'
// 							+ '<td><button id="" class="btn btn-secondary btn-sm" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_sto" onclick="load_stoList()">검색</button></td>' // 재고검색
// 							+ '<td style="text-align:center;"><span class="stoContent"></span></td>'
// 							+ '<input type="hidden" name="stock_cdArr" class="stock_cd">'
// 							+ '<input type="hidden" name="stock_qty" class="stock_qty">'
							+ '<input type="hidden" name="product_nameArr" class="product_nameArr">'
							+ '<input type="hidden" name="product_sizeArr" class="product_sizeArr">'
            				+ '</tr>';
            				
            				$("#out_list > tbody").append(addInput);
            				
           idx++;	
           
//            console.log(idx);
	});
});
	

//체크박스 선택 jQuery
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
	
	// 체크박스 선택 삭제
	$("#delete_out").click(function(){
		
		if($("input:checkbox[name='chk']:checked").length === 0) {
			alert("삭제할 항목을 선택해 주세요.");
			return;
		}
		
		$("input:checkbox[name='chk']:checked").each(function(k,kVal){
			let a = kVal.parentElement.parentElement;
			$(a).hide(); // idx 때문에 hide() 씀
// 			$(a).td.val(0);
// 			console.log(a);
// 			$(a).detach(); // hide 쓰니까 값이 다 넘어가서 detach() 씀 // 근데 또 안됨.............
		});
		
	});
	
	
	
});




  // 재고 수량 비교
//  function calculateQty(){
	  
// 	let stoQty = $(".stock_qty").eq(selectIdx).val(); // 재고 수량
// 	let qty = $(".out_schedule_qty").eq(selectIdx).val(); // 출고 예정 수량
// 	console.log(qty + "," + stoQty);
	
// 	if(qty > stoQty){
// 		alert("재고 수량을 확인해주세요.");
// 		$(".stock_qty").eq(selectIdx).focus();
// 		$(".stock_qty").eq(selectIdx).val('');
// 	}
	
//  }
  
//수량 합계 계산
 function calculateSum() {
     var sum = 0;
     var inputElements = document.getElementsByClassName("out_schedule_qty");
     for (var i = 0; i < inputElements.length; i++) {
       if (!isNaN(inputElements[i].value) && inputElements[i].value.length != 0) {
         sum += parseFloat(inputElements[i].value);
       }
     }
     document.getElementById("sum").innerHTML = sum;
   }

   var inputFields = document.querySelectorAll(".out_schedule_qty");
   inputFields.forEach(function(inputField) {
     inputField.addEventListener("input", calculateSum);
   });
</script>

<style type="text/css">
#title_label {
	text-align: center;
}
</style>
</head>
<body>
	<header>
		<!-- top-->
		<jsp:include page="../inc/top.jsp" />
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
	<main id="main" class="main">
	<form action="OutRegisterPro" method="post">

   <div class="pagetitle">
     <h1>출고 관리</h1>
   </div><!-- End Page Title -->
    
	<div class="card mb-4">
		<div class="card-header" style="font-size: 20px;">
            출고 입력
        </div>
        
       <div class="card-body" style="padding: 80px 50px 30px 50px;">
              
              
              	<div class="row mb-3">
                      <label for="th" id="currentDate" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">작성일자</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="out_schedule_date" type="date" class="form-control" id="out_schedule_date" required="required" readonly="readonly" >
                      </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">출고 유형</label>
                      <div class="col-md-8 col-lg-2">
                        <select name="out_category" required="required" class="form-select">
								<option value="발주서">발주서</option>
								<option value="구매">출고</option>
							</select>
                      </div>
                    </div>
                    
                    
              	<div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">거래처</label>
                      <div class="col-md-8 col-lg-2">
		      			<div class="input-group mb-6">
		             		<input name="cust_name" type="text" class="form-control" id="cust_name" required="required" readonly="readonly">
		             		<input name="business_no" type="hidden" class="form-control" id="business_no" >
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_buyer" >검색</button>

			        	 </div>
			          </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">담당자</label>
                      <div class="col-md-8 col-lg-2">
		      			<div class="input-group mb-6">
		             		<input name="emp_name" type="text" class="form-control" id="emp_name" required="required" readonly="readonly">
		             		<input name="emp_num" type="hidden" class="form-control" id="emp_num" >
				         <button id="" class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable_emp">검색</button>
			        	 </div>
			          </div>
                    </div>
                
                <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">납기일자</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="out_date" type="date" class="form-control" id="testDate" required="required">
                      </div>
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" style="text-align: center;">비고</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="remarks" type="text" class="form-control" id="remarks" >
                      </div>
                    </div>
               
               <div class="row mb-3" style="float: right;">
                    	<label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">
	           				<input type="button" class="btn btn-secondary" value="출고품목 추가" id="plus_out">
	           			</label>
                    </div> 
			</div> <!-- card-body -->
			
			 <!-- Modal Dialog Scrollable -->
			 <!-- 거래처 검색 -->
              <div class="modal fade" id="modalDialogScrollable_buyer" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">거래처 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-buyer" style="text-align: center;">
                     	<div class="input-group mb-6">
		             		<input name="buyer_keyword" type="text" class="form-control" id="buyer_keyword" placeholder="검색 후 이용 바랍니다.">
				         <button id="search_buyer" class="btn btn-primary" type="button" onclick="load_buyerList()">검색</button>
			        	 </div>
<!-- 			        	 <div id="modal-body-result" style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
			        	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: ">
				                <tr style="text-align: center;">
				                   <th scope="col" style="width: 180px;">거래처 코드</th>
				                  <th scope="col" style="width: 285px">상호명</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
              
			 <!-- Modal Dialog Scrollable -->
			 <!-- 담당자 검색 -->
              <div class="modal fade" id="modalDialogScrollable_emp" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">담당자 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-emp">
                     	<div class="input-group mb-6">
		             		<input name="emp_keyword" type="text" class="form-control" id="emp_keyword" placeholder="검색 후 이용 바랍니다.">
				         <button id="search_emp" class="btn btn-primary" type="button" onclick="load_empList()">검색</button>
			        	 </div>
<!-- 				         <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
 						<table class='table table-hover' id="emp_table" style="margin-left: auto; margin-right: ">
				                <tr style="text-align: center;">
				                  <th scope="col" style="width: 151px">사원번호</th>
				                  <th scope="col" style="width: 157px">부서</th>
				                  <th scope="col" style="width: 157px">사원명</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
			
			<!-- Modal Dialog Scrollable -->
			 <!-- 품목 검색-->
              <div class="modal fade" id="modalDialogScrollable_pro" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">품목 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-pro">
                     	<div class="input-group mb-6">
		             		<input name="pro_keyword" type="text" class="form-control" id="pro_keyword" placeholder="검색 후 이용 바랍니다.">
				         <button id="search_pro" class="btn btn-primary" type="button" onclick="load_proList()">검색</button>
			        	 </div>
<!-- 			        	 <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div> -->
						<table class='table table-hover' id="pro_table" style="margin-left: auto; margin-right: ">
				                <tr style="text-align: center;">
				                  <th scope="col" style="width: 157px">품목번호</th>
				                  <th scope="col" style="width: 151px">품목명</th>
				                  <th scope="col" style="width: 151px">규격</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
		</div> <!-- card mb-4 -->
			
		 <!-- Vertically centered Modal -->
		 <!-- 재고 검색 -->
              <div class="modal fade" id="modalDialogScrollable_sto" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 id="pro_search_sto" style="text-align: center;"></h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body-sto">
                    	
                    	<table class='table table-hover' id="sto_table" style="margin-left: auto; margin-right: ">
				                <tr style="text-align: center;">
				                  <th scope="col" style="width: 151px">품목코드</th>
				                  <th scope="col" style="width: 151px">재고번호</th>
				                  <th scope="col" style="width: 151px">수량</th>
				                </tr>
			        	 </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Vertically centered Modal-->	
		<%-- ********************************** 복수개 품목명 입력창(하단부)************************************************* --%>		
		<div class="card mb-4">
			<div class="card-header" style="font-size: 20px;">
          		출고 품목
        	</div>
     	  <div class="card-body">
<!--      	    <input type="button" class="btn btn-secondary btn-sm" value="삭제" id="delete_out"> -->
       			<table class="table table-hover" id="out_list">
		                <thead>
		                  <tr style="text-align: center">
<!-- 		                    <th scope="col"><input type="checkbox" id="chkAll"></th> -->
		                    <th scope="col" style="width: 197px">품목코드</th>
		                    <th scope="col" style="width: 273px">품목명 [규격]</th>
<!-- 		                    <th scope="col">규격</th> -->
		                    <th scope="col" style="width: 80px">수량</th>
		                    <th scope="col" style="width: 197px">납기일자</th>
		                    <th scope="col" style="width: 274px">비고</th>
		                    <th scope="col" style="width: 120px">출고대상재고</th>
		                  </tr>
		                </thead>
		                <tbody>
		                  
		                </tbody>
		              </table>
		              
		              <!-- End Table with hoverable rows -->
       			<div class="text-right" style="float: right; padding-top: 50px">
<!-- 		        	수량 합계 : <input type="text" style="border: none;" size="5" > -->
		        	<span style="font-size: 15px;">수량 합계 : </span><span id="sum" style="padding-right: 50px; font-size: 15px;"></span>
                  <button type="submit" class="btn btn-primary">등록</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
       </div>
		

       </div>
     </form>  
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>