<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<form>
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
		<button type="button">로그인</button>
	</form>
</body>
</html>