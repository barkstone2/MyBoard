<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
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
.hidden{
	display: none;
}
option{
	padding:10px;
}
.writer-info{
	display:flex;
}
</style>
<form style="width:900px; border: 1px solid black;" method="post" name="chugaForm" enctype="multipart/form-data">
	<div id="formTitle">
		<h2>게시글 작성</h2>
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
			<input type="text" name="title" id="subject" class="longInput">
		</div>
	</div>
	<div class="row">
		<div class="user-info row"></div>
		<div class="writer-info">
			<div class="shotLine">
				<div class="label">
					작성자
				</div>
				<div>
					<input type="text" name="writer" id="writer" class="shortInput">
				</div>
			</div>
			<div class="shotLine">
				<div class="label">
					비밀번호
				</div>
				<div>
					<input type="password" name="pwd" id="pwd" class="shortInput">
				</div>
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
			<input type="file" name="imgFile" accept="image/*">
		</div>
	</div>
	<div class="row" style="display:flex; justify-content: center;">	
		<div>
			<div contentEditable="true" id="contentDiv" style="padding:5px; width:850px; height:500px; overflow:auto; border:1px solid black;">
			</div>
			<textarea name="content" id="content" hidden="hidden"></textarea>
		</div>
	</div>
	<div class="row">	
		<div class="btn">
			<div style="width:300px; display:flex; justify-content: space-around;">
				<div>
					<button type="button" onclick="move('reg');">작성하기</button>
				</div>
				<div>
					<button type="button" onclick="move('list')">목록으로</button>
				</div>
			</div>
		</div>
	</div>
	<div>
		<input type="hidden" name="boardType" id="boardType" value="${boardType}">
		<input type="hidden" name="bMemberNo" id="memberNo" value="">
	</div>
</form>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

var currentCategory = '${category}';
var categorySelect = document.querySelector('#categorySelect');
if(currentCategory != '전체'){
	categorySelect.value = '${category}';
}

//form shape
var writerInfo = document.querySelector(".writer-info");
var userInfo = document.querySelector(".user-info");
var userNameDiv = "<div class='shotLine'>"
				+"<div class='label'>작성자</div>"
				+"<div>${user.nickName}</div></div>";

// 세션 유저가 존재할 경우 작성자, 비밀번호 자동.
// memberNo 부여
if(user!=''&&user!=null){
	writerInfo.style.display = "none";
	userInfo.innerHTML=userNameDiv;
}else{
	userInfo.style.display = "none";
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
	}else if(proc == 'reg'){
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

function attachImg(){
	var url = 'imguploader';
	var windowName = '이미지 업로더';
	var option = 'width=650, height=800, top=200, left=600';
	window.open(url,windowName, option);
}
</script>