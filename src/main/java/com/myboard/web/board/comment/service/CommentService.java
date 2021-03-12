package com.myboard.web.board.comment.service;

import java.util.List;

public interface CommentService {
	
	List<CommentDTO> getList(int boardNo);
	int insert(CommentDTO dto);
	int delete(int no);
}
