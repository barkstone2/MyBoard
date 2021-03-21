package com.myboard.web.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.member.dao.MemberDAO;
import com.myboard.web.member.entity.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int insert(MemberDTO dto) {
		return memberDAO.insert(dto);
	}

	@Override
	public MemberDTO login(String id, String pwd) {
		return memberDAO.login(id, pwd);
	}

	@Override
	public int loginChk(String id) {
		return memberDAO.loginChk(id);
	}

	@Override
	public MemberDTO getView(int cookNo) {
		return memberDAO.getView(cookNo);
	}

	@Override
	public int update(MemberDTO dto) {
		return memberDAO.update(dto);
	}

}
