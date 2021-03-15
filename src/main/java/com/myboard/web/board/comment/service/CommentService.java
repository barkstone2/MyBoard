package com.myboard.web.board.comment.service;

import java.util.List;

import com.myboard.web.board.comment.entity.CommentDTO;

public interface CommentService {
	
	List<CommentDTO> getList(int boardNo);
	int insert(CommentDTO dto);
	int delete(int no);
	int getMaxGroupNo(int boardNo);
	String pwdChk(int no);
}
