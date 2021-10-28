package com.myboard.web.util;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.myboard.web.board.file.entity.FileDto;

@Component(value = "boardUtil")
public class BoardUtil implements Util{
	

	@Override
	public Map<String, Integer> getPager(int conPerPage, int pageNavLength, int page, int totalConCount) {
		
		int offSet = (page-1) * conPerPage;
		
//		int indexNo = totalConCount - conPerPage * (pageNumber -1); // 게시글 순번
		
		int totalPage = (int)Math.ceil((totalConCount / (double)conPerPage)); // 총 페이지 수
		
		// 페이징 번호 출력 범위 ex) 1~5 6~10
		int startPage = 1;
		int lastPage = 1;
		startPage = (page / pageNavLength - (page % pageNavLength!=0 ? 0:1)) * pageNavLength +1; 
		lastPage = startPage + pageNavLength -1;
		if(lastPage>totalPage)lastPage=totalPage;
		
		
		Map<String, Integer> pager = new HashMap<>();
		pager.put("offSet", offSet);
		pager.put("totalPage", totalPage);
		pager.put("totalConCount", totalConCount);
		pager.put("startPage", startPage);
		pager.put("lastPage", lastPage);
		pager.put("page", page);
		pager.put("pageNavLength", pageNavLength);
		
		
		return pager;
	}

	@Override
	public FileDto uploadImg(MultipartFile imgFile, String savePath) throws IllegalStateException, IOException {
		String origFileName = imgFile.getOriginalFilename();
		String fileName = UUID.randomUUID().toString();
		
		// 업로드 경로가 없을 경우 확인 후 폴더 생성
		if(!new File(savePath).exists()) {
			try {
				new File(savePath).mkdirs();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 파일 경로 + 파일이름
		String filePath = savePath + fileName;
		
		//파일 세이브
		imgFile.transferTo(new File(filePath));
		
		return new FileDto(filePath, origFileName, fileName);
	}
}
