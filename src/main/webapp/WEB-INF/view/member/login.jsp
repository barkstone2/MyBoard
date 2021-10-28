<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
.flex{
	display: flex;
}
.label{
	text-align: center;
	width:120px;
}
</style>
</head>
<body>
	<form method="post">
		<div class="flex">
			<div class="label">
				아이디
			</div>
			<input type="text" name="id">
		</div>
		<div class="flex">
			<div class="label">
				비밀번호
			</div>
			<input type="password" name="pwd">
		</div>
		<button type="button" onclick="move('login')">로그인</button>
		<button type="button" onclick="move('reg')">회원가입</button>
	</form>
</body>
<script>
	function move(proc){
		if(proc == 'login'){
			$('form').submit();
		}else{
			location.href=proc;
		}
	}
</script>
</html>