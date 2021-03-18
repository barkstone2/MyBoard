package com.myboard.web.board.comment.dao.mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.myboard.web.board.comment.dao.CommentDAO;
import com.myboard.web.board.comment.entity.CommentDTO;

@Component
public class MybatisCommentDAO implements CommentDAO{
	
	private CommentDAO mapper;
	
	@Autowired
	public MybatisCommentDAO(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(CommentDAO.class);
	}
	
	@Override
	public List<CommentDTO> getList(int offSet, int conPerPage, int boardNo) {
		
		return mapper.getList(offSet, conPerPage, boardNo);
	}

	@Override
	public int delete(int no) {
		
		return mapper.delete(no);
	}

	@Override
	public int insert(CommentDTO dto) {
		
		return mapper.insert(dto);
	}

	@Override
	public int getMaxGroupNo(int boardNo) {
		
		return mapper.getMaxGroupNo(boardNo);
	}

	@Override
	public String pwdChk(int no) {
		
		return mapper.pwdChk(no);
	}

	@Override
	public int getTotalConCount(int boardNo) {
		
		return mapper.getTotalConCount(boardNo);
	}

}
