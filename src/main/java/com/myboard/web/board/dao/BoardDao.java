package com.myboard.web.board.dao;

import java.util.List;

import com.myboard.web.board.entity.BoardDto;

public interface BoardDao {

	BoardDto getView(int no);

	void insert(BoardDto dto);

	void delete(int no);

	void update(BoardDto dto);

	void updateLike(int no);

	List<BoardDto> getList();
	
}
