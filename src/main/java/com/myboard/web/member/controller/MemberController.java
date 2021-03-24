package com.myboard.web.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myboard.web.member.entity.MemberDTO;
import com.myboard.web.member.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping(value = "{reqUrl}")
	public String move(@PathVariable String reqUrl, HttpServletRequest request, Model model) {
		
		if(reqUrl.equals("view")||reqUrl.equals("modify")) {
			if(request.getSession().getAttribute("user")!=null) {
				int cookNo = ((MemberDTO)request.getSession().getAttribute("user")).getNo();
				MemberDTO dto = memberService.getView(cookNo);
				model.addAttribute("dto", dto);
			}
		}
		
		return "member."+reqUrl;
	}
	
	@PostMapping("reg")
	public String reg(String id, String pwd, String pwdc, String nickName, 
			String email1, String email2, Model model) {
		
		String msg = "";
		String reUrl = "/member/login";
		
		if(!pwd.equals(pwdc)) {
			msg = "비밀번호가 서로 일치하지 않습니다.";
			
			//임시 유효성 검사
		}else if(id.equals("")||pwd.equals("")
				||pwdc.equals("")||nickName.equals("")
				||email1.equals("")||email2.equals("")) {
			msg = "비정상적인 입력값입니다.";
		}else {
		
			String email = email1 + "@" + email2;
			
			MemberDTO dto = new MemberDTO(id, pwd, nickName, email);
			int result = memberService.insert(dto);
			
			if(result>0) {
				msg = "회원가입 성공";
			}else {
				msg = "회원가입 실패";
			}
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		return "util.message";
	}
	
	@PostMapping("login")
	public String login(String id, String pwd, Model model, HttpServletRequest request) {
		
		String msg = "";
		String reUrl = "/member/login";
		MemberDTO user = memberService.login(id, pwd);
		
		if(user!=null) {
			request.getSession().setAttribute("user", user);
			return "redirect:/member/view";
		}else {
			try {
				int loginChk = memberService.loginChk(id);
				msg = "비밀번호가 일치하지 않습니다.";
			}catch (Exception a) {
				msg = "존재하지 않는 아이디입니다.";
			}
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "util.message";
	}
	
	@GetMapping("logout")
	public String logout(Model model, HttpServletRequest request) {
		String msg = "";
		String reUrl = "/member/login";
		
		if(request.getSession().getAttribute("user")!=null) {
			msg = "로그아웃 되었습니다.";
			request.getSession().invalidate();
		}else {
			msg = "로그인 되어 있지 않습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		return "util.message";
	}
	
	@PostMapping("modify")
	public String modify(String pwd, String pwdc, String nickName, 
			String email1, String email2, Model model, HttpServletRequest request) {
		
		String msg = "";
		String reUrl = "/member/view";
		
		int cookNo = request.getSession().getAttribute("cookNo")!=null?
				(int)request.getSession().getAttribute("cookNo"):0;
		
		if(!pwd.equals(pwdc)) {
			msg = "비밀번호가 서로 일치하지 않습니다.";
			
			//임시 유효성 검사
		}else if(pwd.equals("")
				||pwdc.equals("")||nickName.equals("")
				||email1.equals("")||email2.equals("")) {
			msg = "비정상적인 입력값입니다.";
		}else if(cookNo==0) {
			msg = "로그인이 필요합니다.";
		}
		else {
		
			String email = email1 + "@" + email2;
			
			MemberDTO dto = new MemberDTO(cookNo, pwd, nickName, email);
			int result = memberService.update(dto);
			
			if(result>0) {
				msg = "회원정보 수정 성공";
			}else {
				msg = "회원정보 수정 실패";
			}
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		return "util.message";
	}
	
	@GetMapping("info")
	public String info(int memberNo, Model model) {
		
		MemberDTO dto = memberService.getView(memberNo);
		model.addAttribute("dto", dto);
		
		return "member/info";
	}
	
	
	
	
	
	
	
	
}
