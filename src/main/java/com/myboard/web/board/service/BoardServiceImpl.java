package com.myboard.web.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.board.dao.BoardDAO;
import com.myboard.web.board.entity.BoardDTO;
import com.myboard.web.board.entity.BoardViewDTO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDao;
	
	@Override
	public BoardDTO getView(int no) {
		
		return boardDao.getView(no);
	}

	@Override
	public int insert(BoardDTO dto) {
		
		return boardDao.insert(dto);
	}

	@Override
	public int delete(int no) {
		
		return boardDao.delete(no);
	}

	@Override
	public int update(BoardDTO dto) {
		
		return boardDao.update(dto);
	}

	@Override
	public int updateLike(int no) {
		
		return boardDao.updateLike(no);
	}

	@Override
	public int getBoardNo(int fileNo) {
		
		return boardDao.getBoardNo(fileNo);
	}

	@Override
	public int getTotalConCount() {
		
		return boardDao.getTotalConCount();
	}

	@Override
	public List<BoardDTO> getList(int startRecord, int endRecord) {
		return boardDao.getList(startRecord, endRecord);
	}

	@Override
	public List<BoardViewDTO> getViewList(int offSet, int conPerPage, String searchOption, String searchData) {
		return boardDao.getViewList(offSet, conPerPage, searchOption, searchData);
	}

}
