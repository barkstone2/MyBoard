<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style>
.admin-menu{
	padding:10px;
	border-radius: 12px;
	margin:10px;
	background-color: #8FD6CE;
	cursor: pointer;
}
.admin-menu:hover{
	background-color: #ff9393;
}
.flex{
	color: black;
}
</style>

<div class="flex">
	<a class="flex" href="/admin/board/list">
		<span class="admin-menu am-board">
		게시판 관리
		</span>
	</a>
	<a class="flex" href="/admin/category/list">
		<span class="admin-menu am-category">
			카테고리 관리
		</span>
	</a>
	<a class="flex" href="/admin/member/list">
		<span class="admin-menu am-member">
			회원 관리
		</span>
	</a>
</div>

<script>
var requestPath = window.location.pathname;
var firstIndex = requestPath.indexOf("/",1)+1;
var secondIndex = requestPath.indexOf("/",firstIndex);
var menuName = "am-" + requestPath.substring(firstIndex, secondIndex);
var menuDiv = document.querySelector("."+menuName);
menuDiv.style.backgroundColor = "#ff4747";

</script>
 