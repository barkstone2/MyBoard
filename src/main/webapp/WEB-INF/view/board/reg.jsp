<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.row{
	display:flex;
	padding:5px;
	align-items: center;
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
#img-attach-icon{
	cursor: pointer;
}
</style>
<form style="width:900px; border: 1px solid black;" method="post" name="chugaForm" enctype="multipart/form-data">
	<div id="formTitle">
		<h2>게시글 작성</h2>
	</div>
	<div class="row">
		<div class="label">
			제목
		</div>
		<div>
			<input type="text" name="title" id="subject" class="longInput">
		</div>
	</div>
	<div class="row">
		<div class="shotLine">
			<div class="label">
				작성자
			</div>
			<div>
				<input type="text" name="writer" id="bWriter" class="shortInput">
			</div>
		</div>
		<div class="shotLine">
			<div class="label">
				비밀번호
			</div>
			<div>
				<input type="text" name="pwd" id="bPasswd" class="shortInput">
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
			<textarea name="content" id="bContent" style="width:850px; height:500px; resize: none;"></textarea>
		</div>
	</div>
	<div class="row">
		<div style='width:150px; text-align: center;'>
			이미지 업로드
		</div>
		<div>
			<input type="file" name="imgFile" accept="image/*">
		</div>
	</div>
	<div class="row">	
		<div class="btn">
			<div style="width:300px; display:flex; justify-content: space-around;">
				<div>
					<button type="submit">작성하기</button>
				</div>
				<div>
					<button type="button" onclick="move('list')">목록으로</button>
				</div>
			</div>
		</div>
	</div>
	<div>
		<input type="hidden" name="boardType" id="boardType" value="${boardType}">
		<input type="hidden" name="bMemberNo" id="bMemberNo" value="">
	</div>
</form>
<script>
function move(v_location){
	location.href=v_location;
}
function attachImg(){
	var url = 'img_uploader.html';
	var windowName = '이미지 추가';
	var option = 'width=800, height=800, top=300, left=600';
	window.open(url,windowName, option);
}
</script>