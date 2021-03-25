package com.myboard.web.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import com.myboard.web.member.entity.MemberDTO;

@Component
public class SessionInterceptor implements HandlerInterceptor{
	
	public final String[] NEEDSESSION = {"/member/modify", "/member/logout", "/board/like", "/board/dislike"};
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		
		String uri = request.getRequestURI();
		String method = request.getMethod();
		String reUrl = "/member/login";
		String msg = "로그인이 필요한 작업입니다.\\n로그인 페이지로 이동합니다.";
		if(dto==null) {
			ModelAndView mv = new ModelAndView("redirect:/util/message");
			mv.addObject("msg", msg);
			mv.addObject("reUrl", reUrl);
			throw new ModelAndViewDefiningException(mv);
		}else {
			session.setMaxInactiveInterval(30*60);
			return true;
		}
	}
	
}
