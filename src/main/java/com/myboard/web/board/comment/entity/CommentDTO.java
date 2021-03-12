package com.myboard.web.board.comment.entity;

import java.sql.Timestamp;

public class CommentDTO {
	private int no;
	private String content;
	private String writer;
	private String pwd;
	private int groupNo;
	private int memberNo;
	private int boardNo;
	private Timestamp regDate;
	
	public CommentDTO() {
	}

	public CommentDTO(String content, String writer, String pwd, int groupNo, int memberNo, int boardNo) {
		this.content = content;
		this.writer = writer;
		this.pwd = pwd;
		this.groupNo = groupNo;
		this.memberNo = memberNo;
		this.boardNo = boardNo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "CommentDTO [no=" + no + ", content=" + content + ", writer=" + writer + ", pwd=" + pwd + ", groupNo="
				+ groupNo + ", memberNo=" + memberNo + ", boardNo=" + boardNo + ", regDate=" + regDate + "]";
	}
	
	
}
