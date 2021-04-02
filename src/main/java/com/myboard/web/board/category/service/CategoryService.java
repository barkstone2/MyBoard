package com.myboard.web.board.category.service;

import java.util.List;

import com.myboard.web.board.category.entity.CategoryDTO;

public interface CategoryService {

	List<CategoryDTO> getList(int categoryOffset, int categoryLimit);
	List<CategoryDTO> getList();
	int getTotalCount();
	
}
