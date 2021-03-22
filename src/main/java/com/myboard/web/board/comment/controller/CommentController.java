package com.myboard.web.board.comment.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.myboard.web.member.entity.MemberDTO;

@Controller
@RequestMapping("/comment/")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	@GetMapping("list")
	public String list(
			@RequestParam(defaultValue = "1", name="cp") int commentPage, 
			@RequestParam(defaultValue = "", required = false) String initChk,
						int boardNo, Model model) {
		
		int conPerPage = 10; // 페이지 당 개시글 수(limit)
		int pageNavLength = 5; // 페이징 번호 범위
		
		// 댓글 최초 로드시 getPager 처리를 위해 cp = -1
		if(initChk.equals("init")) {
			commentPage = -1;
		}
		
		Map<String, Integer> pager = commentService.getPager(conPerPage, pageNavLength, commentPage, boardNo);
		model.addAttribute("pager", pager);
		
		List<CommentDTO> list = commentService.getList(pager.get("offSet"), conPerPage, boardNo);
		model.addAttribute("commentList", list);
		model.addAttribute("boardNo", boardNo);
		
		return "board/comment/list";
	}
	
	@PostMapping("reg")
	public String reg(
			@RequestParam(defaultValue = "1", name="cp") int commentPage, 
			String content, String writer, String pwd, int groupNo, int stepNo, int boardNo, 
			Model model, HttpServletRequest request) {
		
		int memberNo = 0;
		if(groupNo==0) groupNo = commentService.getMaxGroupNo(boardNo)+1;
		
		
		MemberDTO user = (MemberDTO)request.getSession().getAttribute("user");
		
		if(user != null) {
			writer = user.getNickName();
			memberNo = user.getNo();
		}
		
		CommentDTO dto = new CommentDTO(content, writer, pwd, groupNo, memberNo, stepNo, boardNo);
		int result = commentService.insert(dto);
		
		return list(commentPage, "init", boardNo, model);
	}
	
	@GetMapping("delete")
	public String delete(int boardNo, int no, Model model) {
		
		model.addAttribute("no", no);
		model.addAttribute("boardNo", boardNo);
		
		return "board/comment/delete";
	}
	
	@PostMapping("delete")
	public void delete(String pwd, int no, 
			@RequestParam(defaultValue = "0", required = false) int memberNo,
			Model model, HttpServletResponse response) throws IOException {
		
		String validPwd = commentService.pwdChk(no);
		int result = 0;
		String msg = "삭제 실패";
		
		if(memberNo>0) {
			result = commentService.delete(no);
			if(result>0) {
				msg = "삭제성공";
			}
			
		}else {
			
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
		}
		response.getWriter().write(msg);
	}
	
	
}
