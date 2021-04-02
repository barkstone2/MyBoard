<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form method="post">
	<input type="hidden" name="no" value="${no}">
	<input type="password" name="pwd">
	<button type="submit">확인</button>
	<button type="button" onclick="move('view','${pageNumber}','${no}')">취소</button>
</form>
<script>
function move(proc, v_page, v_no, v_ctg, v_ctgp, v_order){
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