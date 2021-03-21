package com.myboard.web.member.dao;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.member.entity.MemberDTO;

@Mapper
public interface MemberDAO {

	int insert(MemberDTO dto);

	MemberDTO login(String id, String pwd);

	int loginChk(String id);

	MemberDTO getView(int cookNo);

	int update(MemberDTO dto);

}
