package com.myboard.web.board.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@GetMapping("view")
	public String view(int no, Model model) {
		
		BoardDto dto = service.getView(no);
		model.addAttribute("dto", dto);
		
		return "board/view";
	}
}
