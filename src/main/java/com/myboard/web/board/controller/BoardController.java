package com.myboard.web.board.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myboard.web.board.comment.service.CommentService;
import com.myboard.web.board.entity.BoardDto;
import com.myboard.web.board.service.BoardService;

@Controller
@RequestMapping("/board/")
public class BoardController {
	
	@Autowired
	private BoardService service;

	@GetMapping("reg")
	public String reg() {
		
		return "board/reg";
	}
	
	@PostMapping("reg")
	public String reg(String title, String content, String writer, String pwd, Model model) throws IOException {
		BoardDto dto = new BoardDto(title, content, writer, pwd);
		int result = service.insert(dto);
		
		String msg = "";
		String reUrl = "/board/list";
		
		if(result>0) {
			msg = "작성 성공";
		}else {
			msg = "작성 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "/util/message";
	}
	
	@GetMapping("list")
	public String list(Model model) {
		
		List<BoardDto> list = service.getList();
		model.addAttribute("list", list);
		return "board/list";
	}
	
	@GetMapping(value = "{reqUrl}") // get view, modify
	public String view(int no, Model model, @PathVariable String reqUrl) {
		
		BoardDto dto = service.getView(no);
		model.addAttribute("dto", dto);
		
		return "board/"+reqUrl;
	}
	
	@PostMapping("modify")
	public String modify(int no, String title, String content, String writer, String pwd, Model model) {
		
		BoardDto dto = new BoardDto(no, title, content, writer, pwd);
		int result = service.update(dto);
		String msg = "";
		String reUrl = "/board/list";
		
		if(result>0) {
			msg = "수정 성공";
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
		BoardDto dto = service.getView(no);
		if(dto==null) {
			msg = "존재하지 않는 게시물입니다.";
		}else if(dto.getPwd().equals(pwd)) {
			int result = service.delete(no);
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
	
}
