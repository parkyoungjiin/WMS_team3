<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
	
	var codeStatus = false;

	$(function() {
		
		//업태, 종목 항목 input 태그 추가
		$("#plus_uptae").on("click", function() {
			var addInput = '<input type="text" class="form-control" name="uptae">&nbsp';
// 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_uptae]:first");
			trHtml.before(addInput);
		});
		
		$("#plus_jongmok").on("click", function() {
			var addInput = '<input type="text" class="form-control" name="jongmok">&nbsp';
// 							+'<i class="fa-solid fa-minus" id="deleteInput" style="cursor: pointer;"></i>&nbsp';
			var trHtml = $("[name=orgInput_jongmok]:first");
			trHtml.before(addInput);
		});
		
		
	});
	
	//  코드 중복 체크
	$("#prod_cd_btn").on("click", function() {
		let product_cd = $("#product_cd").val();
		$.ajax({
			type: "GET",
			url: "ProdCodeCheck?product_cd="+product_cd,
			data: {product_cd:$("#product_cd").val()},
			dataType: "html",
			success: function(data){
				if(data == 0){
					alert("사용 가능한 코드입니다.");
					$("#fr").attr("onsubmit","return true");
// 					codeStatus = true;
				}else if(data == 1){
					alert("사용 불가능한 코드입니다.");
					$("#product_cd").val('');
					$("#product_cd").focus();
					$("#fr").attr("onsubmit","return false");				
// 					codeStatus = false;
				}
			}
		}).fail(function(result) {
			alert("중복아님");
		});
	});// 코드 중복 확인 끝	
	
	
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
	}
	
	<!-- 이메일 영어만 -->
	function onlyEngNumber(str) {
		var regType1 = /^[A-Za-z0-9+]*$/; // regex : 영어, 숫자만 입력
		if (regType1.test(str.value)) { //영어, 숫자만 입력했을 때
		}else{//영어, 숫자를 제외한 값 입력 시
			str.value = ""; // ""으로 초기화
		}
	}//onlyEngNumber 끝
	
	// 등록 작업 막기
	function fn_registerBuyer(){
		if(codeStatus == false){
			alert("거래처 코드를 확인해주세요");
			event.preventDefault();
		}
	}
	
	// 이미지 썸네일
		$('#product_image').change(function(){
	    setImageFromFile(this, '#thumbnail');
	});
	
// 	function setImageFromFile(input, expression) {
// 	    if (input.files && input.files[0]) {
// 	        var reader = new FileReader();
// 	        reader.onload = function (e) {
// 	            $(expression).attr('src', e.target.result);
// 	        }
// 	        reader.readAsDataURL(input.files[0]);
// 	    }
// 	}
  
              // 이미지 썸네일222
//               function readURL(input) {
// 				  if (input.files) {
// 				    var reader = new FileReader();
// 				    reader.onload = function(e) {
// 				    	$('#thumbnail').attr('src', e.target.result); 
// // 				      document.getElementById('thumbnail').src = e.target.result;
// 				    };
// 				    reader.readAsDataURL(input.file);
// 				  } else {
// 				    document.getElementById('thumbnail').src = "";
// 				  }
// 				}
          $("#file").on("change", function(e) {
						var tmp = e.target.files[0];
					  var img = URL.createObjectURL(tmp);
					  $("#product_image").attr("src", img);
					});
	
	
</script>

</head>
<body>
	
<main id="main" class="main">

   <div class="pagetitle" style="text-align: center;">
     <h1>품목 등록</h1>
   </div><!-- End Page Title -->
    
	<div class="card mb-4">
		<div class="card-header">
            품목 등록
        </div>
        
       <div class="card-body">
         <!-- Floating Labels Form -->
            <form action="ProdInsertPro" method="post" class="row g-3">
              
              <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="product_cd" id="product_cd" required placeholder="품목코드">
                    <label for="floatingName">품목 코드</label>
                  	</div>
                    <button id="prod_cd_btn" class="btn btn-secondary" type="button" >조회</button>
                  </div>
                </div>
               </div> 
                
