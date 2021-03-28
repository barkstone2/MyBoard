package com.myboard.web.board.category.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CategoryDAO {

	List<String> getList(int categoryOffset, int categoryLimit);

	int getTotalCount();

}
