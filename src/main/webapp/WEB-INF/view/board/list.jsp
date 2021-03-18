<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>list</title>

<style>
    .list_label{
        border-bottom: 1px solid skyblue;
        display: flex;
        text-align: center;
        height: 30px;
        line-height: 30px;
        min-width: 570px;
    }
    .list_content_block{
        min-height: 500px;
        min-width: 570px;
    }
    .list_content {
        display: flex;
        border-bottom: 1px solid gray;
        height: 20px;
        line-height: 20px;
        min-width: 570px;
    }
     .btn_block {
        display: flex;
        min-width: 570px;
    }

.board_num{
    min-width:50px;
    text-align: center;
}
.board_subj{
    min-width:200px;
    --padding-left: 10px;
}
.board_writer{
    min-width:100px;
    text-align: center;
}
.board_date{
    min-width:100px;
    text-align: center;
}
.board_hit{
    min-width:70px;
    text-align: center;
}
.board_recommend{
    min-width:50px;
    text-align: center;
}
.list{
	max-width:570px;
}
.align-right{
	justify-content: flex-end;
}
a{
	text-decoration: none;
}
#pager {
	--display:flex;
	justify-content: center;
	padding: 10px;
}
#pager > div{
	padding: 5px;
}
.flex{
	display: flex;
}
.f-center{
	justify-content: center;
}
#searchForm > div{
	padding: 5px;
}
</style>
</head>
<body>

	<main class="list">
	    <div class="list_label">
	        <div class="board_num">번호</div>
	        <div class="board_subj">제목</div>
	        <div class="board_writer">작성자</div>
	        <div class="board_date">작성일</div>
	        <div class="board_hit">조회수</div>
	        <div class="board_recommend">추천</div>
	    </div>
	    <div class="list_content_block">
	        <div class="list_content">
	            <div class="board_num">1</div>
	            <div class="board_subj">제목입니다</div>
	            <div class="board_writer">김작성자</div>
	            <div class="board_date">2012-12-12</div>
	            <div class="board_hit">359</div>
	            <div class="board_recommend">8</div>
	        </div>
	        <div class="list_content">
	            <div class="board_num">2</div>
	            <div class="board_subj">오늘은 날씨가 좋네요</div>
	            <div class="board_writer">박덕자</div>
	            <div class="board_date">2012-12-12</div>
	            <div class="board_hit">33</div>
	            <div class="board_recommend">1</div>
	        </div>
	        <div class="list_content">
	            <div class="board_num">3</div>
	            <div class="board_subj">안녕하세요 처음 왔습니다</div>
	            <div class="board_writer">새로온 사람</div>
	            <div class="board_date">2012-12-12</div>
	            <div class="board_hit">1</div>
	            <div class="board_recommend">0</div>
	        </div>
	        <c:forEach items="${list}" var="dto">
	        	<div class="list_content">
		            <div class="board_num">${dto.no}</div>
		            <div class="board_subj">
		            	<a href="view?no=${dto.no}">${dto.title} [${dto.commentCount}]</a>
		            </div>
		            <div class="board_writer">${dto.writer}</div>
		            <div class="board_date"><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd"/></div>
		            <div class="board_hit">${dto.hit}</div>
		            <div class="board_recommend">${dto.like}</div>
		        </div>
	        </c:forEach>
		    <div id="pager" style="${totalConCount>0?'display:flex;':'display:none;'}">
				<div><a href="#" onclick="move('list','1');">[첫페이지]</a></div>
				<c:if test="${startPage>pageNavLength}">
					<div><a href="#" onclick="move('list','${startPage-pageNavLength}');">[이전 ${pageNavLength}개]</a></div>
				</c:if>
				<c:if test="${startPage<=pageNavLength}">
					<div>[이전 ${pageNavLength}개]</div>
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${lastPage}" step="1">
					<c:if test="${i==page}">
						<div>[${i}]</div>
					</c:if>
					<c:if test="${i!=page}">
						<div><a href="#" onclick="move('list','${i}');">${i}</a></div>
					</c:if>
				</c:forEach>
				<c:if test="${lastPage<totalPage}">
					<div><a href="#" onclick="move('list','${startPage+pageNavLength}');">[다음 ${pageNavLength}개]</a></div>
				</c:if>
				<c:if test="${lastPage>=totalPage}">
					<div>[다음 ${pageNavLength}개]</div>
				</c:if>
				<div><a href="#" onclick="move('list','${totalPage}');">[끝페이지]</a></div>
			</div>
	    </div>
	    <div class="flex f-center">
		    <form class="flex f-center" name="searchForm" id="searchForm" method="post">
				<div>
					<select name="search_option" id="search_option">
						<option value="">-선택-</option>
						<option value="title" id="op_title">제목</option>
						<option value="content" id="op_content">내용</option>
						<option value="title_content" id="op_title_content">제목+내용</option>
						<option value="writer" id="op_writer">작성자</option>
						<option value="all" id="op_all">전체</option>
					</select>
				</div>
				<div>
					<input type="text" name="search_data" id="search_data" value="${searchData}">
				</div>
				<div>
					<input type="button" value="검색" id="btnSearch" onclick="move('search')">
				</div>
			</form>
	    </div>
	    <div class="btn_block align-right">
	        <button type="button" onclick="move('reg')">글쓰기</button>
	    </div>
	</main>
</body>
<script>
function move(proc, v_page, v_no){
	if(proc=='search'){
		proc = 'list';
		v_page = '1';
	}
	var queryString = "?p="+v_page+"&no="+v_no
					+"&s_op=" + $('#search_option').val()
					+"&s_d=" + $('#search_data').val();
	location.href = proc + queryString;
}
$('#op_${searchOption}').prop('selected', true);

</script>
</html>