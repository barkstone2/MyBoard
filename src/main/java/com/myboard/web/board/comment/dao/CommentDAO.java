package com.myboard.web.board.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.board.comment.entity.CommentDTO;

@Mapper
public interface CommentDAO {

	List<CommentDTO> getList(int offSet, int conPerPage, int boardNo);

	int delete(int no);

	int insert(CommentDTO dto);

	int getMaxGroupNo(int boardNo);

	String pwdChk(int no);

	int getTotalConCount(int boardNo);

	int getDeletedCount(int boardNo);

}
