package com.myboard.web.member.service;

import com.myboard.web.member.entity.MemberDTO;

public interface MemberService {

	int insert(MemberDTO dto);

	MemberDTO login(String id, String pwd);

	int loginChk(String id);

	MemberDTO getView(int cookNo);

	int update(MemberDTO dto);

}
