package com.myboard.web.util;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.myboard.web.board.file.entity.FileDto;

public interface Util {
	
	public Map<String, Integer> getPager(int conPerPage, int pageNavLength, int page, int totalConCount);

	public FileDto uploadImg(MultipartFile imgFile, String savePath) throws IllegalStateException, IOException;
	
}
