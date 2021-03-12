package com.myboard.web.board.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentServiceImpl implements CommentService{
	
	@Autowired
	private CommentDAO commentDAO;
	
	@Override
	public List<CommentDTO> getList(int boardNo) {
		
		return commentDAO.getList(boardNo);
	}
	
	@Override
	public int insert(CommentDTO dto) {
		
		return commentDAO.insert(dto);
	}

	@Override
	public int delete(int no) {
		
		return commentDAO.delete(no);
	}

	

}
