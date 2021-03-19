package com.myboard.web.board.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.myboard.web.board.entity.BoardDTO;
import com.myboard.web.board.entity.BoardViewDTO;
import com.myboard.web.board.file.entity.FileDto;

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
	
	List<BoardViewDTO> getViewList(int offSet, int conPerPage, String searchOption, String searchData);
	Map<String, Integer> getPager(int conPerPage, int pageNavLength, int page);
	Map<String, Integer> getPager(int conPerPage, int pageNavLength, int page, int totalConCount);
	FileDto uploadImg(MultipartFile imgFile, String savePath) throws IllegalStateException, IOException;
	
	
	
	
}
