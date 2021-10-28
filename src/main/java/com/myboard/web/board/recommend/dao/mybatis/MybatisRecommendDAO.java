package com.myboard.web.board.recommend.dao.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.myboard.web.board.recommend.dao.RecommendDAO;
import com.myboard.web.board.recommend.entity.RecommendDTO;

@Component
public class MybatisRecommendDAO implements RecommendDAO{
	
	private RecommendDAO mapper;
	
	@Autowired
	public MybatisRecommendDAO(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(RecommendDAO.class);
	}
	
	@Override
	public int checkLike(int boardNo, int memberNo) {
		return mapper.checkLike(boardNo, memberNo);
	}

	@Override
	public int checkDisLike(int boardNo, int memberNo) {
		return mapper.checkDisLike(boardNo, memberNo);
	}

	@Override
	public int insert(RecommendDTO dto) {
		return mapper.insert(dto);
	}

}
