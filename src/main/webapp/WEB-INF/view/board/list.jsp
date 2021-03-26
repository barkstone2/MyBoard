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
    min-width:60px;
    text-align: center;
}
.board_subj{
    min-width:250px;
    --padding-left: 10px;
    --display: flex;
}
.board_title{
	text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
}
.board_writer{
	display:flex;
    min-width:150px;
    justify-content: center;
    text-align: center;
}
.board_writer_text{
	--width:120px;
 	text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
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
    min-width:80px;
    text-align: center;
}
.list{
	width:700px;
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
	align-items: center;
}
#searchForm > div{
	padding: 5px;
}
.comment-user-icon{
	width: 10px;
	height: 10px;
}
.having-user-icon{
	margin-left: 10px;
}
.link-component{
	cursor: pointer;
	color: #0208d6;
}
.category-content{
	width:50px;
	height:20px;
	display:flex;
	align-items: center;
	justify-content: center;
	padding: 10px;
	margin:10px;
	border-radius: 7px;
	background-color: #8FD6CE;
	cursor: pointer;
}
.category-content:hover{
	background-color: #ff9393;
}
.category-list-div{
	display:flex;
	align-items: center;
	justify-content: center;
}
.category-list{
	display:flex;
	justify-content: space-around;
	align-items: center;
}
.icon{
	display: none;
	border-radius: 15px;
	cursor: pointer;
}
.icon:hover{
	background-color:  #ff9393;
}
.category-content-color{
	background-color: #8FD6CE;
}
.empty-list{
	width: inherit;
	height: 300px;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
</head>
<body>
	<main class="list">
		<!-- 7개가 최대 -->
		<div class="category-list-div">
			<img class="icon" src="/icon/icon_left.png">
			<div class="category-list">
				<c:forEach var="category" items="${categoryList}">
				<div class="category-content ${category}" onclick="move('list', '1', '', '${category}')">
					${category}
				</div>
				</c:forEach>
			</div>
			<img class="icon" src="/icon/icon_right.png">
		</div>
	    <div class="list_label">
	        <div class="board_num">번호</div>
	        <div class="board_subj">제목</div>
	        <div class="board_writer">작성자</div>
	        <div class="board_date">작성일</div>
	        <div class="board_hit">조회수</div>
	        <div class="board_recommend">추천</div>
	    </div>
	    <div class="list_content_block">
	    	<c:if test="${pager.totalConCount==0}">
	    		<div class="empty-list">
	    			게시글이 없습니다.
	    		</div>
	    	</c:if>
	        <c:forEach items="${list}" var="dto">
	        	<div class="list_content">
		            <div class="board_num">${dto.no}</div>
		            <div class="board_subj">
		            	<div class="flex">
			            	<div class="board_title">
				            	<a href="#" onclick="move('view','${pager.page}','${dto.no}')">${dto.title}</a>
			            	</div>
			            	<div>[${dto.commentCount}]</div>
		            	</div>
		            </div>
		            <div class="board_writer">
		            	<div class="board_writer_text <c:if test="${dto.memberNo>0}">having-user-icon</c:if>">
			            	<span <c:if test="${dto.memberNo>0}">class="link-component" 
			            	onclick="openUserInfo(`${dto.memberNo}`);"</c:if>>
			            	${dto.writer}
			            	</span>
		            	</div>
		            <c:if test="${dto.memberNo>0}">
					 	<img class="comment-user-icon" src="/icon/member_profile_icon.png">
				 	</c:if>
				 	</div>
		            <div class="board_date"><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd"/></div>
		            <div class="board_hit">${dto.hit}</div>
		            <div class="board_recommend">${dto.like}</div>
		        </div>
	        </c:forEach>
		    <div id="pager" style="${pager.totalConCount>0?'display:flex;':'display:none;'}">
				<div><a href="#" onclick="move('list','1');">[첫페이지]</a></div>
				<c:if test="${pager.startPage>pager.pageNavLength}">
					<div><a href="#" onclick="move('list','${pager.startPage-pager.pageNavLength}','');">[이전 ${pager.pageNavLength}개]</a></div>
				</c:if>
				<c:if test="${pager.startPage<=pager.pageNavLength}">
					<div>[이전 ${pager.pageNavLength}개]</div>
				</c:if>
				<c:forEach var="i" begin="${pager.startPage}" end="${pager.lastPage}" step="1">
					<c:if test="${i==pager.page}">
						<div>[${i}]</div>
					</c:if>
					<c:if test="${i!=pager.page}">
						<div><a href="#" onclick="move('list','${i}','');">${i}</a></div>
					</c:if>
				</c:forEach>
				<c:if test="${pager.lastPage<pager.totalPage}">
					<div><a href="#" onclick="move('list','${pager.startPage+pager.pageNavLength}','');">[다음 ${pager.pageNavLength}개]</a></div>
				</c:if>
				<c:if test="${pager.lastPage>=pager.totalPage}">
					<div>[다음 ${pager.pageNavLength}개]</div>
				</c:if>
				<div><a href="#" onclick="move('list','${pager.totalPage}','');">[끝페이지]</a></div>
			</div>
	    </div>
	    <div class="flex f-center">
		    <div class="flex f-center" id="searchForm">
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
					<button onclick="move('search')">검색</button>
					<button onclick="move('searchClear')">clear</button>
				</div>
			</div>
	    </div>
	    <div class="btn_block align-right">
	        <button type="button" onclick="move('reg','','')">글쓰기</button>
	    </div>
	</main>
</body>
<script>

const _categoryList = document.querySelector(".category-list-div");

function categoryCss(){
	const _icons = document.querySelectorAll(".icon");
    var _categorys = document.querySelectorAll(".category-content");
    _categorys.forEach(element => element.className += " category-content-color");
	
    var _category = document.querySelector(".${category}");
    if(_category!=null){
	    _category.style.backgroundColor = "#ff4747";
    }

    if(${totalCategoryCount>7}){
    	_categoryList.addEventListener("mouseover", function(){
    		_icons[1].style.display = "block";
    		_icons[2].style.display = "block";
    	});
    	_categoryList.addEventListener("mouseleave", function(){
    		_icons[1].style.display = "none";
    		_icons[2].style.display = "none";
    	});
   }
}

function categoryMove(v_ctgp){
	if(v_ctgp==null || v_ctgp == ''){
		v_ctgp = '1';
	}
	var xhr = new XMLHttpRequest(); 
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
        	_categoryList.innerHTML = xhr.responseText;
        	categoryCss();
           }
        }
    };
    xhr.open("GET", "/board/ctglist?ctgp="+v_ctgp);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(null);
}

document.addEventListener('DOMContentLoaded', categoryMove(${categoryPage}));

function openUserInfo(memberNo){
	
	var queryString = "?memberNo="+memberNo;
	var url = '/member/info'+queryString;
	var option = 'width=500, height=300, top=200%, left=500%, location=no, resizable=no';
	window.open(url, '', option);
	
}

function move(proc, v_page, v_no, v_ctg, v_ctgp){
	var sop;
	var sd;
	if(proc=='search'){
		proc = 'list';
		v_page = '1';
		sop = $('#search_option').val();
		sd = $('#search_data').val();
	}else if(proc == 'searchClear'){
		proc = 'list';
		v_page = '1';
		sop = '';
		sd = '';
	}	
	else{
		sop = '${searchOption}';
		sd = '${searchData}';
	}
	
	var ctg;
	if(v_ctg != null){
		ctg = v_ctg;
	}else{
		ctg = '${category}';
	}
	var queryString = "?p="+v_page+"&no="+v_no
					+"&s_op=" + sop
					+"&s_d=" + sd
					+"&ctg=" + ctg
					+"&ctgp=" + v_ctgp;
	location.href = proc + queryString;
}
$('#op_${searchOption}').prop('selected', true);

</script>
</html>