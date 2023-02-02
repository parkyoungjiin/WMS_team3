<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<div class ="sidevar">
		<ul class ="side-menu">
			<li>
				<a href="" class="title">인사관리</a>
				<ul class="side-submenu">
					<li><a href="EmpInsertForm.em" class="sub-title">사원 등록</a></li>
					<li><a href="#" class="sub-title">사원 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="" class="title">재고관리</a>
				<ul class="side-submenu">
					<li>
					<!-- 기본 등록 -->
					<a href="#" class="sub-title">기본 등록</a>
						<ul class="side-submenu">
							<li><a href="WareHouseListPro.wh">창고 등록</a></li>
							<li><a href="BuyerList">거래처 등록</a></li>
							<li><a href="#">품목 등록</a></li>
						</ul>
					</li>
					<!-- 구매 -->
					<li>
					<a href="#" class="sub-title">구매 관리</a>
					<ul class="side-submenu">
						<li><a href="#">발주 요청</a></li>
						<li><a href="#">구매 작업</a></li>
					</ul>
					</li>
					<!-- WMS -->
					<li>
					<a href="#" class="sub-title">WMS</a>
						<ul class="side-submenu">
							<li><a href="#">창고 관리</a></li>
							<li><a href="#">입고 관리</a></li>
							<li><a href="#">출고 관리</a></li>
							<li><a href="#">재고 조정</a></li>
						</ul>
					</li>
					
				</ul>
			</li>
		</ul>
	</div>
</body>
</html>