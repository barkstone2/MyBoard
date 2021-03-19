package com.myboard.web.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.myboard.web.board.file.entity.FileDto;

@Component(value = "commentUtil")
public class CommentUtil implements Util{
	
	@Override
	public Map<String, Integer> getPager(int conPerPage, int pageNavLength, int commentPage, int totalConCount) {
		
		int totalPage = (int)Math.ceil((totalConCount / (double)conPerPage)); // 총 페이지 수
		if(totalPage==0) totalPage = 1;
		
		if(commentPage==-1&&totalPage>0) {
			commentPage = totalPage;
		}
		
		int offSet = (commentPage-1) * conPerPage;
		
//		int indexNo = totalConCount - conPerPage * (pageNumber -1); // 게시글 순번
		
		// 페이징 번호 출력 범위 ex) 1~5 6~10
		int startPage = 1;
		int lastPage = 1;
		startPage = (commentPage / pageNavLength - (commentPage % pageNavLength!=0 ? 0:1)) * pageNavLength +1; 
		lastPage = startPage + pageNavLength -1;
		if(lastPage>totalPage)lastPage=totalPage;
		
		
		Map<String, Integer> pager = new HashMap<>();
		pager.put("offSet", offSet);
		pager.put("totalPage", totalPage);
		pager.put("totalConCount", totalConCount);
		pager.put("startPage", startPage);
		pager.put("lastPage", lastPage);
		pager.put("commentPage", commentPage);
		pager.put("pageNavLength", pageNavLength);
		
		return pager;
	}
	
	@Deprecated
	@Override
	public FileDto uploadImg(MultipartFile imgFile, String savePath) {
		return null;
	}

}
