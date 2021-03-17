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
				<div id="contentDiv" style="padding:10px; width:850px; height:500px; overflow:auto; resize: none; border:1px solid black;">
					${dto.content}
				</div>
			</div>
		</div>
		<div class="row">
			<div style='width:150px; text-align: center;'>
				첨부파일
			</div>
			<div>
				<c:if test="${fileDto.no==0||fileDto.no==null}">
					파일없음
				</c:if>
				<a href="download/${fileDto.no}" onmouseover="imgPreView('show');" onmouseout="imgPreView('hide');">
					<img src="/file/${fileDto.fileName}" id="uploadedImg" style="display:none;">
					<span id="uploadedImgName">
						${fileDto.origFileName}
					</span>
				</a>
			</div>
		</div>
		<div id="replyDiv"></div>
		<div class="row">	
			<div class="btn">
				<div style="width:400px; display:flex; justify-content: space-around;">
					<div>
						<input type="button" value="글쓰기" onclick="move('reg','${pageNumber}');" id="btnSave">
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
function imgPreView(proc){
	if(proc=='show') {
		$('#uploadedImg').show();
		$('#uploadedImgName').hide();
	}
	if(proc=='hide') {
		$('#uploadedImg').hide();
		$('#uploadedImgName').show();
	}
}
function move(v_location, v_pageNumber, v_no){
	var queryString = "?pageNumber="+v_pageNumber+"&no="+v_no;
	location.href=v_location+queryString;
}
</script>