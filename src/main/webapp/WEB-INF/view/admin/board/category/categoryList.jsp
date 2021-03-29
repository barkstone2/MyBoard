<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/inc/inc_header.jsp"%>
    
    <c:if test="${categoryPage!=1}">
    	<c:set value="${categoryPage-1}" var="preCategoryPage"/>
	</c:if>
	<c:if test="${categoryPage!=totalCategoryPage}">
		<c:set value="${categoryPage+1}" var="nextCategoryPage"/>
	</c:if>
	<img class="icon" src="/icon/icon_left.png" onclick="categoryMove('${preCategoryPage}');">
	<div class="category-list">
		<div class="category-content 전체" onclick="move('list', '1', '', '전체')">
			전체
		</div>
		<c:forEach var="category" items="${categoryList}">
		<div class="category-content ${category}" onclick="move('list', '1', '', '${category}', '${categoryPage}')">
			${category}
		</div>
		</c:forEach>
	</div>
	<img class="icon" src="/icon/icon_right.png" onclick="categoryMove('${nextCategoryPage}');">
	
