<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form method="post">
	<input type="hidden" name="no" value="${no}">
	<input type="password" name="pwd">
	<button type="submit">확인</button>
	<button type="button" onclick="move('view','${pageNumber}','${no}')">취소</button>
</form>
<script>
function move(v_location, v_pageNumber, v_no){
	var queryString = "?pageNumber="+v_pageNumber+"&no="+v_no;
	location.href=v_location+queryString;
}
</script>