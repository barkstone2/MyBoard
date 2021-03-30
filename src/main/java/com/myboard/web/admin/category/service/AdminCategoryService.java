package com.myboard.web.admin.category.service;

public interface AdminCategoryService {

	void insert(String name, String preOrder);
	void update(String name, String preOrder);
	int delete(String[] nameArray);
	
}
