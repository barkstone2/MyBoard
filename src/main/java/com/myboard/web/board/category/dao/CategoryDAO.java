package com.myboard.web.board.category.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.board.category.entity.CategoryDTO;

@Mapper
public interface CategoryDAO {

	List<CategoryDTO> getList(int categoryOffset, int categoryLimit);

	int getTotalCount();

}
