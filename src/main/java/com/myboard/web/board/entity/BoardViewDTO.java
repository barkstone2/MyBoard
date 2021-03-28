package com.myboard.web.board.entity;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class BoardViewDTO extends BoardDTO{
	
	private int commentCount;
	
	public BoardViewDTO(int no, String title, String content, String writer, String pwd, int fileNo, int hit, int like,
			int disLike, Timestamp regDate, int memberNo, int commentCount, String category) {
		super.builder()
		.no(memberNo)
		.title(title)
		.content(content)
		.writer(writer)
		.pwd(pwd)
		.fileNo(fileNo)
		.hit(hit)
		.like(like)
		.disLike(disLike)
		.regDate(regDate)
		.memberNo(memberNo)
		.category(category).build();
		
		this.commentCount = commentCount;
	}
	
}
