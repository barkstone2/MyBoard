<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/inc/inc_header.jsp"%>
<style>
.replRow{
	display:flex;
	align-items: center;
	width: inherit;
}
#btn{
	display:flex;
	justify-content: center;
}
#radioInput{
	width:180px;
	display:flex;
	justify-content: space-around;
}
#formTitle{
	text-align: center;
}
.postcode{
	margin-bottom: 5px;
}
#postcode{
	width:120px;
}
#bAddr, #sAddr{
	width:350px;
}
#listLabel{
	display:flex;
	justify-content: flex-start;
	align-items: center;
}
#mList{
	width:900px;
	display:flex;
	justify-content: center;
}
.replyListCon{
	max-width:850px;
	width:850px;
	border-bottom: 1px solid black;
}
.replyListCon, #listLabel {
	min-height:45px;
	text-align: center;
}
#memcount{
	width:850px;
	padding-bottom: 5px;
	border-bottom: 1px solid black;
}

#pager {
	--display:flex;
	justify-content: center;
	padding: 10px;
}
#pager > div{
	padding: 5px;
}
#search_data{
	width: 400px;
}
#searchForm{
	display:flex;
	justify-content: center;
}
#searchForm > div {
	padding: 10px;
}
.replyShortInput{
	min-height: 30px;
	width: 120px;
	padding : 2px 7px 0px;
}
.replyCon{
	width: 600px;
	min-height:71px;
	padding : 2px 7px 0px;
	word-break:break-all;
	resize: none;
}
.replyCon::placeholder{line-height:71px;}
.replyCon::-webkit-input-placeholder{line-height:71px;}
.replyCon::-ms-input-placeholder{line-height:71px;}
.replyCon::-mos-input-placeholder{line-height:71px;}

.reCommentDiv{
	margin: 0px;
	justify-content: center;
	display:none;
	padding: 20px 0px 20px 0px;
	border-top:1px solid;
}
.user-info{
	display: flex;
	align-items: center;
	margin-right: 10px;
}
.user-info > div{
	padding: 5px;
	border : 1px solid black;
}
.commentForm{
	width: 800;
	display:flex;
	padding:20px 0px 20px 0px;
	justify-content: center;
	align-items: center;
	border-bottom: 1px solid;
}
.comment-user-icon{
	width:10px;
	height: 10px;
}
.delComment{
	width: inherit;
	display: flex;
	align-items: center;
	min-height:45px;
}
.delContent{
	width: inherit;
	display: flex;
	align-items: center;
	padding-left: 50px;
	background-color: lightgray;
}
.comment-content{
	width:500px;
	--display:flex; 
	cursor: pointer;
    word-break:break-all;
    text-align: left;
}
.re-content{
	min-width:440px;
	max-width:440px;
}
.comment-reg-div{
	width:900px;
	display: flex;
	justify-content: center;
}
.comment-con-div{
    padding: 10px;
	width:600px;
	min-height:55px;
	--overflow:auto;
	border: 1px solid #858585;
	text-align: left;
	align-items: center;
	font: 400 13.3333px Arial;
	border-radius: 3px;
}
.comment-con-div:empty:before{
  content: attr(placeholder);
  display: block; /* For Firefox */
  height: 61px;
  line-height: 61px;
  color:#858585;
}
.re-row{
	width: 810px;
	border: 2px solid gray;
	margin: 10px;
	margin-left:30px;
}
.comment-writer{
	width:80px;
 	text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
}
</style>

