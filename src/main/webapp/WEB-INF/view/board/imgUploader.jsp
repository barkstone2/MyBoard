<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 업로더</title>
<style>
.flex{
	display:flex;
}
.imgbox{
	width:200px;
	height:200px;
	display:flex;
	justify-content: center;
	align-items: center;
	border: 1px solid black;
	margin: 5px;
	cursor: pointer;
}
.text-center{
	text-align: center;
}
.imgbox-frame{
	width:640px;
}
.imgbox-btn{
	border: 1px solid #337ab7; 
	border-radius: .25em;
	padding: .5em .75em; 
	color: #FFF;
	background-color: #337ab7;
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	margin-right:20px;
	cursor: pointer;
	box-shadow: 1px 4px 0 rgb(0,0,0,0.5);
}
.imgbox-btn:focus { 
 	outline:none;
}
.imgbox-btn:hover{
 	background-color: #A5AFFA;
}
.imgbox-btn:active{
	box-shadow: 1px 1px 0 rgb(0,0,0,0.5);
	position: relative;
 	top:2px;
}
.btn-frame{
	padding:10px;
}
.img-view{
	max-width:200px;
	max-height:200px;
	z-index: 2;
	position: absolute;
}
.imgChkBox{
	width:20px;
	height:20px;
	border: 1px solid black;
	position: relative;
	float:left;
	top:-80px;
	left:-80px;
	z-index: 3;
	cursor: pointer;
}
.boxNo{
	position:absolute;
	z-index:1
}
</style>
</head>
<body>
	
	<div class="imgbox-frame">
		<div class="text-center btn-frame">
			<button class="imgbox-btn" onclick="selectAll();">전체 선택</button>
			<button class="imgbox-btn" onclick="deleteSelected();">선택 삭제</button>
			<a href="#" onclick="imgPopUp();"><button class="imgbox-btn"> 사진 추가</button></a>
			<button class="imgbox-btn" onclick="selectImgTest();">완료</button>
		</div>
	<c:forEach begin="1" end="3" varStatus="j">
		<div class="flex">
		<c:forEach begin="${(j.count-1)*3}" end="${(j.count)*3-1}" step="1" varStatus="i">
			<div class="imgbox" id="imgbox${i.count+(j.count-1)*3}" onclick="selectImg('${i.count+(j.count-1)*3}');">
				<input type="checkbox" class="imgChkBox" id="imgChkBox${i.count+(j.count-1)*3}" 
						onclick="selectImg('${i.count+(j.count-1)*3}');" disabled="disabled">
				<p class="boxNo" id="boxNo${i.count+(j.count-1)*3}">${i.count+(j.count-1)*3}</p>
				<img src="" class="img-view" id="imgView${i.count+(j.count-1)*3}">
				<input type="hidden" id="imginput${i.count+(j.count-1)*3}" name="" value="">
				<input type="hidden" id="imgName${i.count+(j.count-1)*3}" name="" value="">
			</div>
		</c:forEach>
		</div>
	</c:forEach>
	</div>
	<input type="hidden" id="toggleChk">
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
// imgUploader.js
function deleteSelected(){
	var arrLength = $("input[name=img]").length;
	for(var i=0; i<arrLength; i++){             
		if($("input[name=img]").eq(i).val()!=''){
			var id = 'imgChkBox' + (i+1);
			var imginputId = 'imginput' + (i+1);
			var imgNameId = 'imgName' + (i+1);
			var imgViewId = 'imgView' + (i+1);
			
			$("input[name=imgName]").eq(i).val('');
			$("input[name=img]").eq(i).val('');
			$('#'+id).prop("checked", false);
			$('#'+imginputId).attr('name','');
			$('#'+imginputId).val('');
			$('#'+imgNameId).attr('name','');
			$('#'+imgViewId).attr('src','');
		}
	}
}
function imgPopUp(){
	var url = 'imgPopup';
	var windowName = '이미지 추가';
	var option = 'width=400, height=80, top=300, left=600';
	window.open(url,windowName, option);
}
function selectImg(value1){
	var id = 'imgChkBox'+value1;
	var inputId = 'imginput'+value1;
	var inputId2 = 'imgName'+value1;

	if($('#'+inputId2).val()==''){
		alert('등록된 이미지가 없습니다.');
		return;
	}
	if($('#'+id).is(":checked") == true){
		$('#'+id).prop("checked", false);
		$('#'+inputId).attr('name','');
		$('#'+inputId).val('0');
		$('#'+inputId2).attr('name','');
	}else{
		$('#'+id).prop("checked", true);
		$('#'+inputId).attr('name','img');
		$('#'+inputId).val(value1);
		$('#'+inputId2).attr('name','imgName');
	}
}

function selectImgTest(){
	var selectedImgLength = $("input[name=img]").length;
	var imgNames = "";
	for(var i=0; i<selectedImgLength; i++){       
		var imgName = $("input[name=imgName]").eq(i).val();
		if(imgName!=''){
			imgNames += "<img src='/image/"+imgName+"'>";
		}
	}
	var target = opener.document.getElementById("contentDiv");
	$(target).append(imgNames);
	window.close();
}
function selectAll(){
	var toggleChk = $('#toggleChk').val();
	var color = '#DCDCDC';
	var name = 'img';
	
	if(toggleChk=='1'){
		name = '';
		color = '#FFFFFF';
		$('#toggleChk').val('0');
	}else{
		$('#toggleChk').val('1');
	}
	for(var i=1; i<10; i++){
		var id = 'imgbox'+i;
		var inputId = 'imginput'+i;
		$('#'+id).css('background-color', color);
		$('#'+inputId).attr('name',name);
		if(toggleChk=='1'){
			$('#'+inputId).val('');
		}else{
			$('#'+inputId).val(i);
		}
	}
}
</script>
</html>