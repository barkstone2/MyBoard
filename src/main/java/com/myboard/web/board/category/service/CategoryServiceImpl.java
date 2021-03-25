package com.myboard.web.board.category.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.board.category.dao.CategoryDAO;

@Service
public class CategoryServiceImpl implements CategoryService{

	@Autowired
	private CategoryDAO categoryDAO;
	
	@Override
	public List<String> getList() {
		
		return categoryDAO.getList();
	}

}