<div style="max-width:900px; width:900px;">
	<div style="width:900px;">
		<div id="mList">
			<div style="width:850px;">
				<div id="memcount">
					* ${pager.totalConCount-deletedCount}개의 댓글이 존재합니다.
				</div>
			<c:forEach var="reply" items="${commentList}">
				<div class="replyListCon ">
					<c:if test="${reply.delChk==true}">
						<div class="delComment"><div class="delContent">삭제된 댓글입니다.</div></div>
					</c:if>
					<c:if test="${reply.delChk==false}">
					<input type="hidden" value="${reply.groupNo}" id="reGroupNo${reply.no}">
					<input type="hidden" value="0" class="toggleChk" id="toggle${reply.no}">
					<div class="replRow <c:if test="${reply.stepNo>0}">re-row</c:if>">
						<div style="width:158px; display:flex; justify-content: center;">
							<div class="comment-writer">
								 ${reply.writer}
							</div>
							 <c:if test="${reply.memberNo>0}">
							 	<img class="comment-user-icon" src="/icon/member_profile_icon.png">
							 </c:if>
						</div>
						<c:if test="${reply.stepNo>0}"><div style="width:30px">└&nbsp;&nbsp;</div></c:if>
						<div class="comment-content <c:if test="${reply.stepNo>0}">re-content</c:if>" onclick="reComment('${reply.no}');">
							${reply.content}
						</div>
						<div style="width:158px; display:flex;">
							${reply.regDate}
							<div style="width:18px; display:flex; align-items: center;">
								<button type="button" onclick="openDeleteWindow('${boardNo}','${reply.no}', '${reply.memberNo}');">X</button>
							</div>
						</div>
					</div>
					<form id="reComment${reply.no}" name="reCommentForm" class="reCommentDiv"></form>
					</c:if>
				</div>
			</c:forEach>
		</div>
		</div>
		<div id="pager" style="${pager.totalConCount>0?'display:flex;':'display:none;'}">
			<div><a href="#commentDiv" onclick="loadComment('${boardNo}','1');">[첫페이지]</a></div>
			<c:if test="${pager.startPage>pager.pageNavLength}">
				<div><a href="#commentDiv" onclick="loadComment('${boardNo}','${pager.startPage-pager.pageNavLength}');">[이전${pager.pageNavLength}개]</a></div>
			</c:if>
			<c:if test="${pager.startPage<=pager.pageNavLength}">
				<div>[이전${pager.pageNavLength}개]</div>
			</c:if>
			<c:forEach var="i" begin="${pager.startPage}" end="${pager.lastPage}" step="1">
				<c:if test="${i==pager.commentPage}">
					<div>[${i}]</div>
				</c:if>
				<c:if test="${i!=pager.commentPage}">
					<div><a href="#commentDiv" onclick="loadComment('${boardNo}','${i}');">${i}</a></div>
				</c:if>
			</c:forEach>
			<c:if test="${pager.lastPage<pager.totalPage}">
				<div><a href="#commentDiv" onclick="loadComment('${boardNo}','${pager.startPage+pager.pageNavLength}');">[다음${pager.pageNavLength}개]</a></div>
			</c:if>
			<c:if test="${pager.lastPage>=pager.totalPage}">
				<div>[다음${pager.pageNavLength}개]</div>
			</c:if>
			<div><a href="#commentDiv" onclick="loadComment('${boardNo}','${pager.totalPage}');">[끝페이지]</a></div>
			<div style="display:none;" id="pagerInfo">
			</div>
		</div>
		<div class="comment-reg-div">
			<form id="commentForm" class="commentForm" name="replyForm" method="post">
				<input type="hidden" name="cp" value="${pager.totalPage}">
				<input type="hidden" name="boardNo" value="${boardNo}">
				<input type="hidden" name="groupNo" value="0">
				<input type="hidden" name="stepNo" value="0">
				<input type="hidden" name="memberNo" value="0">
				<div style="display:flex;">
					<div class="user-info"></div>
					<div class="writer-info" style="margin-right: 10px;">
						<div style="margin-bottom: 5px;">
							<input type="text" class="replyShortInput" name="writer" placeholder="닉네임">
						</div>
						<div>
							<input type="password" class="replyShortInput" name="pwd" placeholder="비밀번호">
						</div>
					</div>
					<div>
						<div contentEditable="true" class="comment-con-div" placeholder="운영 정책에 위배되는 댓글은 예고 없이 삭제될 수 있습니다."></div>
						<textarea class="replyCon" name="content" hidden="hidden"></textarea>
					</div>
				</div>
				<div style="margin-left:10px;">
					<input style="width:70px; height:80px;" type="button" value="댓글등록" id="btnReplyReg">
				</div>
			</form>
		</div>
	</div>
</div>

