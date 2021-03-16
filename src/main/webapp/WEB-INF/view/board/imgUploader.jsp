<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
			<button class="imgbox-btn" onclick="imgPopUp();">사진 추가</button>
			<button class="imgbox-btn" onclick="selectImgTest();">완료</button>
		</div>
		<div class="flex">
			<div class="imgbox" id="imgbox1" onclick="selectImg('1');">
				1<input type="hidden" id="imginput1" name="" value="">
			</div>
			<div class="imgbox" id="imgbox2" onclick="selectImg('2');">
				2<input type="hidden" id="imginput2" name="" value="">
			</div>
			<div class="imgbox" id="imgbox3" onclick="selectImg('3');">
				3<input type="hidden" id="imginput3" name="" value="">
			</div>
		</div>
		
		<div class="flex">
			<div class="imgbox" id="imgbox4" onclick="selectImg('4');">
				4<input type="hidden" id="imginput4" name="" value="">
			</div>
			<div class="imgbox" id="imgbox5" onclick="selectImg('5');">
				5<input type="hidden" id="imginput5" name="" value="">
			</div>
			<div class="imgbox" id="imgbox6" onclick="selectImg('6');">
				6<input type="hidden" id="imginput6" name="" value="">
			</div>
		</div>
		
		<div class="flex">
			<div class="imgbox" id="imgbox7" onclick="selectImg('7');">
				7<input type="hidden" id="imginput7" name="" value="">
			</div>
			<div class="imgbox" id="imgbox8" onclick="selectImg('8');">
				8<input type="hidden" id="imginput8" name="" value="">
			</div>
			<div class="imgbox" id="imgbox9" onclick="selectImg('9');">
				9<input type="hidden" id="imginput9" name="" value="">
			</div>
		</div>
	</div>
	<input type="hidden" id="toggleChk">
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
function imgPopUp(){
	var url = './img_popup.html';
	var windowName = '이미지 추가';
	var option = 'width=400, height=80, top=300, left=600';
	window.open(url,windowName, option);
}
function selectImg(value1){
	var id = 'imgbox'+value1;
	var inputId = 'imginput'+value1;
	if($('#'+id).css('background-color')=='rgb(220, 220, 220)'){
		$('#'+id).css('background-color', '	#FFFFFF');
		$('#'+inputId).attr('name','');
		$('#'+inputId).val('');
	}else{
		$('#'+id).css('background-color', '#DCDCDC');
		$('#'+inputId).attr('name','img');
		$('#'+inputId).val(value1);
	}
}
function selectImgTest(){
	var arrLength = $("input[name=img]").length;
	var imgArr = new Array(arrLength);
	for(var i=0; i<arrLength; i++){                          
		imgArr[i] = $("input[name=img]").eq(i).val();
	}
	alert(imgArr);
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