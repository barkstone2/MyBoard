<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 추가</title>
<style>
*:focus { 
 	outline:none;
}
#imgName{
	padding: .5em .75em; 
	font-size: inherit; 
	font-family: inherit; 
	vertical-align: middle; 
	background-color: #F3ECEC; 
	border: 1px solid #ebebeb; 
	border-radius: .25em; 
}
.imgbtn{
	padding: .5em .75em; 
	color: #FFF; 
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #337ab7;
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-radius: .25em;
}
</style>
</head>
<body>
	<input type="text" readonly="readonly" id="imgName">
	<button class="imgbtn" onclick="selectFile();">파일선택</button>
	<div style="display:none;">
		<form name="attachImgForm" id="attachImgForm" enctype="multipart/form-data">
			<input type="file" name="attachedImg" id="attachedImg" accept="image/*"><br>
		</form>
	</div>
	<a href="#" onclick="saveFile();"><button class="imgbtn">완료</button></a>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
function selectFile(){
	$('#attachedImg').click();
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
function saveFile(){
	var form = $('#attachImgForm')[0];
    var param = new FormData(form);
	$.ajax({
		type: "POST",
        enctype: 'multipart/form-data',
        url: "imgpopup",
        data: param,
        processData: false,
        contentType: false,
		success: function(data){
			for(var i=1; i<10; i++){
				var imgName = opener.document.getElementById("imgName"+i);
				var imgView = opener.document.getElementById("imgView"+i);
				if(imgName.value==''){
					$(imgName).val(data);
					$(imgView).attr("src","/image/"+data);
					break;
				}else{
					continue;
				}
			} 
			window.close();
		}
	});
}
</script>
</html>