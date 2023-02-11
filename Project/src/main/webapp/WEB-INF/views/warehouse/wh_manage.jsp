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
<link href="${path}/resources/css/bootstrap.min.css" rel="stylesheet">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>출고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
	let idx;
		//--------창고 리스트 출력-----------	
			$(function() {
					$.ajax({
						type: "GET",
						url: "WareHouseListJsonPro.wh",
						dataType: "json"
					})
					.done(function(whlist) { // 요청 성공 시
						idx = 1;
						for(let list of whlist) {
							let result = "<tr id='tr"+list.wh_cd+"'>"
										+"<td><button id='minus"+list.wh_cd+"' name='minus' value='"+list.wh_cd+"' onclick='minus_button("+list.wh_cd+","+idx+")' class='btn' type='button'>-</button>"
										+"<button id='plus"+list.wh_cd+"' name='plus' value='"+list.wh_cd+"'  onclick='plus_button("+list.wh_cd +")' class='btn' type='button'>+</button>"
										+"<a href='javascript:void(0)' onclick='stocklist("+list.wh_cd+")'>"+list.wh_name+"</a></td>" 
										+"<td>" + list.wh_man_name + "</td>"
										+"<td><div></div></td>"
										+"</tr>"
										+"<tr id='tr"+list.wh_cd+"' class='hide"+list.wh_cd+"'>"
										+"<td> <input type='text' placeholder='창고지역' class='hide"+list.wh_cd+"' id='wh_area"+list.wh_cd+"'>"
										+"<button onclick='tableCreate("+list.wh_cd +")' class='hide"+list.wh_cd+"'>추가</button> </td>"
										+"<td></td>"
										+"<td></td>"
										+"</tr>";
							$("#table > tbody").append(result);
							console.log(result);
							idx++;
						}
					})
					.fail(function() {
						$("table > tbody > tr").append("<h3>요청 실패!</h3>");
					});// 창고 리스트 출력
 					
					//--------------------창고 지역 리스트 ------------------------
					$.ajax({
						type: "GET",
						url: "WareHouseAreaListJsonPro.wh",
						dataType: "json"
					})
					.done(function(wharealist) { // 요청 성공 시
						for(let list of wharealist) {
							let tet = null;
							let result ="<tr id='tr"+list.wh_area_cd+"' class='hide"+list.wh_cd+"'>"
							+"<td scope='col'>&nbsp;&nbsp;"
							+"<button id='minus_loc"+list.wh_area_cd+"' name='minus' onclick='loc_minus_button("+list.wh_area_cd +")' class='btn' type='button'>-</button>"
							+"<button id='plus_loc"+list.wh_area_cd+"' name='plus' onclick='loc_plus_button("+list.wh_area_cd +")' class='btn' type='button'>+</button>"
							+"<span id='test"+list.wh_area_cd+"'><a href='javascript:void(0)' onclick='stocklist_area("+list.wh_cd+","+list.wh_area_cd+")'>창고 지역 :"+list.wh_area + "</a></span></td>"
							+"<td><button class='btn btn-secondary' id='check_button' onclick='tableDelte("+list.wh_area_cd+")'>삭제</button>"
							+"<button class='btn btn-secondary' id='modify_button2"+list.wh_area_cd+"' onclick='modify("+list.wh_area+","+list.wh_area_cd+")'>변경</button>"
							+"<button class='btn btn-secondary modify_button2' id='modify_button"+list.wh_area_cd+"' class='modify_button2' onclick='modify_info("+list.wh_area+","+list.wh_area_cd+")'>수정</button></td>"
							+"<td></td>"
							+"<input type='hidden' value='"+list.wh_area_cd+"' id='hidden_value'> "
							+"<input type='hidden' value='"+list.wh_area+"' id='area_hidden_value'> "
							+"<input type='hidden' value='"+list.wh_cd+"' id='wh_hidden_value'> "
							+"</tr>"
							+"<tr id='tr"+list.wh_cd+"' class='loc_hide"+list.wh_area_cd+"'>"
							+"<td>&nbsp;&nbsp;&nbsp;<input type='text' placeholder='선반 위치' id='wh_area_loc"+list.wh_area_cd+"'>"
							+"<button onclick='loc_tableCreate("+list.wh_area_cd +")' class='loc_hide"+list.wh_area_cd+"'>추가</button> </td>"
							+"<td><div></div></td>"
							+"<td><div></div></td>"
							+"</tr>";
							$("#tr"+list.wh_cd).after(result);
							console.log(result);
						}
						$("[class^='hide']").hide();
						$("[class^='loc_hide']").hide();
						$(".modify_button2").hide();
					})
					.fail(function() {
						$("#tr").append("<h3>요청 실패!</h3>");
					});
					
					
					//---------------선반 위치 출력------------------
					$.ajax({
						type: "GET",
						url: "WareHouseLocInListJsonPro.wh",
						dataType: "json"
					})
					.done(function(wharealoclist) { // 요청 성공 시
						var wh_cd = Number($("#wh_hidden_value").val());
						idx=1;	
					for(let list of wharealoclist) {
							let tet = null;
							let test = '"'+list.wh_loc_in_area+'"';
							let result ="<tr id='tr"+list.wh_loc_in_area_cd+"' class='loc_hide"+list.wh_area_cd+"'>"
							+"<td scope='col'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id='text"+list.wh_loc_in_area_cd+"'><a href='javascript:void(0)' onclick='stocklist_area_loc("+wh_cd+","+list.wh_area_cd+","+list.wh_loc_in_area_cd+")'> 선반 위치 :"+list.wh_loc_in_area+ "</a></span></td>"
							+"<td><button class='btn btn-secondary' id='check_button"+idx+" onclick='loc_tableDelte("+list.wh_loc_in_area_cd+")'>삭제</button>"
							+"<button class='btn btn-secondary' id='modify_button2"+list.wh_loc_in_area_cd+"' onclick='modifyloc("+list+","+list.wh_loc_in_area_cd+")'>변경</button>"
							+"<button class='btn btn-secondary modify_button2' id='modify_button"+list.wh_loc_in_area_cd+"' onclick='modify_loc_info("+test+","+list.wh_loc_in_area_cd+")'>수정</button></td>"
							+"<td></td>"
							+"<input type='hidden' value='"+list.wh_area_cd+"' id='wh_area_cd'> "
							+"<input type='hidden' value='"+list.wh_loc_in_area_cd+"' id='loc_hidden_value'> "
							+"<input type='hidden' value='"+idx+"' id='idx'> "
							+"</tr>";
							$("#tr"+list.wh_area_cd).after(result);
							console.log(result);
							idx++;
						}
						$("[class^='loc_hide']").hide();
						$(".modify_button2").hide();
					})
					.fail(function() {
						$("#tr").append("<h3>요청 실패!</h3>");
					});
					
		});//제이쿼리 끝		
		//------창고 안 재고 리스트 출력
		function stocklist(wh_cd){
			$.ajax({
				type: "GET",
				url: "WareHouseStockListJsonPro.wh",
				data : {
					"wh_cd" : wh_cd,
				},
				dataType:"json"
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
				console.log(wh_cd);
				}else{
					$("#stocklist > tbody").html('');
				}
			})
			.fail(function() {
				$("table > tbody > tr").append("<h3>요청 실패!</h3>");
			});// 창고 리스트 출력
		}
		
		//창고 지역 수정 작업
		function modify(area,code){
			if(area != ""){
				var newText="<input type='text' id='test_text"+code+"'value='"+area+"'>";
				$("#test"+code).replaceWith(newText);
				$("#modify_button2"+code).hide();
				$("#modify_button"+code).show();
				alert("#test2"+code);
			}else {
				alert("창고 지역을 입력 해주세요!");
			}
		}
		
		function modify_info(area,code){
						
			var txt = document.getElementById("test_text"+code).value;
			var newText="&nbsp;<span id='test"+code+"'><a href='javascript:void(0)' onclick='stocklist("+code+")'>창고 구역:"+txt+"</a></span>";
			alert(txt);
			if(txt != ""){
			$.ajax({
				type: "GET",
				url: "WareHouseAreaUpdatePro.wh",
				data:{
					wh_area : txt,
					wh_area_cd : code
				}
			})
			.done(function(vo) { // 요청 성공 시
				alert("입력 확인");
				$("#test_text"+code).replaceWith(newText);
				$("#modify_button2"+code).show();
				$("#modify_button"+code).hide();
			})
			.fail(function() {
				alert("정보 실패");
			});
		}else{
			alert("창고 위치을 입력 해주세요!");
			return false;
		}
	}
		
		
		//---------창고 선반 구역 수정-------------
		function modifyloc(area,code){
			if(area != ""){	
				var newText="<input type='text' id='test2_text"+code+"'value='"+area+"'>";
				$("#text"+code).replaceWith(newText);
				$("#modify_button2"+code).hide();
				$("#modify_button"+code).show();
				alert("#test"+code);
			}else{
				alert("선반 위치를 입력 해주세요!");
				return false;
			}
		}
		
		function modify_loc_info(area,code){
			var txt = document.getElementById("test2_text"+code).value;
			var newText="&nbsp;<span id='text"+code+"'><a href='javascript:void(0)' onclick='stocklist("+code+")'>선반 위치:"+txt+"</a></span>";
			alert(txt);
			if(txt != ""){
			$.ajax({
				type: "GET",
				url: "WareHouseLocAreaUpdatePro.wh",
				data:{
					wh_loc_in_area : txt,
					wh_loc_in_area_cd : code
				}
			})
			.done(function(vo) { // 요청 성공 시
				alert("입력 확인");
				$("#test2_text"+code).replaceWith(newText);
				$("#modify_button2"+code).show();
				$("#modify_button"+code).hide();
				alert("#test3"+code);
			})
			.fail(function() {
				alert("정보 실패");
			});
		}else {
			alert("선반 위치를 입력 해주세요!");
			return false;
		}	
	}
		//--------------------수정 끝------------
		
		//--------창고 지역 minus 버튼-----------
		function loc_minus_button(cd) {
				$(".loc_hide"+cd).hide();	
			}//창고 지역 minus 끝
		
		//--------창고 지역 plus 버튼-----------
		function loc_plus_button(cd) {
				alert(cd);
				$(".loc_hide"+cd).show();
		}// 창고 지역 plus 버튼 끝
		
		//--------창고 지역 minus 버튼-----------
		function minus_button(cd,cc) {
			alert(cc);
			var bb =Number($("#loc_hidden_value").val());
			$(".hide"+cd).hide();
			$("#check_button"+bb).hide();
			}//창고 지역 minus 끝
		
		//--------창고 지역 plus 버튼-----------
		function plus_button(cd) {
					$(".hide"+cd).show();
		}// 창고 지역 plus 버튼 끝
			
		
		//--------상제 정보 출력-----------
		function info(wh_cd){
			alert("버튼 감지"+wh_cd);
			$.ajax({
				type: "GET",
				url: "WareHouseInfoJson.wh?wh_cd="+wh_cd,
				dataType: "json"
			})
			.done(function(vo) { // 요청 성공 시
				alert("정보 확인"+vo);
				$("#wh_cd").val(vo.wh_cd);
				$("#wh_name").val(vo.wh_name);
				$("#wh_location").val(vo.wh_location);
				$("#wh_addr").val(vo.wh_addr);
				$("#wh_addr_detail").val(vo.wh_addr_detail);
				$("#wh_tel1").val(vo.wh_tel1);
				$("#wh_tel2").val(vo.wh_tel2);
				$("#wh_tel3").val(vo.wh_tel3);
				$("#wh_man_name").val(vo.wh_man_name);
				$("#remarks").val(vo.remarks);
			})
			.fail(function() {
				alert("정보 실패");
			});
	}//상세 정보 끝
	
	
	<!-- 연락처 숫자만 입력되는 유효성 검사 -->
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	} 
	 
	function inputOnlyNumberFormat(obj) {
	    obj.value = onlynumber(uncomma(obj.value));
	}
	 
	function onlynumber(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
	}//연락처 숫자 유효성 검사 끝
	
	<!-- 이메일 영어만 -->
	function onlyEngNumber(str) {
		var regType1 = /^[A-Za-z0-9+]*$/; // regex : 영어, 숫자만 입력
		if (regType1.test(str.value)) { //영어, 숫자만 입력했을 때
		}else{//영어, 숫자를 제외한 값 입력 시
			str.value = ""; // ""으로 초기화
		}
	}//이메일 영어 끝
	
	
	//-----------창고 지역 입력---------
	function tableCreate(wh_cd){
		var no = Number($("#hidden_value").val()) + 1
		var tc = new Array();
		var html = '';
		let test = $("#wh_area").val();
		let wh_area = $("#wh_area"+wh_cd).val();
		alert(wh_area);
		alert(wh_cd);
		if(wh_area != ""){
		$.ajax({
			type: "GET",
			url: "WareHouseAreaInsertPro.wh",
			data:{
				"wh_area" : wh_area,
				"wh_cd" : wh_cd
			}
		})
		.done(function(vo) { // 요청 성공 시
			alert("입력 성공");
		})
		.fail(function() {
			alert("정보 실패");
		});
		html += '<tr id="tr'+no +'">';
		html += '<td>&nbsp;&nbsp;<button id="minus_loc'+no+'" name="minus" onclick="loc_minus_button('+no +')" class="btn" type="button">-</button>';
		html += '<button id="plus_loc'+no+'" name="plus" onclick="loc_plus_button('+no +')" class="btn" type="button">+</button>';
		html += '&nbsp;&nbsp;<span id="test'+no+'"><a href="javascript:void(0)" onclick="stocklist('+wh_cd+')">창고 지역:'+wh_area+'</a></span></td>';
		html += '<td><button class="btn btn-secondary" onclick="tableDelte('+no+')">삭제</button>';
		html += '<button class="btn btn-secondary" id="modify_button2" onclick="modify('+wh_area+','+no+')">변경</button>';
		html += '<button class="btn btn-secondary modify_button2" id="modify_button" onclick="modify_info('+wh_area+','+no+')">수정</button></td>';
		html += '</tr>';
		$("#tr"+wh_cd).after(html);
		$(".modify_button2").hide();
		$("#wh_area"+wh_cd).val("");
		$(document).on("click","#modify_button2",function(){
			$("#modify_button").show();
			$("#modify_button2").hide();
		});
		}else {
			alert("창고 위치를 입력 하세요");
		}	
	}// 창고 지역 입력 끝
		
		//-----------창고 선반 입력---------
		function loc_tableCreate(wh_cd){
			var no = Number($("#loc_hidden_value").val()) + 1
			var tc = new Array();
			var html = '';
			let wh_area_loc = $("#wh_area_loc"+wh_cd).val();
			alert(no);
			
			if(wh_area_loc != ""){
			$.ajax({
				type: "GET",
				url: "WareHouseLocAreaInsertPro.wh",
				data:{
					wh_loc_in_area : wh_area_loc,
					wh_area_cd : wh_cd
				}
			})
			.done(function(vo) { // 요청 성공 시
				alert("입력 확인");
			})
			.fail(function() {
				alert("정보 실패");
			});
			html += '<tr id="tr'+no +'">';
			html += '<td>&nbsp;&nbsp;<button id="minus_loc'+no+'" name="minus" onclick="loc_minus_button('+no +')" class="btn" type="button">-</button>';
			html += '<button id="plus_loc'+no+'" name="plus" onclick="loc_plus_button('+no +')" class="btn" type="button">+</button>';
			html += '&nbsp;&nbsp;<span id="test'+no+'"><a href="javascript:void(0)" onclick="stocklist('+no+')">창고 지역:'+wh_area_loc+'</a></span></td>';
			html += '<td><button class="btn btn-secondary" onclick="tableDelte('+no+')">삭제</button>';
			html += '<button class="btn btn-secondary" id="modify_button2" onclick="modify('+wh_area_loc+','+no+')">변경</button>';
			html += '<button class="btn btn-secondary modify_button2" id="modify_button" onclick="modify_info('+wh_area_loc+','+no+')">수정</button></td>';
			html += '</tr>';
			$("#tr"+wh_cd).after(html);
			$("#wh_area_loc"+wh_cd).val("");
			$("#modify_button").show();
			$("#modify_button2").hide();
			}else {
				alert("선반 위치를 입력 하세요");
				}// 창고 지역 입력 끝
			}
		
		//--------창고 지역 삭제 버튼-----------
		function tableDelte(code) {
			alert(code)
			$.ajax({
				type: "GET",
				url: "WareHouseAreadeletePro.wh?wh_area_cd="+code
							
			})
			.done(function() { // 요청 성공 시
				alert("정보 성공");
				$("#tr"+code).remove();
			})
			.fail(function() {
				alert("정보 실패");
			});
		}// 창고 지역 삭제 끝
		
		//--------창고 지역 삭제 버튼-----------
		function loc_tableDelte(code) {
			$.ajax({
				type: "GET",
				url: "WareHouseLocAreadeletePro.wh?wh_loc_in_area_cd="+code
			})
			.done(function() { // 요청 성공 시
				alert("정보 성공");
				$("#tr"+code).remove();
			})
			.fail(function() {
				alert("정보 실패");
			});
		}// 창고 지역 삭제 끝
		
		
		//------창고 안 재고 리스트 출력
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
					$("#stocklist > tbody").html('');
				}
			})
			.fail(function() {
				$("table > tbody > tr").append("<h3>요청 실패!</h3>");
			});// 창고 리스트 출력
		}
		//------창고 안 재고 리스트 출력
		function stocklist_area_loc(wh_cd,wh_area_cd,wh_loc_in_area_cd){
			alert(wh_loc_in_area_cd);
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
					$("#stocklist > tbody").html('');
				}
			})
			.fail(function() {
				$("table > tbody > tr").append("<h3>요청 실패!</h3>");
			});// 창고 리스트 출력
		}
		
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
     	  <div class="card-body">
       			<table id="table" class="table table-hover">
		                <thead>
		                  <tr>
                               <th scope="col">창고명</th>
                               <th scope="col">관리자명</th>
                               <th></th>
		                  </tr>
		                </thead>
		                <tbody>
		                </tbody>
		        </table>
       		</div>
       </div>
       <div class="card-body" style="padding: 50px 80px;">
  				<h1 align="center">재고 리스트</h1>
  				<table id="stocklist" class="table table-hover">  
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
			</div> <!-- card-body -->
		</div>
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>