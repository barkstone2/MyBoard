package com.myboard.web.board.recommend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.web.board.recommend.dao.RecommendDAO;
import com.myboard.web.board.recommend.entity.RecommendDTO;

@Service
public class RecommendServiceImpl implements RecommendService{
	
	@Autowired
	private RecommendDAO recommendDAO;
	
	@Override
	public int checkLike(int boardNo, int memberNo) {
		return recommendDAO.checkLike(boardNo, memberNo);
	}

	@Override
	public int checkDisLike(int boardNo, int memberNo) {
		return recommendDAO.checkDisLike(boardNo, memberNo);
	}

	@Override
	public int insert(RecommendDTO dto) {
		return recommendDAO.insert(dto);
	}

}
