package com.myboard.web.member.dao.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.myboard.web.member.dao.MemberDAO;
import com.myboard.web.member.entity.MemberDTO;

@Component
public class MyBatisMemberDAO implements MemberDAO{

	private MemberDAO mapper;
	
	@Autowired
	public MyBatisMemberDAO(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(MemberDAO.class);
	}
	
	
	@Override
	public int insert(MemberDTO dto) {
		return mapper.insert(dto);
	}


	@Override
	public int login(String id, String pwd) {
		return mapper.login(id, pwd);
	}


	@Override
	public int loginChk(String id) {
		return mapper.loginChk(id);
	}


	@Override
	public MemberDTO getView(int cookNo) {
		return mapper.getView(cookNo);
	}


	@Override
	public int update(MemberDTO dto) {
		return mapper.update(dto);
	}
	
}
