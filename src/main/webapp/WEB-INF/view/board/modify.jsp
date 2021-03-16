<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.row{
	display:flex;
	padding:5px;
}
.label{
	width:100px;
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
<form style="width:900px; border: 1px solid black;" method="post" name="chugaForm">
	<div id="formTitle">
		<h2>게시글 수정</h2>
		<input type="hidden" value="${dto.no}" name="no">
	</div>
	<div class="row">
		<div class="label">
			제목
		</div>
		<div>
			<input type="text" name="title" value="${dto.title}" id="subject" class="longInput">
		</div>
	</div>
	<div class="row">
		<div class="shotLine">
			<div class="label">
				작성자
			</div>
			<div>
				<input type="text" name="writer" value="${dto.writer}" id="bWriter" class="shortInput">
			</div>
		</div>
		<div class="shotLine">
			<div class="label">
				비밀번호
			</div>
			<div>
				<input type="text" name="pwd" value="${dto.pwd}" id="bPasswd" class="shortInput">
			</div>
		</div>
		<div class="shotLine">
			<div id="img-attach-icon">
				<a href="#" onclick="attachImg();">
					<img src="/icon/icon_img_attach.png">
				</a>
			</div>
		</div>
	</div>
	<div class="row" style="display:flex; justify-content: center;">	
		<div>
			<div contentEditable="true" id="contentDiv" style="padding:5px; width:850px; height:500px; overflow:auto; border:1px solid black;">
				${dto.content}
			</div>
			<textarea name="content" id="content" hidden="hidden"></textarea>
		</div>
	</div>
	<div class="row">	
		<div class="btn">
			<div style="width:300px; display:flex; justify-content: space-around;">
				<div>
					<button type="button" onclick="move('modify');">수정하기</button>
				</div>
				<div>
					<button type="button" onclick="move('view','${pageNumber}','${dto.no}')">돌아가기</button>
				</div>
				<div>
					<button type="button" onclick="move('list','${pageNumber}')">목록으로</button>
				</div>
			</div>
		</div>
	</div>
</form>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
function attachImg(){
	var url = 'imgUploader';
	var windowName = '이미지 업로더';
	var option = 'width=650, height=800, top=200, left=600';
	window.open(url,windowName, option);
}
function move(v_location, v_pageNumber, v_no){
	var queryString = "?pageNumber="+v_pageNumber+"&no="+v_no;
	if(v_location=='modify'){
		$('#content').val($("#contentDiv").html());
		$('form').submit();
		return;
	}
	location.href=v_location+queryString;
}
</script>