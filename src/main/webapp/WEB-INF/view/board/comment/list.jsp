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
	width: 140px;
	padding : 2px 7px 0px;
}
#replyForm{
	width:850px;
	
}
.replyCon{
	width: 667px;
	height:71px;
	padding : 2px 7px 0px;
}
</style>

<div style="max-width:900px; width:900px;">
	<div style="width:900px;">
		<div id="mList">
			<div style="width:850px;">
				<div id="memcount">
					* ${totalConCount}개의 댓글이 존재합니다.
				</div>
			<c:forEach var="reply" items="${commentList}">
				<div class="replyListCon">
					<input type="hidden" value="${reply.groupNo}" id="reGroupNo${reply.no}">
					<input type="hidden" value="0" class="toggleChk" id="toggle${reply.no}">
					<div class="replRow" style="margin-left: ${reply.stepNo>0?30:0}px">
						<div style="width:158px;">
							 ${reply.writer}
						</div>
						<div style="width:500px; display:flex; 
						justify-content: flex-start; cursor: pointer;" onclick="reComment('${reply.no}');">
							<c:if test="${reply.stepNo>0}">└ </c:if>${reply.content}
						</div>
						<div style="width:158px; display:flex;">
							${reply.regDate}
							<div style="width:18px; display:flex; align-items: center;">
								<button type="button" onclick="openDeleteWindow('${boardNo}','${reply.no}');">X</button>
							</div>
						</div>
					</div>
					<div id="reComment${reply.no}" class="reCommentDiv"></div>
				</div>
			</c:forEach>
		</div>
		</div>
		<div id="pager" style="${totalConCount>0?'display:flex;':'display:none;'}">
			<div><a href="#commentDiv" onclick="loadComment('${boardNo}','1');">[첫페이지]</a></div>
			<c:if test="${startPage>pageNavLength}">
				<div><a href="#commentDiv" onclick="loadComment('${boardNo}','${startPage-pageNavLength}');">[이전${pageNavLength}개]</a></div>
			</c:if>
			<c:if test="${startPage<=pageNavLength}">
				<div>[이전${pageNavLength}개]</div>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${lastPage}" step="1">
				<c:if test="${i==commentPage}">
					<div>[${i}]</div>
				</c:if>
				<c:if test="${i!=commentPage}">
					<div><a href="#commentDiv" onclick="loadComment('${boardNo}','${i}');">${i}</a></div>
				</c:if>
			</c:forEach>
			<c:if test="${lastPage<totalPage}">
				<div><a href="#commentDiv" onclick="loadComment('${boardNo}','${startPage+pageNavLength}');">[다음${pageNavLength}개]</a></div>
			</c:if>
			<c:if test="${lastPage>=totalPage}">
				<div>[다음${pageNavLength}개]</div>
			</c:if>
			<div><a href="#commentDiv" onclick="loadComment('${boardNo}','${totalPage}');">[끝페이지]</a></div>
			<div style="display:none;" id="pagerInfo">
			</div>
		</div>
		<div style="width: 900px; display:flex; padding:5px; justify-content: center;">
			<form id="replyForm" name="replyForm" method="post" action="">
				<input type="hidden" name="cp" value="${totalPage}">
				<input type="hidden" name="boardNo" value="${boardNo}">
				<input type="hidden" name="groupNo" value="0">
				<input type="hidden" name="stepNo" value="0">
				<div style="display:flex;">
					<div style="margin-right: 10px;">
						<div style="margin-bottom: 5px;">
							<input type="text" class="replyShortInput" name="writer" placeholder="닉네임">
						</div>
						<div>
							<input type="text" class="replyShortInput" name="pwd" placeholder="비밀번호">
						</div>
					</div>
					<div>
						<input type="text" class="replyCon" value="" name="content" placeholder="운영 정책에 위배되는 댓글은 삭제될 수 있습니다.">
					</div>
				</div>
				<div style="display:flex; justify-content: flex-end; margin-top: 5px;">
					<input style="width:70px; height:35px;" type="button" value="댓글등록" id="btnReplyReg">
				</div>
			</form>
		</div>
	</div>
</div>

<div id="reCommentHtml" style="display:none;">
	<div style="width: 850px; margin-bottom:5px;">
	<form id="replyForm" name="reCommentForm" method="post" action="">
		<input type="hidden" name="cp" value="${totalPage}">
		<input type="hidden" name="boardNo" value="${boardNo}">
		<input type="hidden" name="groupNo" value="0">
		<input type="hidden" name="stepNo" value="1">
		<div style="display:flex;">
			<div style="margin-right: 10px;">
				<div style="margin-bottom: 5px;">
					<input type="text" class="replyShortInput" name="writer" placeholder="닉네임">
				</div>
				<div>
					<input type="text" class="replyShortInput" name="pwd" placeholder="비밀번호">
				</div>
			</div>
			<div>
				<input type="text" class="replyCon" value="" name="content" placeholder="운영 정책에 위배되는 댓글은 삭제될 수 있습니다.">
			</div>
		</div>
		<div style="display:flex; justify-content: flex-end; margin-top: 5px;">
			<input style="width:70px; height:35px;" type="button" value="댓글등록" onclick="regReComment();">
		</div>
	</form>
	</div>
</div>
<script>
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
}

function openDeleteWindow(boardNo, commentNo){
	var queryString = "?boardNo="+boardNo+"&no="+commentNo;
	var url = '/comment/delete'+queryString;
	var title = 'delete comment';
	var option = 'width=300, height=150, top=300, left=600, location=no, resizable=no';
	window.open(url, title, option);
}

</script>