<!--                 <div class="col-md-3"> -->
<!--                     <button type="button" class="btn btn-primary" onclick="checkCode()">fn</button> -->
<!--                 </div> -->
                
              <div></div>
              <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="product_name" id="product_name" required placeholder="거래처코드">
                    <label for="floatingName">품목명</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>
               
                <div class="col-lg-12">  
                <div></div>
                 <label class="form-label"></label>
                  <div class= "col-md-12">
                	<div class="input-group mb-1">
                      <div class="form-floating">
		                    <input type="text" class="form-control" name="product_group_bottom_cd" id="product_group_bottom_cd"  placeholder="품목 그룹">
		                    <label for="floatingName">품목 그룹</label>
                  	  </div>
                      <button id="" class="btn btn-secondary" type="button" onclick="location.href='ProductGroupForm'">검색</button>
                      <input type="text" class="form-control" name="" id="">
	                    <div class="form-floating">
	                   </div>
                    </div>
                   </div>
              </div>  
                
              
                <div></div>
               <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="size_des" id="size_des" required placeholder="규격">
                    <label for="floatingName">규격</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>
                
                
              <fieldset class="row mb-6">
                  <div class="col-sm-10"> 단위<br>   
                      <input class="form-check-input" type="radio" name="unit" value="SET" checked>
                        &nbsp;01 SET&nbsp;
                      <input class="form-check-input" type="radio" name="unit"  value="BOX">
                        &nbsp;02 BOX&nbsp;
                      <input class="form-check-input" type="radio" name="unit"  value="EA">
                        &nbsp;03 EA&nbsp;
                  </div>
                </fieldset>
                
              <div></div>
               <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="barcode" id="barcode" required placeholder="바코드">
                    <label for="floatingName">바코드</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>
              
				<div></div>
               <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="in_unit_price" id="in_unit_price" required placeholder="입고단가">
                    <label for="floatingName">입고단가</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>              

             <div></div>
               <div class="col-lg-6">  
                <div class="col-md-12">
                <div class="input-group mb-1">
                  <div class="form-floating">
                    <input type="text" class="form-control" name="out_unit_price" id="out_unit_price" required placeholder="출고단가">
                    <label for="floatingName">출고단가</label>
                  	</div>
                    <button class="btn btn-secondary" type="button" onclick="checkCode()">fn</button>
                  </div>
                </div>
               </div> 
                <div></div>  
              
              <fieldset class="row mb-6">
                  <div class="col-sm-10">
                  	품목 구분 <br>
                      <input class="form-check-input" type="radio" name="product_type_cd"  value="원재료" checked>
                        &nbsp;01 원재료&nbsp;
                      <input class="form-check-input" type="radio" name="product_type_cd"  value="부재료">
                        &nbsp;02 부재료&nbsp;
                      <input class="form-check-input" type="radio" name="product_type_cd"  value="제품">
                        &nbsp;03 제품&nbsp;
                      <input class="form-check-input" type="radio" name="product_type_cd" value="반제품">
                        &nbsp;04 반제품&nbsp;
                      <input class="form-check-input" type="radio" name="product_type_cd" value="상품">
                        &nbsp;05 상품&nbsp;
                  </div>
                </fieldset>
                
               <div class="col-lg-12">  
                <div></div>
                 <label class="form-label"></label>
                  <div class= "col-md-12">
                	<div class="input-group mb-1">
                      <div class="form-floating">
		                    <input type="text" class="form-control" name="business_no" id="business_no"  placeholder="구매 거래처">
		                    <label for="floatingName">구매 거래처</label>
                  	  </div>
                      <button id="" class="btn btn-secondary" type="button">검색</button>
                      <input type="text" class="form-control" name="b_search" id="b_search">
	                    <div class="form-floating">
	                   </div>
                    </div>
                   </div>
              </div>  
              
               <div></div>
             <!-- 이미지 업로드 폼 -->
             <div class="row mb-3">
                  <label for="inputNumber" class="col-sm-2 col-form-label">Image Upload</label>
                  <div class="col-sm-10">
                    <input class="form-control" type="file" id="product_image" name="product_image" onchange="readURL(this);" accept=".png, .jpeg, .jpg">
                    <img id="thumbnail" width="100px" height="100px;" src="" alt="../resources/image/noImg.png">
                    
                  </div>
                </div>
                
                <div></div>
                <div class="col-12">
                  <div class="form-floating">
                    <textarea class="form-control" placeholder="적요" id="remarks" style="height: 100px;" name="remarks"></textarea>
                    <label for="floatingTextarea">적요</label>
                  </div>
                </div>
                <div></div>
                
                <div class="text-left" >
                  <button type="submit" class="btn btn-primary" onclick="fn_registerBuyer()">등록</button>
                  <button type="reset" class="btn btn-secondary">다시쓰기</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
                
                
                
              
<!--               <div class="col-lg-6">   -->
<!--                 <div class="col-md-12"> -->
<!--                   <div class="form-floating"> -->
<!--                     <input type="text" class="form-control" name="fax" placeholder="팩스"> -->
<!--                     <label for="floatingName">큰칸!</label> -->
<!--                   </div> -->
<!--                 </div> -->
<!--                </div>  -->
               
                
              </form><!-- End floating Labels Form -->      
			</div>
		</div>
	</main>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
</body>
</html>