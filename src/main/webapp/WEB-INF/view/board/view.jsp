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
.link-component{
	cursor: pointer;
	color: #0208d6;
}
.c-flex{
	display:flex;
	justify-content: center;
}
.like-btn{
	width:100px;
	height:40px;
	margin:10px;
	background-color: #9b9bd8;
	border: 1px solid;
	cursor: pointer;
	box-shadow: 1px 4px 0 rgb(0,0,0,0.5);
	border-radius: .25em;
}
.like-btn:focus { 
 	outline:none;
}
.like-btn:active{
	box-shadow: 1px 1px 0 rgb(0,0,0,0.5);
	position: relative;
 	top:2px;
}
</style>
<div>
	<div style="width:900px; border: 1px solid black;">
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
					<span <c:if test="${dto.memberNo>0}">class="link-component" 
			            	onclick="openUserInfo(`${dto.memberNo}`);"</c:if>>
	            		${dto.writer}
	            	</span>
	            	<c:if test="${dto.memberNo>0}">
					 	<img class="comment-user-icon" src="/icon/member_profile_icon.png">
				 	</c:if>
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
					<c:if test="${fileDto.fileName!=null}">
						<img src="/file/${fileDto.fileName}" id="uploadedImg" style="display:none;">
					</c:if>
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
		<div class="row c-flex">
			<button type="button" class="like-btn" onclick="updateLike('like')">
				<div id="likeCount">${dto.like}</div>
				추천
			</button>
			<button type="button" class="like-btn" onclick="updateLike('dislike')">
				<div id="dislikeCount">${dto.disLike}</div>
				비추천
			</button>
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
	</div>
</div>

<script>
//세션 체크 스크립트
//ajax 댓글 로드 후 실행
function sessionChk(){
	//form shape
	var writerInfo = document.querySelector("#commentWriterInfo");
	var userInfo = document.querySelector("#commentUserInfo");
	var reWriterInfo = document.querySelector("#reCommentWriterInfo");
	var reUserInfo = document.querySelector("#reCommentUserInfo");
	var userNameDiv ="<div>${user.nickName}</div>";
	
	// 컨트롤러에서 세션으로 처리.
	// 세션에서 닉네임, 멤버No 뽑아서 넣기
	
	if(user != null && user != ''){
		writerInfo.style.display = "none";
		userInfo.innerHTML = userNameDiv;	
		reWriterInfo.style.display = "none";
		reUserInfo.innerHTML = userNameDiv;	
	}else{
		userInfo.style.display = "none";
		reUserInfo.style.display = "none";
	}
}

//댓글 목록 출력 스크립트
function loadComment(no, c_pageNumber, initChk){
	var queryString = "?boardNo="+ no + "&cp="+c_pageNumber+"&initChk="+initChk;
	var target = document.querySelector("#commentDiv");
	var xhr = new XMLHttpRequest(); 
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
        		target.innerHTML = xhr.responseText;
        		sessionChk();
           }
        }
    };
    xhr.open("GET", "/comment/list"+queryString);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(null);
	
}
document.addEventListener("DOMContentLoaded", loadComment('${dto.no}','', 'init'));

//댓글 등록 스크립트
function regComment(){
	var formContent = document.querySelector("#commentForm textarea[name=content]");
	var editDiv = document.querySelector("#commentForm div[class=comment-con-div]");
	formContent.value = editDiv.innerHTML;
	var form = document.querySelector("#commentForm").elements;
	var data = "";
	for(var i=0; i<form.length; i++){
		if(form[i].hasAttribute("name")){
			data += form[i].getAttribute("name") + "=" + form[i].value + "&";
		}
	} 
	data = data.substring(0, data.length-1);
	var target = document.querySelector("#commentDiv");
	var xhr = new XMLHttpRequest(); 
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
        	target.innerHTML = xhr.responseText;
        	sessionChk();
           }
        }
    };
    xhr.open("POST", "/comment/reg");
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(data);
}

