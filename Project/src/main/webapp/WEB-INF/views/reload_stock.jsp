<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 오류메시지(msg) 출력 후 이전페이지로 돌아가기 --%>
<script>
var msg = "${msg}";
if(msg == "재고작업 성공")	{
	alert(msg);
	window.opener.location.reload();    //부모창 reload
	window.close();   
}else if(msg == "재고조정 후 이력 저장 실패" || msg =="재고이동 후 이력 저장 실패" || msg == "재고조정 실패" || msg == "재고이동 실패"){
	alert(msg);
	history.back();
	location.reload();
}
</script> 