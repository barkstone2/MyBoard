<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
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
			<div>
				${dto.id}
			</div>
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
			<div>
				<input type="text" name="nickName" value="${dto.nickName}">
			</div>
		</div>
		<div class="flex">
			<div class="label">
				이메일
			</div>
			<input type="text" name="email1" value="${fn:substringBefore(dto.email,'@')}">
			<span class="email_deco">@</span>
			<input type="text" name="email2" id="email2" value="${fn:substringAfter(dto.email,'@')}">
			<select id="email_list">
				<option value="self" selected="selected">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="hotmail.com">hotmail.com</option>
				<option value="nate.com">nate.com</option>
			</select>
		</div>
		<button type="button" onclick="move('modify');">저장하기</button>
	</form>
</body>
<script>
function move(proc){
	if(proc == 'modify'){
		$('form').submit();
	}
}
var email = $('#email2').val();
var selectChk = 0 != $("#email_list option[value='"+email+"']").length;
if(selectChk){
	$('#email_list').val(email).prop('selected', true);
}

$('#email_list').on('change',function(){
	var email2 = $('#email_list').val();
	if(email2=='self'){
		$('#email2').attr('readonly',false);
	}else{
		$('#email2').attr('readonly',true);
		$('#email2').val($('#email_list').val());
	}
});
</script>
</html>