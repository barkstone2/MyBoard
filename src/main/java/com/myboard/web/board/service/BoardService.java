package com.myboard.web.board.service;

import java.util.List;

import com.myboard.web.board.entity.BoardDto;

public interface BoardService {
	
	//게시글 상세 조회
	BoardDto getView(int no);
	//게시글 등록
	int insert(BoardDto dto);
	//게시글 삭제
	int delete(int no);
	//게시글 수정
	int update(BoardDto dto);
	//좋아요 표시
	int updateLike(int no);
	//게시글 목록
	List<BoardDto> getList();
	int getBoardNo(int fileNo);
	
	
	
	
}
