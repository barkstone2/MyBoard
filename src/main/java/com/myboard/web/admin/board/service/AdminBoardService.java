package com.myboard.web.admin.board.service;

public interface AdminBoardService {

	int updateCategory(String ctgVal, int[] nos);

	int deletePosts(int[] nos);

}
