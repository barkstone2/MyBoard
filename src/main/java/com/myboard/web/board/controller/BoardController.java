package com.myboard.web.board.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.myboard.web.board.entity.BoardDTO;
import com.myboard.web.board.entity.BoardViewDTO;
import com.myboard.web.board.file.entity.FileDto;
import com.myboard.web.board.file.service.FileService;
import com.myboard.web.board.service.BoardService;
import com.myboard.web.member.entity.MemberDTO;

@Controller
@RequestMapping("/board/")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private FileService fileService;
	
	@GetMapping("reg")
	public String reg() {
		
		return "board.reg";
	}
	
	@GetMapping("pw")
	public String pw(
			@RequestParam(defaultValue = "1", name="p") int page, 
			@RequestParam(required = false, name = "s_op", defaultValue = "") String searchOption,
			@RequestParam(required = false, name = "s_d", defaultValue = "") String searchData, 
			int no, String reqUrl, 
			Model model, HttpServletRequest request) {
		
		model.addAttribute("page", page);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchData", searchData);
		model.addAttribute("no", no);
		model.addAttribute("reqUrl", reqUrl);
		
		return "board.pw";
	}
	
	@PostMapping("reg")
	public String reg(String title, String content, String writer, String pwd, MultipartFile imgFile, 
			Model model, HttpServletRequest request) throws IOException {
		
		int fileNo = 0;
		String msg = "";
		String reUrl = "/board/list";
		
		int memberNo = 0;
		
		MemberDTO user = (MemberDTO)request.getSession().getAttribute("user");
		
		if(user != null) {
			writer = user.getNickName();
			memberNo = user.getNo();
		}
		
		
		if(!imgFile.isEmpty()) {
			String savePath = "C:/images/file/";

			// 파일 타입 체크
			String contentType = imgFile.getContentType();
			if(!contentType.contains("image")) {
				msg = "이미지 파일만 업로드 가능합니다.";
				reUrl = "/board/list";
				return "util.message";
			}
			
			fileNo = fileService.saveFile(boardService.uploadImg(imgFile, savePath)); // Service에서 fileNo 반환 처리
		}
		
		BoardDTO dto = new BoardDTO(title, content, writer, pwd, fileNo, memberNo);
		int result = boardService.insert(dto);
		
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
		
		return "util.message";
	}
	
	@GetMapping("list")
	public String list(
			@RequestParam(defaultValue = "1", name="p") int page, 
			@RequestParam(required = false, name = "s_op", defaultValue = "") String searchOption,
			@RequestParam(required = false, name = "s_d", defaultValue = "") String searchData, 
						Model model) {
		
		int conPerPage = 10; // 페이지 당 개시글 수(limit)
		int pageNavLength = 5; // 페이징 번호 범위
		
		Map<String, Integer> pager = boardService.getPager(conPerPage, pageNavLength, page);
		model.addAttribute("pager", pager);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchData", searchData);
		
		List<BoardViewDTO> list = boardService.getViewList(pager.get("offSet"), conPerPage, searchOption, searchData);
		model.addAttribute("list", list);
		return "board.list";
	}
	
	@GetMapping("view")
	public String view(
			@RequestParam(defaultValue = "1", name="p") int page, 
			@RequestParam(required = false, name = "s_op", defaultValue = "") String searchOption,
			@RequestParam(required = false, name = "s_d", defaultValue = "") String searchData, 
			int no, Model model, HttpServletRequest request) {
		
		BoardDTO dto = boardService.getView(no);
		model.addAttribute("dto", dto);
		
		FileDto fileDto = fileService.getFile(dto.getFileNo());
		model.addAttribute("fileDto", fileDto);
		
		model.addAttribute("page", page);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchData", searchData);
		
		
		return "board.view";
	}
	
	@GetMapping("modify")
	public String modify(
			@RequestParam(defaultValue = "1", name="p") int page, 
			@RequestParam(required = false, name = "s_op", defaultValue = "") String searchOption,
			@RequestParam(required = false, name = "s_d", defaultValue = "") String searchData, 
			int no, String pwd, Model model, HttpServletRequest request) {
		
		BoardDTO dto = boardService.getView(no);
		model.addAttribute("dto", dto);
		
		FileDto fileDto = fileService.getFile(dto.getFileNo());
		model.addAttribute("fileDto", fileDto);
		
		model.addAttribute("page", page);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchData", searchData);
		
		if(dto.getMemberNo()>0) {
			MemberDTO user = (MemberDTO)request.getSession().getAttribute("user");
			if(user!=null && user.getNo()==dto.getMemberNo()) {
			}else {
				String msg = "권한이 없습니다.";
				String reUrl = "/board/view?no="+no;
				model.addAttribute("msg", msg);
				model.addAttribute("reUrl", reUrl);
				return "util.message";
			}
		}else if(pwd != null && !pwd.equals("")) {
			if(dto.getPwd().equals(pwd)) {
			}else {
				String msg = "비밀번호가 일치하지 않습니다.";
				String reUrl = "/board/view?no="+no;
				model.addAttribute("msg", msg);
				model.addAttribute("reUrl", reUrl);
				return "util.message";
			}	
		}else {
			model.addAttribute("no", no);
			model.addAttribute("reqUrl", "modify");
			return "board.pw";
		}
		
		return "board.modify";
	}
	
	
	@PostMapping("modify")
	public String modify(int no, String title, String content, String writer, String pwd, 
			MultipartFile imgFile, int fileDelChk, Model model) throws IllegalStateException, IOException {
		
		int fileNo = 0;
		String msg = "";
		String reUrl = "/board/list";
		
		if(!imgFile.isEmpty()) {
			String savePath = "C:/images/file/";

			// 파일 타입 체크
			String contentType = imgFile.getContentType();
			if(!contentType.contains("image")) {
				msg = "이미지 파일만 업로드 가능합니다.";
				reUrl = "/board/list";
				model.addAttribute("msg", msg);
				model.addAttribute("reUrl", reUrl);
				return "util.message";
			}
			fileNo = fileService.saveFile(boardService.uploadImg(imgFile, savePath)); // Service에서 fileNo 반환 처리
			
			// 기존 파일이 존재하는지 확인.
			// 새 파일이 업로드 되었으니 기존 파일 삭제.
			int curFileNo = boardService.getView(no).getFileNo();
			if(curFileNo>0) {
				String curFilePath = fileService.getFile(curFileNo).getFilePath();
				new File(curFilePath).delete();
				fileService.delete(no);
			}

			
		// 첨부파일 삭제 요청 시
		}else if(fileDelChk==1) {
			int curFileNo = boardService.getView(no).getFileNo();
			if(curFileNo>0) {
				String curFilePath = fileService.getFile(curFileNo).getFilePath();
				new File(curFilePath).delete();
				fileService.delete(no);
			}
		}
		
		BoardDTO dto = new BoardDTO(no, title, content, writer, pwd, fileNo);
		int result = boardService.update(dto);
		
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
		
		return "util.message";
	}
	
	@GetMapping("delete")
	public String delete(int no, Model model) {
		model.addAttribute("no", no);
		model.addAttribute("reqUrl", "delete");
		return "board.pw";
	}
	
	@PostMapping("delete")
	public String delete(int no, String pwd, Model model, HttpServletRequest request) {
		String msg = "";
		String reUrl = "/board/list";
		BoardDTO dto = boardService.getView(no);
		
		MemberDTO user = (MemberDTO)request.getAttribute("user");
		
		if(dto==null) {
			msg = "존재하지 않는 게시물입니다.";
		}else if(dto.getMemberNo()>0) {
			if(user!=null&&user.getNo()==dto.getMemberNo()) {
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
				msg = "권한이 없습니다.";
			}
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
			reUrl = "/board/view?no="+no;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "util.message";
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
	
	@GetMapping("imguploader")
	public String imgUploader() {
		
		return "board/imgUploader";
	}
	
	@GetMapping("imgpopup")
	public String imgPopup() {
		
		return "board/imgPopup";
	}
	
	@PostMapping("imgpopup")
	public void imgPopup(MultipartFile attachedImg, Model model, HttpServletResponse response) throws IllegalStateException, IOException {
		String savePath = "C:/images/image/";

		String contentType = attachedImg.getContentType();
		if(!contentType.contains("image")) {
			return;
		}
		
		response.getWriter().write(boardService.uploadImg(attachedImg, savePath).getFileName());
	}
	
	
}
