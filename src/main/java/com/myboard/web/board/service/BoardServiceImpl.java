package com.myboard.web.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.board.dao.BoardDao;
import com.myboard.web.board.entity.BoardDto;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public BoardDto getView(int no) {
		
		return boardDao.getView(no);
	}

	@Override
	public void insert(BoardDto dto) {
		boardDao.insert(dto);
	}

	@Override
	public void delete(int no) {
		boardDao.delete(no);
	}

	@Override
	public void update(BoardDto dto) {
		boardDao.update(dto);
	}

	@Override
	public void updateLike(int no) {
		boardDao.updateLike(no);
	}

	@Override
	public List<BoardDto> getList() {
		
		return boardDao.getList();
	}

}
