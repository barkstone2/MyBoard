<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 보기</title>
<style>
.flex{
	display: flex;
}
.label{
	width:100px;
	text-align: center;
}
.email_deco{
	padding: 0px 5px 0px 5px;
}
.f-center{
	align-items: center;
}
</style>
</head>
<body>
	
	${cookNo}
	<div class="flex">
		<div class="label">
			아이디
		</div>
		<div>
			dummyId
		</div>
	</div>
	<div class="flex">
		<div class="label">
			닉네임
		</div>
		<div>
			더미
		</div>
	</div>
	<div class="flex">
		<div class="label">
			가입일
		</div>
		<div>
			2020-05-16
		</div>
	</div>
	<div class="flex">
		<div class="label">
			이메일
		</div>
		<div>
			dummy@gmail.com
		</div>
	</div>
	
	<div class="flex">
		<div class="label">
			아이디
		</div>
		<div>
			${dto.id}
		</div>
	</div>
	<div class="flex">
		<div class="label">
			닉네임
		</div>
		<div>
			${dto.nickName}
		</div>
	</div>
	<div class="flex">
		<div class="label">
			가입일
		</div>
		<div>
			${dto.regDate}
		</div>
	</div>
	<div class="flex">
		<div class="label">
			이메일
		</div>
		<div>
			${dto.email}
		</div>
	</div>
	<button type="button" onclick="move('modify');">회원정보 수정</button>
	
</body>
<script>
	function move(proc){
		location.href=proc;
	}
</script>
</html>