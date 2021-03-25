package com.myboard.web.board.recommend.service;

import com.myboard.web.board.recommend.entity.RecommendDTO;

public interface RecommendService {
	int checkLike(int boardNo, int memberNo);

	int checkDisLike(int boardNo, int memberNo);

	int insert(RecommendDTO dto);
}
