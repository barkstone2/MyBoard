package com.myboard.web.board.file.dao;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.board.file.entity.FileDto;

@Mapper
public interface FileDao {

	int saveFile(FileDto dto);

	int getFileNo(String fileName);

	FileDto getFile(int fileNo);

	void setBoardNo(int boardNo, int fileNo);

	void delete(int boardNo);

}
