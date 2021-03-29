package com.myboard.web.admin.board.dao.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.myboard.web.admin.board.dao.AdminBoardDAO;

public class MybatisAdminBoardDAO implements AdminBoardDAO{
	
	private AdminBoardDAO mapper;
	
	@Autowired
	public MybatisAdminBoardDAO(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(AdminBoardDAO.class);
	}

	@Override
	public int updateCategory(String ctgVal, int[] nos) {
		return mapper.updateCategory(ctgVal, nos);
	}

	@Override
	public int deletePosts(int[] nos) {
		return mapper.deletePosts(nos);
	}
	
	
}
