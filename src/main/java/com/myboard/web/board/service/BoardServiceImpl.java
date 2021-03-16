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
	public int insert(BoardDto dto) {
		
		return boardDao.insert(dto);
	}

	@Override
	public int delete(int no) {
		
		return boardDao.delete(no);
	}

	@Override
	public int update(BoardDto dto) {
		
		return boardDao.update(dto);
	}

	@Override
	public int updateLike(int no) {
		
		return boardDao.updateLike(no);
	}

	@Override
	public List<BoardDto> getList() {
		
		return boardDao.getList();
	}

	@Override
	public int getBoardNo(int fileNo) {
		
		return boardDao.getBoardNo(fileNo);
	}

}
