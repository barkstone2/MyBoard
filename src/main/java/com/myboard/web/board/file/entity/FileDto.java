package com.myboard.web.board.file.entity;

import java.util.Date;

public class FileDto {
	private int no;
	private String filePath;
	private String origFileName;
	private String fileName;
	private Date regDate;
	
	public FileDto() {
	}

	public FileDto(int no, String filePath, String origFileName, String fileName, Date regDate) {
		this.no = no;
		this.filePath = filePath;
		this.origFileName = origFileName;
		this.fileName = fileName;
		this.regDate = regDate;
	}

	public FileDto(String filePath, String origFileName, String fileName) {
		this.filePath = filePath;
		this.origFileName = origFileName;
		this.fileName = fileName;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getOrigFileName() {
		return origFileName;
	}

	public void setOrigFileName(String origFileName) {
		this.origFileName = origFileName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	
}
