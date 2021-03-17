package com.myboard.web.board.file.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.board.file.dao.FileDao;
import com.myboard.web.board.file.entity.FileDto;

@Service
public class FileServiceImpl implements FileService {
	
	@Autowired
	private FileDao fileDao;

	@Override
	public int saveFile(FileDto dto) {
		fileDao.saveFile(dto);
		return getFileNo(dto.getFileName());
	}

	@Override
	public int getFileNo(String fileName) {
		
		return fileDao.getFileNo(fileName);
	}

	@Override
	public FileDto getFile(int fileNo) {
		
		return fileDao.getFile(fileNo);
	}

	@Override
	public void setBoardNo(int boardNo, int fileNo) {
		fileDao.setBoardNo(boardNo, fileNo);
	}

	@Override
	public void delete(int boardNo) {
		fileDao.delete(boardNo);
	}
	
	
}
