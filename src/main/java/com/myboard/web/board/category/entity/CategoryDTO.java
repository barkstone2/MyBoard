package com.myboard.web.board.category.entity;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class CategoryDTO {
	private int no;
	private String name;
	private Timestamp regDate;
	private int preOrder; 
	
}
