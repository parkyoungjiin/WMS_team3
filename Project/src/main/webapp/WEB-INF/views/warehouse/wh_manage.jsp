<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
.material-symbols-outlined {
  font-variation-settings:
  'FILL' 0,
  'wght' 400,
  'GRAD' 0,
  'opsz' 48
}
.material-symbols-outlined {
  letter-spacing: 10px;
  font-variation-settings:
  'FILL' 0,
  'wght' 400,
  'GRAD' 0,
  'opsz' 48
}
.pmfont{
	font-size: 1.5em;
}
.modify{
	width: 50px;
}
.btns {
  float: right;
  font-size:10px; 
  padding:50px 50px;
}
li {
 width: 400px;
}
</style>
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
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
	//--------창고 리스트 출력-----------
	$(function() {
		let idx = 0;
		$.ajax({
			type: "GET",
			url: "WareHouseListJsonPro.wh",
			dataType: "json"
		})
		.done(function(whlist) { // 요청 성공 시
			for(let list of whlist) {
				let result ="<input type='hidden' id='wh_cd"+idx+"' value='"+list.wh_cd+"'>"
							+"<ul>" 
							+"<li><a href='javascript:void(0)' class='material-symbols-outlined' id='plus_area"+idx+"' onclick='load_areaList("+idx+","+list.wh_cd+")'>+</a>" 
							+"<a href='javascript:void(0)' class='material-symbols-outlined' id='mius_area"+idx+"' onclick='btnhide("+idx+")'>-</a>"
							+"<a href='javascript:void(0)' class='pmfont'  id='name"+idx+"' onclick='stocklist("+list.wh_cd+")'>"+list.wh_name+"</a></li>"
							+"<a href='javascript:void(0)' id='wh_area_plus"+idx+"' onclick='add_wh_area("+list.wh_cd+","+idx+")'  class='wh_area'> 추가하기</a>"
							+"<div id='wh_area"+idx+"' class='wh_area'></div>"
							+"</ul>";
				$("#wh_name").append(result);
				console.log(result);
				idx++;
				$(".wh_area").hide();
				
			}
		})
		.fail(function() {
			$("#wh_name").append("<h3>요청 실패!</h3>");
		});// 창고 리스트 출력
	});
	
	//--------창고 지역 출력-----------
	function load_areaList(idx,wh_cd) {
		let area_idx = 0;
		$.ajax({
			type: "GET",
			url: "WareHouseAreaListJsonPro.wh?wh_cd="+wh_cd,
			dataType: "json"
		})
		.done(function(wharealist) { // 요청 성공 시
				$("#wh_area"+idx).empty();
				for(let list of wharealist) {
					let wh_area = '"'+list.wh_area+'"';
					let result =
								"<input type='hidden' value='"+list.wh_area+"' id='wh_area'>"
								+"<input type='hidden' value='"+list.wh_area_cd+"' id='wh_area_cd'>"
								+"<input type='hidden' value="+area_idx+" id='area_idx'>"
								+"<div id='add_wh_area"+idx+"'></div>"
								+"<ul id='wh_area_ul"+idx+"'>"
								+"<li id='wh_area_li"+idx+"'><a href='javascript:void(0)' class='material-symbols-outlined' id='plus_loc"+area_idx+"' onclick='load_loc_areaList("+list.wh_cd+","+area_idx+","+list.wh_area_cd+","+idx+")'>+</a>" 
								+"<a href='javascript:void(0)' class='material-symbols-outlined' id='minus_loc"+area_idx+"' onclick='btnlochide("+idx+")'>-</a>"
								+"<a href='javascript:void(0)' id='name_area"+area_idx+"' value='"+list.wh_area+"'  onclick='stocklist_area("+list.wh_cd+","+list.wh_area_cd+")'>"+list.wh_area+"</a>"
								+"<input type='button' id='modify_btn"+area_idx+"' class='btn' onclick='modify("+area_idx+","+idx+","+list.wh_area_cd+","+wh_area+")' value='변경'>"
								+"<input type='button' id='delete_btn"+area_idx+"' class='btn' value='삭제'></li>"
								+"<a href='javascript:void(0)' class='wh_loc_area' id='wh_loc_area_plus"+area_idx+"' onclick='add_wh_loc_area("+list.wh_area_cd+","+area_idx+","+idx+")' class='wh_area'>추가하기</a>"
								+"<div id='add_wh_loc_area"+area_idx+"'></div>"
								+"<div id='wh_loc_area"+area_idx+"'></div>"
								+"</ul>";
					$("#wh_area"+idx).append(result);	
					console.log(result);
					area_idx++;
// 					$(".wh_area").hide();
					$("#wh_area_plus"+idx).show();
					$("#wh_area"+idx).show();
					$(".wh_loc_area").hide();
				}
		})
		.fail(function() {
			$("#tr").append("<h3>요청 실패!</h3>");
		});
	}
	
	//--------창고 선반 출력-----------
	function load_loc_areaList(wh_cd,area_idx,wh_area_cd,idx) {
		var loc_idx=0;
		$.ajax({
			type: "GET",
			url: "WareHouseLocInListJsonPro.wh?wh_area_cd="+wh_area_cd,
			dataType: "json"
		})
		.done(function(wharealoclist) { // 요청 성공 시
			$("#wh_area_ul"+idx+" > #wh_loc_area"+area_idx).empty();
// 			if(wharealoclist.length != 0){
			for(let list of wharealoclist) {
				let wh_loc_area = '"'+list.wh_loc_in_area+'"';	
				let result =
						"<ul id='wh_loc_area_ul"+idx+"'>"
						+"<li id='wh_loc_area_li"+area_idx+"'><a href='javascript:void(0)' id='name_loc_area"+loc_idx+"' onclick='stocklist_area_loc("+wh_cd+","+wh_area_cd+","+list.wh_loc_in_area_cd+")'>"+list.wh_loc_in_area+"</a>"
						+"<input type='button' id='modify_loc_btn"+loc_idx+"' class='btn' onclick='modify_loc("+list.wh_loc_in_area_cd+","+area_idx+","+loc_idx+","+wh_loc_area+","+idx+")' value='변경'>"
						+"<input type='button' id='delete_loc_btn"+loc_idx+"' class='btn' value='삭제'></li>"
						+"</ul>";
						$("#wh_area_ul"+idx+" > #wh_loc_area"+area_idx).append(result);
						$("#wh_area_ul"+idx+" > #wh_loc_area_plus"+area_idx).show();
						loc_idx++;
				}
				$("#wh_loc_area_plus"+area_idx).show();
// 			}else{
// 				let result ="<ul class='wh_loc_area'>"
// 					+"<a href='javascript:void(0)' onclick='add_wh_loc_area("+wh_area_cd+","+area_idx+","+idx+")'>추가하기</a>"
// 					+"</ul>";
// 					$("#wh_area_ul"+idx+" > #wh_loc_area"+area_idx).append(result);
// 			}
		})
		.fail(function() {
			$("#tr").append("<h3>요청 실패!</h3>");
		});
	}
	
	//---------창고 안 재고 리스트 출력-----------
	function stocklist(wh_cd,pageNum){
		pageNum = 1;
		$.ajax({
			type: "GET",
			url: "WareHouseStockListJsonPro.wh?pageNum="+pageNum,
			data : {
				"wh_cd" : wh_cd,
			},
			dataType:"json"
		})
		.done(function(whlist) { // 요청 성공 시
			var pageNum=1;
			let pageInfo = whlist[0];
			let result2 = "";
				if(pageNum > 1){
				 result2 +='<a href="WareHouseStockListJsonPro.wh?pageNum=${param.pageNum - 1 }">이전</a>';
				}else{
				 result2 +='<a href="javascript:void(0)">이전</a>'	;
				}
			for(var num=pageInfo.startPage; num<=pageInfo.endPage; num++) {
				alert(num);
				if(num == pageNum){
				result2	+= num;
				}else{
				result2	+= '<a href="javascript:void(0)">num</a>';	
				}
			}
			
			if(pageNum < pageInfo.maxPage){
			result2	+='<a href="ProductOrderList.po?pageNum=${param.pageNum + 1 }&member_idx=${member_idx }">다음</a>';
			}else{
			result2	+='<a href="javascript:void(0)">다음</a>';
			}
			$(".paging").append(result2);
			
			whlist.shift();
			if(whlist != ""){
			$("#stocklist > tbody").html('');
			for(let list of whlist) {
				
				let result = "<tr>"
							+"<td>"+list.stock_cd+"</td>"
							+"<td>"+list.product_name+"</td>"
							+"<td>"+list.stock_qty+"</td>"
							+"<td>"+list.wh_name+"(구역명:"+list.wh_area+")</td>"
							+"<td>(위치:)"+list.wh_loc_in_area+"</td>"
							+"</tr>";
				$("#stocklist > tbody").append(result);
			}
			console.log(wh_cd);
			}else{
				$("#stocklist > tbody").html('<td colspan="5" align="center"><h3>재고가 없습니다!</h3></td>');
			}
		})
		.fail(function() {
			$("table > tbody > tr").append("<h3>요청 실패!</h3>");
		});// 창고 리스트 출력
	}
	
	//---------창고 지역 안 재고 리스트 출력-----------
	function stocklist_area(wh_cd,wh_area_cd){
		$.ajax({
			type: "GET",
			url: "WareHouseStockListJsonPro.wh",
			data : {
				"wh_cd" : wh_cd,
				"wh_area_cd" : wh_area_cd,
			},
			dataType: "json"
		})
		.done(function(whlist) { // 요청 성공 시
			if(whlist != ""){
			$("#stocklist > tbody").html('');
			for(let list of whlist) {
				let result = "<tr>"
							+"<td>"+list.stock_cd+"</td>"
							+"<td>"+list.product_name+"</td>"
							+"<td>"+list.stock_qty+"</td>"
							+"<td>"+list.wh_name+"(구역명:"+list.wh_area+")</td>"
							+"<td>(위치:)"+list.wh_loc_in_area+"</td>"
							+"</tr>";
				$("#stocklist > tbody").append(result);
			}
			}else {
				$("#stocklist > tbody").html('<td colspan="5" align="center"><h3>재고가 없습니다!</h3></td>');
			}
		})
		.fail(function() {
			$("table > tbody > tr").append("<h3>요청 실패!</h3>");
		});// 창고 리스트 출력
	}
	
	//---------선반 안 재고 리스트 출력---------------
	function stocklist_area_loc(wh_cd,wh_area_cd,wh_loc_in_area_cd){
		$.ajax({
			type: "GET",
			url: "WareHouseStockListJsonPro.wh",
			data : {
				"wh_cd" : wh_cd,
				"wh_area_cd" : wh_area_cd,
				"wh_loc_in_area_cd" : wh_loc_in_area_cd
			},
			dataType: "json"
		})
		.done(function(whlist) { // 요청 성공 시
			var maxAppend = 0; //버튼누른 횟수 저장
			$("#stocklist > tbody").html('');
			if(whlist != ""){
			for(let list of whlist) {
				let result = "<tr>"
							+"<td>"+list.stock_cd+"</td>"
							+"<td>"+list.product_name+"</td>"
							+"<td>"+list.stock_qty+"</td>"
							+"<td>"+list.wh_name+"(구역명:"+list.wh_area+")</td>"
							+"<td>(위치:)"+list.wh_loc_in_area+"</td>"
							+"</tr>";
					$("#stocklist > tbody").append(result);
			}
			}else {
				$("#stocklist > tbody").html('<td colspan="5" align="center"><h3>재고가 없습니다!</h3></td>');
			}
		})
		.fail(function() {
			$("table > tbody > tr").append("<h3>요청 실패!</h3>");
		});// 창고 리스트 출력
	}
	
	//--------숨기기-----------
	function btnhide(idx) {
		$(".wh_area").hide();
	}
	//--------선반 숨기기--------
	function btnlochide(idx) {
		$(".wh_loc_area").hide();
	}
	
	//--------지역 추가--------
	function add_wh_area(wh_cd,idx) {
		$("#wh_loc_area_plus").hide();
		$("#wh_loc_area_plus_button").hide();
		let result = "<input type='text' id='wh_area_plus' name='wh_area'>"
					+"<input type='button' id='wh_area_plus_button' onclick='add_area("+wh_cd+","+idx+")' value='추가'></button>";
		$("#add_wh_area"+idx).html(result);
	}
	
	
	function add_area(wh_cd,idx){
		var wh_area = document.getElementById("wh_area_plus").value;
		var wh_area_cd = document.getElementById("wh_area_cd").value;
		var area_idx = document.getElementById("area_idx").value;
		if(wh_area != ""){
			$.ajax({
				type: "GET",
				url: "WareHouseAreaInsertPro.wh",
				data:{
					"wh_area" : wh_area,
					"wh_cd" : wh_cd
				}
			})
			.done(function() { // 요청 성공 시
				var area = '"'+ wh_area +'"';
				let result =
							"<ul id='wh_area_ul"+idx+"'>"
							+"<li><a href='javascript:void(0)' class='material-symbols-outlined' id='name"+idx+"' onclick='load_loc_areaList("+wh_cd+","+wh_area_cd+")'>+</a>" 
							+"<a href='javascript:void(0)' class='material-symbols-outlined' id='name"+idx+"' onclick='btnlochide("+idx+")'>-</a>"
							+"<a href='javascript:void(0)' id='name"+idx+"' onclick='stocklist_area()'>"+wh_area+"</a>"
							+"<a href='javascript:void(0)' class='wh_loc_area' id='wh_loc_area_plus' onclick='add_wh_loc_area("+idx+")' class='wh_area'>추가하기</a>"
							+"<input type='button' id='modify_btn"+area_idx+"' class='btn' onclick='modify("+area_idx+","+idx+","+wh_area_cd+","+area+")' value='변경'>"
							+"<input type='button' id='delete_btn"+area_idx+"' class='btn' value='삭제'></li>"
							+"<div id='add_wh_loc_area'></div>"
							+"<div id='wh_loc_area"+idx+"'></div>"
							+"</ul>";
				$("#add_wh_area"+idx).after(result);
				$(".wh_loc_area").hide();
				$("#wh_area_plus").remove();
				$("#wh_area_plus_button").remove();
				location.reload();
			})
			.fail(function() {
				alert("정보 실패");
			});
		}
	}
	
	//-------선반 추가-----------
	function add_wh_loc_area(wh_area_cd,area_idx,idx) {
		$("#wh_area_plus").hide();
		$("#wh_area_plus_button").hide();
		let result = "<input type='text' id='wh_loc_area_plus' name='wh_loc_in_area'>" 
					+"<button id='wh_loc_area_plus_button' onclick='add_loc_area("+wh_area_cd+","+area_idx+","+idx+")'>추가</button>";
		$("#wh_area_ul"+idx+" > #add_wh_loc_area"+area_idx).html(result);
	}
	
	function add_loc_area(wh_area_cd,area_idx,idx){
		var wh_loc_in_area = document.getElementById("wh_loc_area_plus").value;
		alert(wh_loc_in_area);
		$.ajax({
			type: "GET",
			url: "WareHouseLocAreaInsertPro.wh",
			data:{
				"wh_loc_in_area" : wh_loc_in_area,
				"wh_area_cd" : wh_area_cd
			}
		})
		.done(function() { // 요청 성공 시
			let result =
						"<ul id='wh_loc_area'>"
						+"<li><a href='javascript:void(0)' id='name"+area_idx+"' onclick='stocklist_area_loc()'>"+wh_loc_in_area+"</li>"
						+"<input type='button' id='modify_loc_btn' onclick='modify_loc_area("+area_idx+","+loc_idx+","+wh_loc_in_area+","+idx+")' class='btn' value='수정'>"
						+"<input type='button' id='delete_loc_btn' class='btn' value='삭제'></li>"
						+"</ul>";
						$("#wh_area_ul"+idx+" > #wh_loc_area"+area_idx).append(result);
						$("#wh_loc_area_plus").show();
						$("#wh_loc_area_plus").remove();
						$("#wh_loc_area_plus_button").remove();
						location.reload();
		})
		.fail(function() {
			alert("등록 실패");
		});
	}
	
	function modify(area_idx,idx,wh_area_cd,wh_area) {
		$("#wh_area_li"+idx+" > #modify_btn"+area_idx).hide();
		$("#wh_area_li"+idx+" > #delete_btn"+area_idx).hide();
		alert(area_idx);
		let result = "<input type='text' id='wh_area_modify"+area_idx+"' class='wh_area_modify' value="+wh_area+" name='wh_area'>"
					+"<input type='button' id='modify_btn' onclick='modify_area("+wh_area_cd+","+idx+","+area_idx+")' class='btn' value='수정'>"
					+"<input type='button' id='delete_btn' class='btn' value='삭제'></li>";
		$("#wh_area_li"+idx+" > #name_area"+area_idx).html(result);	
	
		
	}
	
	function modify_area(wh_area_cd,idx,area_idx) {
		var wh_area_modify = document.getElementById("wh_area_modify"+area_idx).value;
		$.ajax({
			type: "GET",
			url: "WareHouseAreaUpdatePro.wh",
			data:{
				"wh_area" : wh_area_modify,
				"wh_area_cd" : wh_area_cd
			}
		})
		.done(function(vo) { // 요청 성공 시
			alert("입력 확인");
			let result = "<a href='javascript:void(0)' id='name_area"+idx+"' onclick='stocklist_area()'>"+wh_area_modify+"</a>";
			$("#wh_area_li"+idx+" > #name_area"+area_idx).html(result);
			$(".btn").show();
		})
		.fail(function() {
			alert("정보 실패");
		});
	}
	
	//-------선반 수정 --------
	function modify_loc(wh_loc_in_area_cd,area_idx,loc_idx,wh_loc_in_area,idx) {
		$(" #wh_area_ul"+idx).find("#wh_loc_area_li"+area_idx+" > #modify_loc_btn"+loc_idx).hide();
		$(" #wh_area_ul"+idx).find("#wh_loc_area_li"+area_idx+" > #delete_loc_btn"+loc_idx).hide();
		let result = "<input type='text' id='wh_area_loc_modify"+loc_idx+"' class='wh_area_modify' value="+wh_loc_in_area+" name='wh_area'>"
		+"<input type='button' id='modify_loc_btn' onclick='modify_loc_area("+wh_loc_in_area_cd+","+area_idx+","+loc_idx+","+wh_loc_in_area+","+idx+")' class='btn' value='수정'>"
		+"<input type='button' id='delete_loc_btn' class='btn' value='삭제'></li>";
		console.log(wh_loc_in_area);
		$(" #wh_area_ul"+idx).find("#wh_loc_area_li"+area_idx+" > #name_loc_area"+loc_idx).html(result);
	}
	
	function modify_loc_area(wh_loc_in_area_cd,area_idx,loc_idx,wh_loc_in_area,idx) {
		var wh_loc_area_modify = document.getElementById("wh_area_loc_modify"+loc_idx).value;
		alert(wh_loc_area_modify);
		$.ajax({
			type: "GET",
			url: "WareHouseLocAreaUpdatePro.wh",
			data:{
				"wh_loc_in_area" : wh_loc_area_modify,
				"wh_loc_in_area_cd" : wh_loc_in_area_cd
			}
		})
		.done(function(vo) { // 요청 성공 시
			alert(idx);
			alert(area_idx);
			alert(loc_idx);
			var wh_loc_area = '"'+wh_loc_area_modify+'"';
			let result = "<li><a href='javascript:void(0)' id='name_loc_area"+loc_idx+"' onclick='stocklist_area()'>"+wh_loc_area_modify+"</a>"	
						+"<input type='button' id='modify_loc_btn"+loc_idx+"' class='btn' onclick='modify_loc("+wh_loc_in_area_cd+","+area_idx+","+loc_idx+","+wh_loc_area+","+idx+")' value='변경'>"
						+"<input type='button' id='delete_loc_btn"+loc_idx+"' class='btn' value='삭제'></li>"
			$(" #wh_area_ul"+idx).find("#wh_loc_area_li"+area_idx+" > #name_loc_area"+loc_idx).html(result);
			console.log(wh_loc_area_modify);
		})
		.fail(function() {
			alert("정보 실패");
		});
	}
	
