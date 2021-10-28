package com.myboard.web.board.file.service;

import com.myboard.web.board.file.entity.FileDto;

public interface FileService {
	int saveFile(FileDto dto);
	int getFileNo(String fileName);
	FileDto getFile(int fileNo);
	void setBoardNo(int boardNo, int fileNo);
	void delete(int boardNo);
}
