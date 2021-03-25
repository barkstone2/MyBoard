package com.myboard.web.board.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.myboard.web.board.dao.BoardDAO;
import com.myboard.web.board.entity.BoardDTO;
import com.myboard.web.board.entity.BoardViewDTO;
import com.myboard.web.board.file.entity.FileDto;
import com.myboard.web.util.Util;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDao;
	
	@Qualifier("boardUtil")
	@Autowired
	private Util boardUtil;
	
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
	public int updateLike(int boardNo) {
		
		return boardDao.updateLike(boardNo);
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
	public List<BoardViewDTO> getViewList(int offSet, int conPerPage, String searchOption, String searchData, String category) {
		return boardDao.getViewList(offSet, conPerPage, searchOption, searchData, category);
	}

	@Override
	public Map<String, Integer> getPager(int conPerPage, int pageNavLength, int page) {
		
		return getPager(conPerPage, pageNavLength, page, getTotalConCount());
	}

	@Override
	public Map<String, Integer> getPager(int conPerPage, int pageNavLength, int page, int totalConCount) {
		
		return boardUtil.getPager(conPerPage, pageNavLength, page, totalConCount);
	}

	@Override
	public FileDto uploadImg(MultipartFile imgFile, String savePath) throws IllegalStateException, IOException {
		return boardUtil.uploadImg(imgFile, savePath);
	}

	@Override
	public int updateDisLike(int boardNo) {
		
		return boardDao.updateDisLike(boardNo);
	}

}
