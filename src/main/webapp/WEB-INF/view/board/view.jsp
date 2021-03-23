<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/inc/inc_header.jsp"%>
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
	<form style="width:900px; border: 1px solid black;" name="chugaForm">
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
		<div class="row">
			<div class="label">
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
		<div class="row" style="display:flex; justify-content: center;">	
			<div>
				<div id="contentDiv" style="padding:10px; width:850px; min-height:500px; resize: none; border:1px solid black;">
					${dto.content}
				</div>
			</div>
		</div>
		<div id="commentDiv"></div>
		<div class="row">	
			<div class="btn">
				<div style="width:400px; display:flex; justify-content: space-around;">
					<div>
						<input type="button" value="글쓰기" onclick="move('reg','${page}','');">
					</div>
					<div>
						<input type="button" value="수정하기" onclick="move('modify','${page}','${dto.no}');">
					</div>
					<div>
						<input type="button" value="삭제하기" onclick="move('delete','${page}','${dto.no}');">
					</div>
					<div>
						<input type="button" value="목록으로" onclick="move('list','${page}','');">
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
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
function move(proc, v_page, v_no){
	var queryString = "?p="+v_page+"&no="+v_no
	+"&s_op=" + '${searchOption}'
	+"&s_d=" + '${searchData}';
	if(proc == 'delete'){
		if(${dto.memberNo>0}){
			if(`${user.no}`==`${dto.memberNo}`){
				if(confirm('삭제하시겠습니까?')){
					var form = document.createElement("form");
					form.setAttribute("charset", "UTF-8");
					form.setAttribute("method", post);
					form.setAttribute("action", "delete");
					
				 	var hiddenField = document.createElement("input");
	         		hiddenField.setAttribute("type", "hidden");
		         	hiddenField.setAttribute("name", "no");
		         	hiddenField.setAttribute("value", v_no);
		         	
		         	form.appendChild(hiddenField);
		         	document.body.appendChild(form);
		         	form.submit();
		         	return;
				}
			}else{
				alert('권한이 없습니다.');
				return;
			}
		}
	}
	location.href = proc + queryString;
}

$(document).ready(function(){
	loadComment('${dto.no}','', 'init');
});

function loadComment(no, c_pageNumber, initChk){
	var param = {
			"boardNo" : no,
			"cp" : c_pageNumber,
			"initChk" : initChk
	};
	$.ajax({
			type: "get",
			data: param,
			dataType: "html", 
			async:true,
			url: "/comment/list",
			success: function(data){
				$("#commentDiv").html(data);
				/* if(initChk!='init'){
					var offset = $("#commentDiv").offset();
				    $('html, body').animate({scrollTop : offset.top}, 0);
				} */
			}
		});
}

function regComment(){
	$.ajax({
			type: "post",
			data: $('#commentForm').serialize(),
			url: "/comment/reg",
			success: function(data){
				$("#commentDiv").html(data);
			}
		});
}

function regReComment(){
	$.ajax({
			type: "post",
			data: $('form[name=reCommentForm]').serialize(),
			url: "/comment/reg",
			success: function(data){
				$("#commentDiv").html(data);
			}
		});
}
</script>