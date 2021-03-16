package com.myboard.web.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.board.entity.BoardDto;

@Mapper
public interface BoardDao {

	BoardDto getView(int no);

	int insert(BoardDto dto);

	int delete(int no);

	int update(BoardDto dto);

	int updateLike(int no);

	List<BoardDto> getList();

	int getBoardNo(int fileNo);
	
}
