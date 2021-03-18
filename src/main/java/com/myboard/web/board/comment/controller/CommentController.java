package com.myboard.web.board.comment.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myboard.web.board.comment.entity.CommentDTO;
import com.myboard.web.board.comment.service.CommentService;

@Controller
@RequestMapping("/comment/")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	@GetMapping("list")
	public String list(@RequestParam(defaultValue = "1", name="cp") int commentPage, 
						@RequestParam(defaultValue = "", required = false) String initChk,
						int boardNo, Model model) {
		
		
		
		int conPerPage = 10; // 페이지 당 개시글 수(limit)
		int pageNavLength = 5; // 페이징 번호 범위
		int totalConCount = commentService.getTotalConCount(boardNo); // 컨텐츠의 총 개수
//		int indexNo = totalConCount - conPerPage * (pageNumber -1); // 게시글 순번
		int totalPage = (int)Math.ceil((totalConCount / (double)conPerPage)); // 총 페이지 수
		
		if(initChk.equals("init")) {
			commentPage = totalPage;
		}
		
		int offSet = (commentPage-1) * conPerPage;
		
		// 페이징 번호 출력 범위 ex) 1~5 6~10
		int startPage = 1;
		int lastPage = 1;
		startPage = (commentPage / pageNavLength - (commentPage % pageNavLength!=0 ? 0:1)) * pageNavLength +1; 
		lastPage = startPage + pageNavLength -1;
		if(lastPage>totalPage)lastPage=totalPage;
		
		model.addAttribute("pageNavLength", pageNavLength);
		model.addAttribute("totalConCount", totalConCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("commentPage", commentPage);
		
		List<CommentDTO> list = commentService.getList(offSet, conPerPage, boardNo);
		
		model.addAttribute("commentList", list);
		model.addAttribute("boardNo", boardNo);
		
		return "board/comment/list";
	}
	
	@PostMapping("reg")
	public String reg(@RequestParam(defaultValue = "1", name="cp") int commentPage, String content, String writer, String pwd, int groupNo, int stepNo, int boardNo, Model model) {
		
		content = content.replace(",", "");
		writer = writer.replace(",", "");
		pwd = pwd.replace(",", "");
		
		int memberNo = 0;
		if(groupNo==0) groupNo = commentService.getMaxGroupNo(boardNo)+1;
		
		CommentDTO dto = new CommentDTO(content, writer, pwd, groupNo, memberNo, stepNo, boardNo);
		int result = commentService.insert(dto);
		
		return list(commentPage, "", boardNo, model);
	}
	
	@GetMapping("delete")
	public String delete(int boardNo, int no, Model model) {
		
		model.addAttribute("no", no);
		model.addAttribute("boardNo", boardNo);
		
		return "board/comment/delete";
	}
	
	@PostMapping("delete")
	public void delete(String pwd, int no, Model model, HttpServletResponse response) throws IOException {
		pwd = pwd.replace(",", "");
		
		String validPwd = commentService.pwdChk(no);
		int result = 0;
		String msg = "삭제 실패";
		if(pwd.equals(validPwd)) {
			result = commentService.delete(no);
		}else if(pwd.equals("")||pwd==null){
			msg = "비밀번호를 입력하세요";
		}else{
			msg = "비밀번호가 일치하지 않습니다.";
		}
		
		if(result>0) {
			msg = "삭제 성공";
		}
		
		response.getWriter().write(msg);
	}
	
	
}
