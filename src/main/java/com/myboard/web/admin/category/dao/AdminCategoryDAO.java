package com.myboard.web.admin.category.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminCategoryDAO {

	void update(String name, String preOrder);

	void insert(String name, String preOrder);

	int delete(String[] nameArray);

	
}
