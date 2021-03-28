package com.myboard.web.board.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@NoArgsConstructor
@ToString
@Builder
@AllArgsConstructor
public class BoardDTO {
	private int no;
	private String title;
	private String content;
	private String writer;
	private String pwd;
	private int fileNo;
	private int hit;
	private int like;
	private int disLike;
	private Date regDate;
	private int memberNo;
	private String category;
	
}
