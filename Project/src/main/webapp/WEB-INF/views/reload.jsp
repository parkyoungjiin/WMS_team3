<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 오류메시지(msg) 출력 후 이전페이지로 돌아가기 --%>
<script>
var msg = "${msg}";
if(msg == "입고 처리 되었습니다!" )	{
	alert(msg);
	window.opener.location.reload();    //부모창 reload
	window.close();   
}else{
	alert("입고 실패 되었습니다!");
	history.back();
}
	//현재 팝업창 Close
</script> 