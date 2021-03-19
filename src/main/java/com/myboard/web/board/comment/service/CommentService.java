package com.myboard.web.board.comment.service;

import java.util.List;
import java.util.Map;

import com.myboard.web.board.comment.entity.CommentDTO;

public interface CommentService {
	
	List<CommentDTO> getList(int offSet, int conPerPage, int boardNo);
	int insert(CommentDTO dto);
	int delete(int no);
	int getMaxGroupNo(int boardNo);
	String pwdChk(int no);
	int getTotalConCount(int boardNo);
	Map<String, Integer> getPager(int conPerPage, int pageNavLength, int commentPage, int boardNo);
}
