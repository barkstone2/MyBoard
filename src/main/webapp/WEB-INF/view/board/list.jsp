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
		            	<a href="view?no=${dto.no}">${dto.title}</a>
		            </div>
		            <div class="board_writer">${dto.writer}</div>
		            <div class="board_date"><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd"/></div>
		            <div class="board_hit">${dto.hit}</div>
		            <div class="board_recommend">${dto.like}</div>
		        </div>
	        </c:forEach>
	    </div>
	    <div class="btn_block align-right">
	        <button type="button" onclick="move('reg')">글쓰기</button>
	    </div>
	</main>
</body>
<script>
function move(v_location){
	location.href=v_location;
}
</script>
</html>