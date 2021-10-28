package com.myboard.web.member.entity;

import java.sql.Timestamp;

public class MemberDTO {
	private int no;
	private String id;
	private String pwd;
	private String nickName;
	private String email;
	private Timestamp regDate;
	
	public MemberDTO() {
	}

	public MemberDTO(int no, String id, String pwd, String nickName, String email, Timestamp regDate) {
		this.no = no;
		this.id = id;
		this.pwd = pwd;
		this.nickName = nickName;
		this.email = email;
		this.regDate = regDate;
	}

	public MemberDTO(String id, String pwd, String nickName, String email) {
		this.id = id;
		this.pwd = pwd;
		this.nickName = nickName;
		this.email = email;
	}
	
	public MemberDTO(int no, String pwd, String nickName, String email) {
		this.no = no;
		this.pwd = pwd;
		this.nickName = nickName;
		this.email = email;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	
}
