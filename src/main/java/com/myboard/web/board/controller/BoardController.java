package com.myboard.web.board.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.myboard.web.board.comment.service.CommentService;
import com.myboard.web.board.entity.BoardDto;
import com.myboard.web.board.file.entity.FileDto;
import com.myboard.web.board.file.service.FileService;
import com.myboard.web.board.service.BoardService;

@Controller
@RequestMapping("/board/")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private FileService fileService;
	
	@GetMapping("reg")
	public String reg() {
		
		return "board/reg";
	}
	
	@PostMapping("reg")
	public String reg(String title, String content, String writer, String pwd, MultipartFile imgFile, Model model) throws IOException {
		
		int fileNo = 0;
		
		if(!imgFile.isEmpty()) {
			String origFileName = imgFile.getOriginalFilename();
			String fileName = UUID.randomUUID().toString();
			String savePath = "C:/images/file/";
			
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
			FileDto fileDto = new FileDto(filePath, origFileName, fileName);
			fileNo = fileService.saveFile(fileDto); // Service에서 fileNo 반환 처리
			
		}
		
		BoardDto dto = new BoardDto(title, content, writer, pwd, fileNo);
		int result = boardService.insert(dto);
		
		String msg = "";
		String reUrl = "/board/list";
		
		if(result>0) {
			msg = "작성 성공";
			if(fileNo>0) {
				int boardNo = boardService.getBoardNo(fileNo);
				fileService.setBoardNo(boardNo, fileNo);
			}
		}else {
			msg = "작성 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "/util/message";
	}
	
	@GetMapping("list")
	public String list(Model model) {
		
		List<BoardDto> list = boardService.getList();
		model.addAttribute("list", list);
		return "board/list";
	}
	
	@GetMapping(value = "{reqUrl}") // get view, modify
	public String view(int no, Model model, @PathVariable String reqUrl) {
		
		BoardDto dto = boardService.getView(no);
		model.addAttribute("dto", dto);
		
		FileDto fileDto = fileService.getFile(dto.getFileNo());
		model.addAttribute("fileDto", fileDto);
		
		return "board/"+reqUrl;
	}
	
	@PostMapping("modify")
	public String modify(int no, String title, String content, String writer, String pwd, 
			MultipartFile imgFile, int fileDelChk, Model model) throws IllegalStateException, IOException {
		
		
		int fileNo = 0;
		
		if(!imgFile.isEmpty()) {
			String origFileName = imgFile.getOriginalFilename();
			String fileName = UUID.randomUUID().toString();
			String savePath = "C:/images/file/";
			
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
			FileDto fileDto = new FileDto(filePath, origFileName, fileName);
			fileNo = fileService.saveFile(fileDto); // Service에서 fileNo 반환 처리
			
			int curFileNo = boardService.getView(no).getFileNo();
			if(curFileNo>0) {
				String curFilePath = fileService.getFile(curFileNo).getFilePath();
				new File(curFilePath).delete();
				fileService.delete(no);
			}
		}else if(fileDelChk==1) {
			int curFileNo = boardService.getView(no).getFileNo();
			if(curFileNo>0) {
				String curFilePath = fileService.getFile(curFileNo).getFilePath();
				new File(curFilePath).delete();
				fileService.delete(no);
			}
		}
		
		BoardDto dto = new BoardDto(no, title, content, writer, pwd, fileNo);
		int result = boardService.update(dto);
		
		String msg = "";
		String reUrl = "/board/list";
		
		if(result>0) {
			msg = "수정 성공";
			if(fileNo>0) {
				fileService.setBoardNo(no, fileNo);
			}
		}else {
			msg = "수정 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "/util/message";
	}
	
	@GetMapping("delete")
	public String delete(int no, Model model) {
		model.addAttribute("no", no);
		
		return "board/delete";
	}
	
	@PostMapping("delete")
	public String delete(int no, String pwd, Model model) {
		String msg = "";
		String reUrl = "/board/list";
		BoardDto dto = boardService.getView(no);
		if(dto==null) {
			msg = "존재하지 않는 게시물입니다.";
		}else if(dto.getPwd().equals(pwd)) {
			int fileNo = dto.getFileNo();
			if(fileNo>0) {
				FileDto file = fileService.getFile(fileNo);
				new File(file.getFilePath()).delete();
			}
			int result = boardService.delete(no);
			if(result>0) {
				msg = "삭제 성공";
			}else {
				msg = "삭제 실패";
			}
		}else {
			msg = "비밀번호가 일치하지 않습니다.";
			reUrl = "/board/delete?no="+no;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "/util/message";
	}
	
	@GetMapping(value = "download/{fileNo}")
	public ResponseEntity<Resource> downloadImg(@PathVariable int fileNo, Model model) throws IOException {
		FileDto fileDto = fileService.getFile(fileNo);
		Path path = Paths.get(fileDto.getFilePath());
		
	    Resource resource = new InputStreamResource(Files.newInputStream(path));
	    return ResponseEntity.ok()
	            .contentType(MediaType.parseMediaType("application/octet-stream"))
	            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileDto.getOrigFileName() + "\"")
	            .body(resource);
	    
	}
	
	@GetMapping("imgUploader")
	public String imgUploader() {
		
		return "board/imgUploader";
	}
	
	@GetMapping("imgPopup")
	public String imgPopup() {
		
		return "board/imgPopup";
	}
	
	@PostMapping("imgPopup")
	public void imgPopup(MultipartFile attachedImg, Model model, HttpServletResponse response) throws IllegalStateException, IOException {
		String origFileName = attachedImg.getOriginalFilename();
		String contentType = attachedImg.getContentType();
		String fileType = contentType.substring(contentType.indexOf("/")+1);
		String fileName = UUID.randomUUID().toString();
		String savePath = "C:/images/image/";
		
		if(!contentType.contains("image")) {
			return;
		}
		
		System.out.println(fileName+"."+fileType);
		// 업로드 경로가 없을 경우 확인 후 폴더 생성
		if(!new File(savePath).exists()) {
			try {
				new File(savePath).mkdirs();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 파일 경로 + 구분자 + 파일이름
		String filePath = savePath + fileName;
		
		//파일 세이브
		attachedImg.transferTo(new File(filePath));
		
		response.getWriter().write(fileName);
	}
	
	
}
