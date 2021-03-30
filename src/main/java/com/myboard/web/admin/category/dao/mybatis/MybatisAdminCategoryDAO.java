package com.myboard.web.admin.category.dao.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.myboard.web.admin.category.dao.AdminCategoryDAO;

public class MybatisAdminCategoryDAO implements AdminCategoryDAO{
	
	private AdminCategoryDAO mapper;
	
	@Autowired
	public MybatisAdminCategoryDAO(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(AdminCategoryDAO.class);
	}

	@Override
	public void insert(String name, String preOrder) {
		mapper.insert(name, preOrder);
	}
	
	@Override
	public void update(String name, String preOrder) {
		mapper.update(name, preOrder);
	}

	@Override
	public int delete(String[] nameArray) {
		return mapper.delete(nameArray);
	}


}
