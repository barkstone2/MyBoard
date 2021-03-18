package com.myboard.web.board.service;

import java.util.List;

import com.myboard.web.board.entity.BoardDTO;
import com.myboard.web.board.entity.BoardViewDTO;

public interface BoardService {
	
	//게시글 상세 조회
	BoardDTO getView(int no);
	//게시글 등록
	int insert(BoardDTO dto);
	//게시글 삭제
	int delete(int no);
	//게시글 수정
	int update(BoardDTO dto);
	//좋아요 표시
	int updateLike(int no);
	//게시글 목록
	int getBoardNo(int fileNo);
	int getTotalConCount();
	List<BoardDTO> getList(int startRecord, int endRecord);
	
	List<BoardViewDTO> getViewList(int offSet, int conPerPage);
	
	
	
	
}
