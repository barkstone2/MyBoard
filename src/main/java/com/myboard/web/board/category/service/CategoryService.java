package com.myboard.web.board.category.service;

import java.util.List;

public interface CategoryService {

	List<String> getList(int categoryOffset, int categoryLimit);
	List<String> getList();
	int getTotalCount();
	
}
