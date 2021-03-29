package com.myboard.web.admin.board.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminBoardDAO {

	int updateCategory(String ctgVal, int[] nos);

	int deletePosts(int[] nos);

}
