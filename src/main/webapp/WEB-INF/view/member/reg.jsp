<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
	
	<form method="post">
		<div class="flex">
			<div class="label">
				아이디
			</div>
			<input type="text" name="id">
		</div>
		<div class="flex f-center">
			<div class="label">
				비밀번호
			</div>
			<div>
				<div>
					<input type="password" name="pwd" placeholder="비밀번호를 입력해 주세요.">
				</div>
				<div>
					<input type="password" name="pwdc" placeholder="비밀번호를 재확인해 주세요.">
				</div>
			</div>
		</div>
		<div class="flex">
			<div class="label">
				닉네임
			</div>
			<input type="text" name="nickName">
		</div>
		<div class="flex">
			<div class="label">
				이메일
			</div>
			<input type="text" name="email1">
			<span class="email_deco">@</span>
			<input type="text" name="email2" id="email2">
			<select id="email_list">
				<option value="self">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="hotmail.com">hotmail.com</option>
				<option value="nate.com">nate.com</option>
			</select>
		</div>
		<button type="button" onclick="move('reg');">가입하기</button>
	</form>
	
<script>
function move(proc){
	if(proc == 'reg') document.querySelector("form").submit();
}

const emailList = document.querySelector("#email_list");
const email2 = document.querySelector("#email2");

function handleChange(){
	if(emailList.value==`self`){
		email2.removeAttribute("readonly");
	}else{
		email2.setAttribute(`readonly`, true);
		email2.value = emailList.value;
	}
}

emailList.addEventListener('change', handleChange);
</script>
	
</body>
</html>