</script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="${path}/resources/css/bootstrap.min.css" rel="stylesheet">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>창고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

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
   <div class="pagetitle">
     <h1>창고 관리</h1>
   </div><!-- End Page Title -->
			 <!-- Modal Dialog Scrollable -->
			 <!-- 거래처 검색 -->
              <div class="modal fade" id="modalDialogScrollable_buyer" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">위치 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="search_buyer" class="btn btn-secondary" type="button">검색</button>
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
              
			 <!-- Modal Dialog Scrollable -->
			 <!-- 담당자 검색 -->
              <div class="modal fade" id="modalDialogScrollable_emp" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">담당자 검색</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                     	<div class="input-group mb-6">
		             		<input name="" type="text" class="form-control" id="" >
				         <button id="" class="btn btn-secondary" type="button">검색</button>
			        	 </div>
				         <div style="padding: 100px 0px; text-align: center;">검색 후 이용 바랍니다.</div>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button"  class="btn btn-primary">Save changes</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
			
			
	<div class="card mb-4">
		<div class="card-header">
            창고 상세정보 입력
        </div> <!-- card mb-4 -->
		<div class="card mb-4">
     	  <div class="card-body" style="padding: 50px 80px;">
       			<div id="wh_name"  style="float: left;">
<!--        			<ul id="wh_name"> -->
<!--        				<li> -->
<!--        					<ul> -->
<!--        						<li id="wh_area"> -->
<!-- 						     	<ul> -->
<!-- 						     	<li id="wh_loc_in_area"> -->
<!-- 						     	</li> -->
<!-- 						     	</ul> -->
<!--        						</li> -->
<!--        					</ul> -->
<!--        				</li> -->
<!--        			</ul> -->
       			</div>
       			<div style="float: right;">
  				<span style="text-align: center;"><h3>재고</h3></span>
  				<table id="stocklist" class="table table-hover" style="width: 800px; align: right;">  
  					<thead>
                             <tr>
                               <th scope="col">재고번호</th>
                               <th scope="col">품목명</th>
                               <th scope="col">재고수량</th>
                               <th scope="col">창고명(구역명)</th>
                               <th scope="col">위치명</th>
                           	</tr>
                    </thead>
                    <tbody>
                    </tbody>
                 </table>
                 <div class="paging" align="center">
        
<!--         <a class="select" href="#">1</a> -->
<!--         <a href="#">2</a> -->
<!--         <a href="#">3</a> -->
<!--         <a href="#">4</a> -->
<!--         <a href="#">5</a> -->
    		</div>      
       		</div>
			</div> <!-- card-body -->
       </div>
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>