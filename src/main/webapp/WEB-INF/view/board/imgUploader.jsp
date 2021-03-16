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
	width:620px;
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
</style>
</head>
<body>
	
	<div class="imgbox-frame">
		<div class="text-center btn-frame">
			<button class="imgbox-btn" onclick="selectAll();">전체 선택</button>
			<button class="imgbox-btn">선택 삭제</button>
			<a href="#" onclick="imgPopUp();"><button class="imgbox-btn"> 사진 추가</button></a>
			<button class="imgbox-btn" onclick="selectImgTest();">완료</button>
		</div>
	<c:forEach begin="1" end="3" varStatus="j">
		<div class="flex">
		<c:forEach begin="${(j.count-1)*3}" end="${(j.count)*3-1}" step="1" varStatus="i">
			<div class="imgbox" id="imgbox${i.count+(j.count-1)*3}" onclick="selectImg('${i.count+(j.count-1)*3}');">
				<div id="boxNo${i.count+(j.count-1)*3}">${i.count+(j.count-1)*3}</div>
				<img src="" id="imgView${i.count+(j.count-1)*3}">
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
function imgPopUp(){
	var url = 'imgPopup';
	var windowName = '이미지 추가';
	var option = 'width=400, height=80, top=300, left=600';
	window.open(url,windowName, option);
}
function selectImg(value1){
	var id = 'imgbox'+value1;
	var inputId = 'imginput'+value1;
	var inputId2 = 'imgName'+value1;
	if($('#'+inputId2).val()==''){
		alert('등록된 이미지가 없습니다.');
		return;
	}
	if($('#'+id).css('background-color')=='rgb(220, 220, 220)'){
		$('#'+id).css('background-color', '	#FFFFFF');
		$('#'+inputId).attr('name','');
		$('#'+inputId).val('0');
		$('#'+inputId2).attr('name','');
	}else{
		$('#'+id).css('background-color', '#DCDCDC');
		$('#'+inputId).attr('name','img');
		$('#'+inputId).val(value1);
		$('#'+inputId2).attr('name','imgName');
	}
}
function selectImgTest(){
	var arrLength = $("input[name=img]").length;
	var imgArr = new Array(arrLength);
	var imgNameArr = new Array(arrLength);
	for(var i=0; i<arrLength; i++){             
		if($("input[name=img]").eq(i).val()!=''){
			imgNameArr[i] = $("input[name=imgName]").eq(i).val();
		}
		imgArr[i] = $("input[name=img]").eq(i).val();
	}
	alert(imgArr);
	alert(imgNameArr);
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