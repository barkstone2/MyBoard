package com.myboard.web.board.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.board.comment.dao.CommentDAO;
import com.myboard.web.board.comment.entity.CommentDTO;

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

	@Override
	public int getMaxGroupNo(int boardNo) {
		
		return commentDAO.getMaxGroupNo(boardNo);
	}

	@Override
	public String pwdChk(int no) {
		
		return commentDAO.pwdChk(no);
	}

	

}
