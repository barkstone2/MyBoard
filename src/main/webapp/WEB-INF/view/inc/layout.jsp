<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<style>
html, body{
	margin: 0;
	padding: 0;
}
.header{
	width:100%;
	height: 80px;
	display:flex;
	align-items: center;
	border-bottom: 1px solid;
}
.main{
	width: 100%;
	min-height: 800px;
	display: flex;
	align-items: center;
	justify-content: center;
}
</style>

<header class="header">
	<tiles:insertAttribute name="header" />
</header>

<main class="main">
	<tiles:insertAttribute name="main" />
</main>