<div id="reCommentHtml" style="display:none;">
	<input type="hidden" name="cp" value="${pager.totalPage}">
	<input type="hidden" name="boardNo" value="${boardNo}">
	<input type="hidden" name="groupNo" value="0">
	<input type="hidden" name="stepNo" value="1">
	<input type="hidden" name="memberNo" value="0">
	<div style="display:flex;">
		<div class="user-info"></div>
		<div class="writer-info" style="margin-right: 10px;">
			<div style="margin-bottom: 5px;">
				<input type="text" class="replyShortInput" name="writer" placeholder="닉네임">
			</div>
			<div>
				<input type="password" class="replyShortInput" name="pwd" placeholder="비밀번호">
			</div>
		</div>
		<div>
			<div contentEditable="true" class="comment-con-div" placeholder="운영 정책에 위배되는 댓글은 예고 없이 삭제될 수 있습니다."></div>
			<textarea class="replyCon" name="content" hidden="hidden"></textarea>
		</div>
		<div style="margin-left:10px;">
			<input style="width:70px; height:80px;" type="button" value="댓글등록" onclick="regReCommentForm();">
		</div>
	</div>
</div>
<script>
document.addEventListener("DOMContentLoaded", sessionChk());

function sessionChk(){
	//form shape
	const writerInfo = document.querySelector(".writer-info");
	const userInfo = document.querySelector(".user-info");
	const userNameDiv ="<div>${user.nickName}</div>";

	//input data
	// 그냥 컨트롤러에서 세션으로 처리.
	//세션에서 닉네임, 멤버No 뽑아서 넣기
		
	if(user!=''&&user!=null){
		writerInfo.style.display = "none";
		userInfo.innerHTML=userNameDiv;
	}else{
		userInfo.style.display = "none";
	}
}



function regReCommentForm(){
	
	//EditableDiv의 값을 textarea에 넣어줌.
	var formContent = document.querySelector(".reCommentDiv textarea[name=content]");
	var editDiv = document.querySelector(".reCommentDiv div[class=comment-con-div]");
	
	formContent.value = editDiv.innerHTML;
	
	regReComment();
}


$(document).ready(function(){
	$("#btnReplyReg").click(function(){
		var formContent = document.querySelector("#commentForm textarea[name=content]");
		var editDiv = document.querySelector("#commentForm div[class=comment-con-div]");
		
		formContent.value = editDiv.innerHTML;
		
		regComment();
	});
});


function reComment(value1){
	var toggleChk = 'toggle'+value1;
	var reCommentId = 'reComment'+value1;
	
	var reCommentForm = $("#reCommentHtml").html();
	var groupNoId = 'reGroupNo'+value1;
	var groupNo = $("#"+groupNoId).val();
	
	var reCommentDiv = document.querySelector("#"+reCommentId);
	
	if($("#"+toggleChk).val()=='0'){
		
		//바닐라로 클래스 가져올 때는 반복문 돌려야함
		//일단 jQuery로 두고 나중에 바꾸기
		
		$(".toggleChk").val('0');
		$("#"+toggleChk).val('1');
		$(".reCommentDiv").html('');
		$(".reCommentDiv").find("input[name=groupNo]").val('0');
		$(".reCommentDiv").css("display","none");
		
		reCommentDiv.style.display = "block";
		$("#"+reCommentId).html(reCommentForm);
		$("#"+reCommentId).find("input[name=groupNo]").val(groupNo);
	}else{
		document.querySelector("#"+reCommentId).style.display = "none";
		$("#"+toggleChk).val('0');
		$("#"+reCommentId).html('');
		$("#"+reCommentId).find("input[name=groupNo]").val('0');
	}
	sessionChk();
}

function openDeleteWindow(boardNo, commentNo, memberNo){
	if(memberNo>0){
		if(`${user.no}`==memberNo){
			if(confirm('삭제하시겠습니까?')){
				var xhr = new XMLHttpRequest(); 
		        xhr.onreadystatechange = function() {
		          if (xhr.readyState === 4) {
		            if (xhr.status === 200) {
		              	alert(xhr.responseText);
		            	loadComment('${boardNo}','','init');
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

</script>
