<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/inc/inc_header.jsp"%>
<style>
.replRow{
	display:flex;
	min-width:850px;
	align-items: center;
	max-width:850px;
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
	height: 30px;
	width: 120px;
	padding : 2px 7px 0px;
}
.replyCon{
	width: 600px;
	height:71px;
	padding : 2px 7px 0px;
}
.reCommentDiv{
	margin: 0px;
	justify-content: center;
	display:flex;
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
	width: 900px;
	display:flex;
	padding:5px;
	justify-content: center;
	align-items: center;
}
.comment-user-icon{
	width:10px;
	height: 10px;
}
</style>

<div style="max-width:900px; width:900px;">
	<div style="width:900px;">
		<div id="mList">
			<div style="width:850px;">
				<div id="memcount">
					* ${pager.totalConCount}개의 댓글이 존재합니다.
				</div>
			<c:forEach var="reply" items="${commentList}">
				<div class="replyListCon">
					<input type="hidden" value="${reply.groupNo}" id="reGroupNo${reply.no}">
					<input type="hidden" value="0" class="toggleChk" id="toggle${reply.no}">
					<div class="replRow" style="margin-left: ${reply.stepNo>0?30:0}px">
						<div style="width:158px;">
							 ${reply.writer}
							 <c:if test="${reply.memberNo>0}">
							 	<img class="comment-user-icon" src="/icon/member_profile_icon.png">
							 </c:if>
						</div>
						<div style="width:500px; display:flex; 
						justify-content: flex-start; cursor: pointer;" onclick="reComment('${reply.no}');">
							<c:if test="${reply.stepNo>0}">└ </c:if>${reply.content}
						</div>
						<div style="width:158px; display:flex;">
							${reply.regDate}
							<div style="width:18px; display:flex; align-items: center;">
								<button type="button" onclick="openDeleteWindow('${boardNo}','${reply.no}', '${reply.memberNo}');">X</button>
							</div>
						</div>
					</div>
					<form id="reComment${reply.no}" name="reCommentForm" class="reCommentDiv"></form>
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
					<input type="text" class="replyCon" value="" name="content" placeholder="운영 정책에 위배되는 댓글은 삭제될 수 있습니다.">
				</div>
			</div>
			<div style="margin-left:10px;">
				<input style="width:70px; height:80px;" type="button" value="댓글등록" id="btnReplyReg">
			</div>
		</form>
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
			<input type="text" class="replyCon" value="" name="content" placeholder="운영 정책에 위배되는 댓글은 삭제될 수 있습니다.">
		</div>
		<div style="margin-left:10px;">
			<input style="width:70px; height:80px;" type="button" value="댓글등록" onclick="regReComment();">
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





$(document).ready(function(){
	$("#btnReplyReg").click(function(){
		regComment();
	});
});


function reComment(value1){
	var toggleChk = 'toggle'+value1;
	var reCommentId = 'reComment'+value1;
	var reCommentForm = $("#reCommentHtml").html();
	var groupNoId = 'reGroupNo'+value1;
	var groupNo = $("#"+groupNoId).val();
	
	if($("#"+toggleChk).val()=='0'){
		$(".toggleChk").val('0');
		$("#"+toggleChk).val('1');
		$(".reCommentDiv").html('');
		$(".reCommentDiv").find("input[name=groupNo]").val('0');
		$("#"+reCommentId).html(reCommentForm);
		$("#"+reCommentId).find("input[name=groupNo]").val(groupNo);
	}else{
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
