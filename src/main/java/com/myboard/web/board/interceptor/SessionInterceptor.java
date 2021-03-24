package com.myboard.web.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.myboard.web.member.entity.MemberDTO;

@Component
public class SessionInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		
		String uri = request.getRequestURI();
		String method = request.getMethod();
		String reUrl = "/member/login";
		if(dto==null) {
			response.sendRedirect("/member/login");
			return false;
		}else {
			session.setMaxInactiveInterval(30*60);
			return true;
		}
	}
	
}
