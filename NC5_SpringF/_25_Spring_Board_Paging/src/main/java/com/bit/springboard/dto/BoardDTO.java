package com.bit.springboard.dto;

import java.sql.Date;

public class BoardDTO {
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardWriter;
	private String boardRegdate;
	private int boardCnt;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardRegdate() {
		return boardRegdate;
	}
	public void setBoardRegdate(String boardRegdate) {
		this.boardRegdate = boardRegdate;
	}
	public int getBoardCnt() {
		return boardCnt;
	}
	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", boardWriter=" + boardWriter + ", boardRegdate=" + boardRegdate + ", boardCnt=" + boardCnt + "]";
	}
}
