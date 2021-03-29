package com.myboard.web.admin.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.admin.board.dao.AdminBoardDAO;

@Service
public class AdminBoardServiceImpl implements AdminBoardService{

	@Autowired
	private AdminBoardDAO adminBoardDAO;
	
	@Override
	public int updateCategory(String ctgVal, int[] nos) {
		
		return adminBoardDAO.updateCategory(ctgVal, nos);
	}

	@Override
	public int deletePosts(int[] nos) {
		return adminBoardDAO.deletePosts(nos);
	}

}