// 대댓글 입력 창 스크립트
function reComment(value1){
	
	var toggleChk = document.querySelector("#toggle"+value1); // 선택 위치에 대한 toggle check 값
	var reCommentForm = document.querySelector("#reCommentHtml").innerHTML; // 대댓글 layout
	var groupNo = document.querySelector("#reGroupNo"+value1).value; // 대댓글 작성시 사용되는 groupNo 값
	var reCommentDiv = document.querySelector("#reComment"+value1); // 사용자가 선택한 대댓글 위치 
	var toggleClass = document.querySelectorAll(".toggleChk"); // 선택 위치를 제외한 나머지 위치
	
	if(toggleChk.value == '0'){
		
		// 다른 대댓글 창을 모두 닫는다.
		toggleClass.forEach(element => element.value = '0');

		var comDivs = document.querySelectorAll(".reCommentDiv");
		comDivs.forEach(element => {
			element.innerHTML = '';
			element.style.display = "none";
			}
		);
		
		var groupNos = document.querySelectorAll(".reCommentDiv input[name=groupNo]");
		groupNos.forEach(element => element.value = '0');
		
		// 선택 위치에 대댓글 창 출력
		toggleChk.value = '1';
		reCommentDiv.style.display = "flex";
		reCommentDiv.innerHTML = reCommentForm;
		reCommentDiv.querySelector("input[name=groupNo]").value = groupNo;
		
	}else{
		document.querySelector("#reComment"+value1).style.display = "none";
		toggleChk.value = '0';
		reCommentDiv.innerHTML = '';
	}
	sessionChk();
}

//대댓글 등록
function regReComment(){
	
	//EditableDiv의 값을 textarea에 넣어줌.
	var formContent = document.querySelector(".reCommentDiv textarea[name=content]");
	var editDiv = document.querySelector(".reCommentDiv div[class=comment-con-div]");
	
	formContent.value = editDiv.innerHTML;
	
	var form = document.querySelector(".reCommentDiv form[name=reCommentForm]").elements;
	var data = "";
	for(var i=0; i<form.length; i++){
		if(form[i].hasAttribute("name")){
			data += form[i].getAttribute("name") + "=" + form[i].value + "&";
		}
	} 
	data = data.substring(0, data.length-1);
	
	var xhr = new XMLHttpRequest(); 
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
        	document.querySelector("#commentDiv").innerHTML = xhr.responseText;
        	sessionChk();
        }
      }
    };

    xhr.open("POST", "/comment/reg");
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(data);
}

// 댓글 삭제 스크립트
function openDeleteWindow(boardNo, commentNo, memberNo){
	if(memberNo>0){
		if(`${user.no}`==memberNo){
			if(confirm('삭제하시겠습니까?')){
				var xhr = new XMLHttpRequest(); 
		        xhr.onreadystatechange = function() {
		          if (xhr.readyState === 4) {
		            if (xhr.status === 200) {
		              	alert(xhr.responseText);
		            	loadComment(boardNo,'','init');
		            }
		          }
		        };

		        xhr.open("POST", "/comment/delete");
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		        xhr.send("memberNo=${user.no}&no="+commentNo);
			}
		}else{
			alert('권한이 없습니다.');
		}
	}else{
		var queryString = "?boardNo="+boardNo+"&no="+commentNo;
		var url = '/comment/delete'+queryString;
		var title = 'delete comment';
		var option = 'width=300, height=150, top=300, left=600, location=no, resizable=no';
		window.open(url, title, option);
	}
}


//유저 정보 보기 스크립트
function openUserInfo(memberNo){
	
	var queryString = "?memberNo="+memberNo;
	var url = '/member/info'+queryString;
	var option = 'width=500, height=300, top=200%, left=500%, location=no, resizable=no';
	window.open(url, '', option);
	
}

// 추천 비추천 스크립트
function updateLike(proc){
	var xhr = new XMLHttpRequest(); 
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
        	if(xhr.responseText.indexOf("|")>0){
        		var count = xhr.responseText.substring(0, xhr.responseText.length-1);
        		document.querySelector("#"+proc+"Count").innerHTML = count;
        	}else if(xhr.responseText.indexOf("<!DOCTYPE html>")>0){
    			  alert('추천/비추천은 로그인한 유저만 가능합니다.');
        	}else{
        		alert(xhr.responseText);
        	}
        }
      }
    };

    xhr.open("POST", proc);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send("boardNo="+${dto.no});
	
}

// 이미지 미리보기 스크립트
function imgPreView(proc){
	var upimg = document.querySelector("#uploadedImg");
	var upimgName = document.querySelector("#uploadedImgName");
	if(proc=='show') {
		upimg.style.display = "block";
		upimgName.style.display = "none";
	}
	if(proc=='hide') {
		upimg.style.display = "none";
		upimgName.style.display = "block";
	}
}

// 페이지 이동 스크립트
function move(proc, v_page, v_no, v_ctg, v_ctgp, v_order){
	var sop;
	var sd;
	if(proc=='search'){
		proc = 'list';
		v_page = '1';
		sop = $('#search_option').val();
		sd = $('#search_data').val();
	}
	else if(proc == 'searchClear'){
		proc = 'list';
		v_page = '1';
		sop = '';
		sd = '';
	}
	else if(proc == 'reg'){
		$('#content').val($("#contentDiv").html());
		$('form').submit();
		return;
	}
	else if(proc == 'delete'){
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