package com.myboard.web.board.entity;

import java.sql.Timestamp;

public class BoardViewDTO extends BoardDTO{
	
	/*
	  	boardView
		create or replace view boardView
		as
		select a.*, (select count(*) from comment where a.no=boardNo) commentCount
		from board a
		order by regDate desc;
	*/
	private int commentCount;
	
	public BoardViewDTO() {
	}

	public BoardViewDTO(int no, String title, String content, String writer, String pwd, int fileNo, int hit, int like,
			Timestamp regDate, int memberNo, int commentCount) {
		super(no, title, content, writer, pwd, fileNo, hit, like, regDate, memberNo);
		this.commentCount = commentCount;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	
}
