<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/inc/inc_header.jsp"%>
<style>
    /** 팝업 **/
.alert_wrap{
    position:absolute;
    top:0px;
    left:0px;
    box-sizing: border-box;
    max-width: 300px;
    width:100%;
    border: 1px solid rgb(0, 0, 0);
    border-radius:12px;
    font-size: 14px;
    z-index: 2000;
    background-color:white;
    text-align: center;
}
.alert_sub{
    box-sizing: border-box;
    font-size: 20px;
    text-align:center;
    width:100%;
    padding-top:5px;
    padding-left:10px;
    padding-right:10px;
    padding-bottom:5px;
    margin:0;
    color:#fff;
    background:#000;
    border-top-left-radius:10px;
    border-top-right-radius:10px;
}
.mesaage{
    text-align: center;
    position: relative;
    padding:20px;
}
.alert_close_btn{
    --position: absolute;
    bottom: 10px;
    right: 10px;
    background-color:#3498db;
    color:white;
    border:none;
    padding-top: 5px;
    padding-right: 10px;
    padding-bottom: 5px;
    padding-left: 10px;
    border-radius:5px;
    cursor:pointer;
    margin-bottom: 20px;
}
button{
	width:80px;
	height:30px;
	border-radius:5px;
	background-color:#3498db;
    color:white;
    border:none;
    cursor:pointer;
}
body{
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
<!DOCTYPE html>
<form method="post" name="deleteForm">
	<input type="hidden" name="no" value="${no}">
	비밀번호 : <input type="password" name="pwd"><br><br>
	<div style="display:flex; justify-content:space-around;">
		<button type="button" onclick="deleteProc();">확인</button>
		<button type="button" onclick="window.close();">취소</button>
	</div>
</form>
<script>

$(function(){
	var div = document.createElement('div');  
    div.className = "alert_wrap";  
    div.id = "alert_div"
       
    var layout = "<h2 class='alert_sub'>알림</h2><div id='message' class='mesaage'></div>";  
        layout += "<div><a onclick='alertClose();' href='#'><button type='button' class='alert_close_btn'>확인</button></a></div>";  
        div.innerHTML = layout;
       
    document.body.appendChild(div);

    jQuery('#alert_div').css("display", "none");
});

function alertClose(){
	if($('#message').text()=='삭제 성공'){
		opener.parent.loadComment('${boardNo}','','init');
		window.close();
	}else{
		jQuery('#alert_div').css("display", "none");
	}
}

window.alert=function(msg){
	$('#message').text(msg);
	jQuery('#alert_div').css("display", "block");
    alert(msg);
};




function deleteProc(){
	$.ajax({
		type: "post",
		data: $('form').serialize(),
		url: "/comment/delete",
		success: function(data){
			alert(data);
		}
	});
}
</script>


 
