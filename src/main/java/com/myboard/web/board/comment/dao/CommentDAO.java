package com.myboard.web.board.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.board.comment.entity.CommentDTO;

@Mapper
public interface CommentDAO {

	List<CommentDTO> getList(int boardNo);

	int delete(int no);

	int insert(CommentDTO dto);

}
