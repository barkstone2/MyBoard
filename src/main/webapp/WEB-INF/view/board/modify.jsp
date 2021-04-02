<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
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
*:focus { 
 	outline:none;
}
.f-vert-center{
	align-items: center;
}
</style>
<form style="width:900px; border: 1px solid black;" method="post" name="chugaForm" enctype="multipart/form-data">
	<div id="formTitle">
		<h2>게시글 수정</h2>
		<input type="hidden" value="${dto.no}" name="no">
	</div>
	<div class="row">
		<div class="label">
			분류
		</div>
		<div>
			<select class="longInput" id="categorySelect" name="category">
				<option>선택</option>
			<c:forEach var="category" items="${categoryList}">
				<option value="${category.name}">${category.name}</option>
			</c:forEach>
			</select>
		</div>
	</div>
	<div class="row">
		<div class="label">
			제목
		</div>
		<div>
			<input type="text" name="title" value="${dto.title}" id="subject" class="longInput">
		</div>
	</div>
	<div class="row f-vert-center">
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
	<div class="row">
		<div class="label">
			첨부파일
		</div>
		<div>
			<input type="text" readonly="readonly" id="imgName" placeholder="파일 없음" value="${fileDto.origFileName}">
			<button class="imgbtn" type="button" onclick="selectFile();">파일선택</button>
			<button class="imgbtn" type="button" onclick="deleteFile();">파일삭제</button>
			<div style="display:none;">
				<input type="hidden" name="fileDelChk" id="fileDelChk" value="0">
				<input type="file" name="imgFile" id="attachedImg" accept="image/*"><br>
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

var currentCategory = '${category}';
var categorySelect = document.querySelector('#categorySelect');
if(currentCategory != '전체'){
	categorySelect.value = '${category}';
}

categorySelect.value = '${dto.category}';

function selectFile(){
	$('#attachedImg').click();
}
function deleteFile(){
	$('#imgName').val('');
	$('#fileDelChk').val('1');
}
$(document).ready(function(){ 
	var fileTarget = $('#attachedImg'); 
	fileTarget.on('change', function(){ 
		// 값이 변경되면 
		if(window.FileReader){ 	// modern browser 
			var filename = $(this)[0].files[0].name; 
		} else { // old IE 
			var filename = $(this).val().split('/').pop().split('\\').pop(); 
			// 파일명만 추출 
		} 
		// 추출한 파일명 삽입 
		$('#imgName').val(filename);
		});
});
function attachImg(){
	var url = 'imguploader';
	var windowName = '이미지 업로더';
	var option = 'width=650, height=800, top=200, left=600';
	window.open(url,windowName, option);
}

function move(proc, v_page, v_no, v_ctg, v_ctgp, v_order){
	var sop;
	var sd;
	if(proc=='search'){
		proc = 'list';
		v_page = '1';
		sop = $('#search_option').val();
		sd = $('#search_data').val();
	}else if(proc == 'searchClear'){
		proc = 'list';
		v_page = '1';
		sop = '';
		sd = '';
	}else if(proc=='modify'){
		$('#content').val($("#contentDiv").html());
		$('form').submit();
		return;
	}
	else{
		sop = '${searchOption}';
		sd = '${searchData}';
	}
	
	var page = '${page}';
	var no = '${no}';
	var ctg = '${category}';
	var ctgp = '${categoryPage}';
	var od = '${order}';
	if(v_ctg != null) ctg = v_ctg;
	if(v_ctgp != null) ctgp = v_ctgp;
	if(v_page != null) page = v_page;
	if(v_no != null) no = v_no;
	if(v_order != null) od = v_order;
	
	var queryString = "?p="+page+"&no="+no
					+"&s_op=" + sop
					+"&s_d=" + sd
					+"&ctg=" + ctg
					+"&ctgp=" + ctgp
					+"&od=" + od;
	location.href = proc + queryString;
}
</script>