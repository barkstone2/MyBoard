<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/inc/inc_header.jsp"%>
<style>
button{
	width:80px;
	height:30px;
	border-radius:5px;
	background-color:#3498db;
    color:white;
    border:none;
    cursor:pointer;
}
</style>
<!DOCTYPE html>
<form method="post" id="pwForm" name="pwForm">
	<input type="hidden" name="no" value="${no}">
	비밀번호 : <input type="password" id="pwd" name="pwd"><br><br>
	<div style="display:flex; justify-content:space-around;">
		<button type="button" onclick="pwProc();">확인</button>
		<button type="button" onclick="history.back();">취소</button>
	</div>
</form>
<script>
const reqUrl = '${reqUrl}';
const no = `${no}`;

function pwProc(){
	var pwd = document.querySelector("#pwd").value;
	var queryString = "?p="+`${page}`+"&no="+`${no}`
	+"&s_op=" + '${searchOption}'
	+"&s_d=" + '${searchData}';
	if(reqUrl == "delete"){
		var form = document.querySelector("#pwForm");
		form.action = reqUrl;
		document.querySelector("#pwForm").submit();
	}else{
		location.href = reqUrl + queryString + "&pwd=" + pwd;
	}
}
</script>


 
