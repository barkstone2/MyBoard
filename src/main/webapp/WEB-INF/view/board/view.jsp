<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/inc_header.jsp" %>
<style>
.row{
	display:flex;
	padding:5px;
}
.label{
	width:120px;
	text-align: center;
}
.longInput{
	width:770px;
}
.shortInput{
	width: 190px;
}
.radioInp{
	display:flex;
	width:500px;
	justify-content: space-around;
}
.btn{
	display:flex;
	width:900px;
	justify-content: space-around;
	padding: 10px;
}
#formTitle{
	text-align: center;
}
.shotLine{
	display:flex;
	margin-right: 30px;
}
</style>
<div>
	<form style="width:900px; border: 1px solid black;" method="post" name="chugaForm">
		<div id="formTitle">
			<h2>게시글 보기</h2>
		</div>
		<div class="row">
			<div class="label">
				제목
			</div>
			<div>
				${dto.title}
			</div>
		</div>
		<div class="row">
			<div class="shotLine">
				<div class="label">
					작성자
				</div>
				<div>
					${dto.writer}
				</div>
			</div>
		</div>
		<div class="row">
			<div class="shotLine">
				<div class="label">
					조회수
				</div>
				<div>
					${dto.hit}
				</div>
			</div>
		</div>
		<div class="row" style="display:flex; justify-content: center;">	
			<div>
				<textarea name="bContent" style="padding:10px; width:850px; height:500px; resize: none; 
				background-color: transparent; color: black; border: 1px solid black;" disabled="disabled">${dto.content}</textarea>
			</div>
		</div>
		<div id="replyDiv"></div>
		<div class="row">	
			<div class="btn">
				<div style="width:400px; display:flex; justify-content: space-around;">
					<div>
						<input type="button" value="글쓰기" onclick="move('chuga','${pageNumber}');" id="btnSave">
					</div>
					<div>
						<input type="button" value="답변쓰기" onclick="move('answer','${pageNumber}','${dto.no}');" id="btnSave">
					</div>
					<div>
						<input type="button" value="수정하기" onclick="move('modify','${pageNumber}','${dto.no}');" id="btnSave">
					</div>
					<div>
						<input type="button" value="삭제하기" onclick="move('delete','${pageNumber}','${dto.no}');" id="btnSave">
					</div>
					<div>
						<input type="button" value="목록으로" onclick="move('list','${pageNumber}');" id="btnList">
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<script>
</script>