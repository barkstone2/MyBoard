package com.myboard.web.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.board.entity.BoardDto;

@Mapper
public interface BoardDao {

	BoardDto getView(int no);

	void insert(BoardDto dto);

	void delete(int no);

	void update(BoardDto dto);

	void updateLike(int no);

	List<BoardDto> getList();
	
}
