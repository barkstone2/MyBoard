package com.myboard.web.board.recommend.entity;

import java.security.Timestamp;

import lombok.Builder;
import lombok.Getter;

@Getter
public class RecommendDTO {
	private int no;
	private int boardNo;
	private int memberNo;
	private String type;
	private Timestamp regDate;
	
	@Builder
	public RecommendDTO(int boardNo, int memberNo, String type) {
		this.boardNo = boardNo;
		this.memberNo = memberNo;
		this.type = type;
	}
	
}
