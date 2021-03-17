package com.myboard.web.board.entity;

import java.sql.Timestamp;
import java.util.Date;

public class BoardDto {
	private int no;
	private String title;
	private String content;
	private String writer;
	private String pwd;
	private int fileNo;
	private int hit;
	private int like;
	private Date regDate;
	private int memberNo;
	
	public BoardDto() {
	}

	public BoardDto(int no, String title, String content, String writer, String pwd, int fileNo, int hit, int like,
			Timestamp regDate, int memberNo) {
		this.no = no;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.pwd = pwd;
		this.fileNo = fileNo;
		this.hit = hit;
		this.like = like;
		this.regDate = regDate;
		this.memberNo = memberNo;
	}
	
	public BoardDto(String title, String content, String writer, String pwd, int fileNo) {
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.pwd = pwd;
		this.fileNo = fileNo;
	}
	
	public BoardDto(int no, String title, String content, String writer, String pwd, int fileNo) {
		this.no = no;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.pwd = pwd;
		this.fileNo = fileNo;
	}

	public BoardDto(int no, String title, String content, String writer, String pwd) {
		this.no = no;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.pwd = pwd;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	@Override
	public String toString() {
		return "BoardDto [no=" + no + ", title=" + title + ", content=" + content + ", writer=" + writer + ", pwd="
				+ pwd + ", hit=" + hit + ", like=" + like + ", regDate=" + regDate + ", memberNo=" + memberNo + "]";
	}

	
	
}
