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
        height: 30px;
        line-height: 30px;
        min-width: 570px;
        align-items: center;
    }
     .btn_block {
        display: flex;
        min-width: 570px;
    }
.board_select{
	min-width:30px;
	min-height:30px;
	display:flex;
	align-items: center;
	justify-content: center;
}

.board_num{
    min-width:60px;
    text-align: center;
}
.board_category{
	min-width:100px;
	text-align: center;
}
.board_subj{
    width:250px;
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
	width:120px;
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
	min-width:700px;
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
.list-checkbox{
	width:20px;
	height:20px;
	border: 1px solid black;
	cursor: pointer;
	margin: 0px;
}
.hidden{
	display:none;
}
</style>
</head>
<body>
	<main class="list">
		<!-- 카테고리 한 화면에 6개가 최대 -->
		<div class="category-list-div">
		</div>
	    <div class="list_label">
	    	<div class="board_select"><input type="checkbox" id="checkAllBox" class="list-checkbox"></div>
	        <div class="board_num">번호</div>
	        <div class="board_category">분류</div>
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
	        	<div class="list-content-wrap" id="list-content-wrap${dto.no}">
		        	<div class="list_content">
		        		<div class="board_select"><input type="checkbox" class="list-checkbox checkBox-value" name="nos" value="${dto.no}"></div>
			            <div class="board_num">${dto.no}</div>
		             	<div class="board_category">${dto.category}<c:if test="${dto.category==null}">없음</c:if></div>
			            <div class="board_subj">
			            	<div class="flex">
				            	<div class="board_title">
					            	<a href="#" onclick="move('contentView','','${dto.no}')">${dto.title}</a>
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
			        <div id="listContentView${dto.no}" class="hidden content-view"></div>
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
			<div>
				<select name="ctgVal">
					<option>카테고리</option>
					<c:forEach var="categoryName" items="${categoryList}">
						<option value="${categoryName}">${categoryName}</option>
					</c:forEach>
				</select>
				<button type="button" onclick="changeCategory();">카테고리 변경</button>
				<button type="button" onclick="deleteSelected();">삭제</button>
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


// 관리자 페이지 게시글 체크박스 스크립트
const checkAllBtn = document.querySelector("#checkAllBox");
var checkBoxs = document.querySelectorAll(".checkBox-value");
checkAllBtn.addEventListener('click', function(){
	checkBoxs.forEach(element => element.checked = checkAllBtn.checked);
});

// 선택 삭제
function deleteSelected(){
	
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action', '/admin/board/delsel');
	checkBoxs.forEach(function(element){
		if(element.checked){
			form.appendChild(element);
		}
	});
	document.body.appendChild(form);
	form.submit();
}

// 카테고리 변경
function changeCategory(){
	var ctgVal = document.getElementsByName("ctgVal")[0];
	var nos = "";
	
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action', '/admin/board/chanctg');
	form.appendChild(ctgVal);
	checkBoxs.forEach(function(element){
		if(element.checked){
			//nos += element.value + ",";
			form.appendChild(element);
		}
	});
	document.body.appendChild(form);
	form.submit();
}



// 카테고리 출력 스크립트
const _categoryList = document.querySelector(".category-list-div");

function categoryCss(){
	const _icons = document.querySelectorAll(".icon");
    var _categorys = document.querySelectorAll(".category-content");
    _categorys.forEach(element => element.className += " category-content-color");
	
    var _category = document.querySelector(".${category}");
    if(_category!=null){
	    _category.style.backgroundColor = "#ff4747";
    }

    if(${totalCategoryCount>6}){
    	_categoryList.addEventListener("mouseover", function(){
    		_icons[0].style.display = "block";
    		_icons[1].style.display = "block";
    	});
    	_categoryList.addEventListener("mouseleave", function(){
    		_icons[0].style.display = "none";
    		_icons[1].style.display = "none";
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

// 회원 정보 팝업 오픈 스크립트
function openUserInfo(memberNo){
	
	var queryString = "?memberNo="+memberNo;
	var url = '/member/info'+queryString;
	var option = 'width=500, height=300, top=200%, left=500%, location=no, resizable=no';
	window.open(url, '', option);
	
}

// 페이지 이동 스크립트
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
	}else if(proc == 'contentView'){
		var target = document.querySelector("#listContentView"+v_no);
		var contentViewClass = document.querySelectorAll(".content-view");
		target.classList.toggle("hidden");
		contentViewClass.forEach(function(elem){
			if(elem == target){
			}else{
				elem.classList.add("hidden");
			}
		});	
		var xhr = new XMLHttpRequest(); 
	    xhr.onreadystatechange = function() {
	      if (xhr.readyState === 4) {
	        if (xhr.status === 200) {
	        	target.innerHTML = xhr.responseText;
	        }
	      }
	    };

	    xhr.open("GET", "view?no="+v_no);
	    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	    xhr.send(null);
		return;
	}	
	else{
		sop = '${searchOption}';
		sd = '${searchData}';
	}
	
	var page = '${page}';
	var no = '${no}';
	var ctg = '${category}';
	var ctgp = '${ctgp}';
	if(v_ctg != null) ctg = v_ctg;
	if(v_ctgp != null) ctgp = v_ctgp;
	if(v_page != null) page = v_page;
	if(v_no != null) no = v_no;
	
	var queryString = "?p="+page+"&no="+no
					+"&s_op=" + sop
					+"&s_d=" + sd
					+"&ctg=" + ctg
					+"&ctgp=" + ctgp;
	location.href = proc + queryString;
}

$('#op_${searchOption}').prop('selected', true);

</script>
</html>