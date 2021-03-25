package com.myboard.web.board.recommend.dao;

import org.apache.ibatis.annotations.Mapper;

import com.myboard.web.board.recommend.entity.RecommendDTO;

@Mapper
public interface RecommendDAO {
	int checkLike(int boardNo, int memberNo);
	int checkDisLike(int boardNo, int memberNo);
	int insert(RecommendDTO dto);
}
