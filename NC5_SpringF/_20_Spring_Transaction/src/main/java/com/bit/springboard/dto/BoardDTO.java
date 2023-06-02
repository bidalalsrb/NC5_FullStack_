package com.bit.springboard.dto;

import java.sql.Date;

public class BoardDTO {
	private int BOARD_NO;
	private String BOARD_TITLE;
	private String BOARD_CONTENT;
	private String BOARD_WRITER;
	private Date BOARD_REGDATE ;
	private int BOARD_CNT;
	public int getBOARD_NO() {
		return BOARD_NO;
	}
	public void setBOARD_NO(int bOARD_NO) {
		BOARD_NO = bOARD_NO;
	}
	public String getBOARD_TITLE() {
		return BOARD_TITLE;
	}
	public void setBOARD_TITLE(String bOARD_TITLE) {
		BOARD_TITLE = bOARD_TITLE;
	}
	public String getBOARD_CONTENT() {
		return BOARD_CONTENT;
	}
	public void setBOARD_CONTENT(String bOARD_CONTENT) {
		BOARD_CONTENT = bOARD_CONTENT;
	}
	public String getBOARD_WRITER() {
		return BOARD_WRITER;
	}
	public void setBOARD_WRITER(String bOARD_WRITER) {
		BOARD_WRITER = bOARD_WRITER;
	}
	public Date getBOARD_REGDATE() {
		return BOARD_REGDATE;
	}
	public void setBOARD_REGDATE(Date bOARD_REGDATE) {
		BOARD_REGDATE = bOARD_REGDATE;
	}
	public int getBOARD_CNT() {
		return BOARD_CNT;
	}
	public void setBOARD_CNT(int bOARD_CNT) {
		BOARD_CNT = bOARD_CNT;
	}
	@Override
	public String toString() {
		return "BoardDTO [BOARD_NO=" + BOARD_NO + ", BOARD_TITLE=" + BOARD_TITLE + ", BOARD_CONTENT=" + BOARD_CONTENT
				+ ", BOARD_WRITER=" + BOARD_WRITER + ", BOARD_REGDATE=" + BOARD_REGDATE + ", BOARD_CNT=" + BOARD_CNT + "]";
	}


}



