package com.myboard.web.board.category.dao.mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.myboard.web.board.category.dao.CategoryDAO;

public class MybatisCategoryDAO implements CategoryDAO{
	
	private CategoryDAO mapper;
	
	public MybatisCategoryDAO(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(CategoryDAO.class);
	}
	
	@Override
	public List<String> getList(int categoryOffset, int categoryLimit) {
		return mapper.getList(categoryOffset, categoryLimit);
	}

	@Override
	public int getTotalCount() {
		return mapper.getTotalCount();
	}
	
}
