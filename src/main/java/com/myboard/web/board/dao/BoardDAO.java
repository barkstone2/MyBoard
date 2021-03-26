package com.myboard.web.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.board.entity.BoardDTO;
import com.myboard.web.board.entity.BoardViewDTO;

@Mapper
public interface BoardDAO {

	BoardDTO getView(int no);

	int insert(BoardDTO dto);

	int delete(int no);

	int update(BoardDTO dto);

	int updateLike(int no);

	int getBoardNo(int fileNo);

	int getTotalConCount(String searchOption, String searchData, String category);

	List<BoardDTO> getList(int startRecord, int endRecord);

	List<BoardViewDTO> getViewList(int offSet, int conPerPage, String searchOption, String searchData, String category);

	int updateDisLike(int boardNo);
	
}
