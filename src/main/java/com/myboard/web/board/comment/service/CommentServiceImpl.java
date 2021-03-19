package com.myboard.web.board.comment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.myboard.web.board.comment.dao.CommentDAO;
import com.myboard.web.board.comment.entity.CommentDTO;
import com.myboard.web.util.Util;

@Service
public class CommentServiceImpl implements CommentService{
	
	@Autowired
	private CommentDAO commentDAO;
	
	@Qualifier("commentUtil")
	@Autowired
	private Util commentUtil;
	
	@Override
	public List<CommentDTO> getList(int offSet, int conPerPage, int boardNo) {
		
		return commentDAO.getList(offSet, conPerPage, boardNo);
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

	@Override
	public int getTotalConCount(int boardNo) {
		return commentDAO.getTotalConCount(boardNo);
	}

	@Override
	public Map<String, Integer> getPager(int conPerPage, int pageNavLength, int commentPage, int boardNo) {
		
		return commentUtil.getPager(conPerPage, pageNavLength, commentPage, getTotalConCount(boardNo));
	}

	

}
