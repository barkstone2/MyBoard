package com.myboard.web.admin.category.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.admin.category.dao.AdminCategoryDAO;

@Service
public class AdminCategoryServiceImpl implements AdminCategoryService{

	@Autowired
	private AdminCategoryDAO adminCategoryDAO;
	
	@Override
	public void insert(String name, String preOrder) {
		adminCategoryDAO.insert(name, preOrder);
	}

	@Override
	public void update(String name, String preOrder, String no) {
		adminCategoryDAO.update(name, preOrder, no);
	}

	@Override
	public int delete(String[] nameArray) {
		return adminCategoryDAO.delete(nameArray);
	}

}
