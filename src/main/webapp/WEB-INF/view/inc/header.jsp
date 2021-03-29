<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
nav{
	display:flex;
}
.menu{
	display:flex;
	align-items: center;
}
.main-menu{
	display: flex;
	position: absolute;
	left: 33%;
}
.main-menu > div{
	padding: 0px 8px 0px 8px;
}
.user-menu{
	position: absolute;
	right: 5%;
	text-align: center;
}
.icon{
	width: 30px;
	height: 30px;
}
.on-login{
	display: flex;
	align-items: center;
}
.on-login > div{
	padding: 0px 5px 0px 5px;
}
.link-component{
	cursor: pointer;
	color: #0208d6;
}
</style>


<nav class="menu">
	<div class="main-menu">
		<div>
			HOME
		</div>
		<div>
			<a href="/board/list">게시판</a> 
		</div>
		<div>
			<a href="/admin/board/list">관리자</a>
		</div>
	</div>
	<div class="user-menu">
		<div class="non-login">
			<a href="/member/login">로그인</a>
		</div>
		<div class="on-login">
			<div class="link-component" onclick="location.href='/member/view'">
				${user.nickName}님
			</div>
			<div class="link-component" onclick="location.href='/member/view'">
				<img class="icon" src="/icon/member_profile_icon.png">
			</div>
			<div>
				<a href="/member/logout">로그아웃</a>
			</div>
		</div>
	</div>
</nav>
<script>
const user = `${user}`;
	if(user!=null&&user!=''){
		document.querySelector(".on-login").style.display = "flex";
		document.querySelector(".non-login").style.display = "none";
	}else{
		document.querySelector(".on-login").style.display = "none";
		document.querySelector(".non-login").style.display = "flex";
	}
</script>
<!-- 
	이름 클릭시 비밀번호 입력창 이동
	비밀번호 확인 후 회원정보 수정 페이지 이동
	본인 회원 메뉴에는 정보보기 창 필요없음
	정보 수정만 있으면 그만
	그 안에 회원탈퇴 버튼도 넣기
	
	
	다른 회원이 정보보기 누르면 보여지는 창 따로 만들기
	게시글이나 댓글에서 아이디 눌러서 정보보기 하면 나오는 창
 -->
 
 