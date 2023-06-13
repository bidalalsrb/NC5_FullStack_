package com.bit.springboard.dto;

public class BoardFileDTO {
	private int boardNo;
	private int boardFileNo;
	private String boardFileName;
	private String boardFilePath;
	private String boardFileOrigin;
	
	public int getBoardNO() {
		return boardNo;
	}
	public void setBoardNO(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getBoardFileNo() {
		return boardFileNo;
	}
	public void setBoardFileNo(int boardFileNo) {
		this.boardFileNo = boardFileNo;
	}
	public String getBoardFileName() {
		return boardFileName;
	}
	public void setBoardFileName(String boardFileName) {
		this.boardFileName = boardFileName;
	}
	public String getBoardFilePath() {
		return boardFilePath;
	}
	public void setBoardFilePath(String boardFilePath) {
		this.boardFilePath = boardFilePath;
	}
	public String getBoardFileOrigin() {
		return boardFileOrigin;
	}
	public void setBoardFileOrigin(String boardFileOrigin) {
		this.boardFileOrigin = boardFileOrigin;
	}
	@Override
	public String toString() {
		return "BoardFileDTO [boardNO=" + boardNo + ", boardFileNo=" + boardFileNo + ", boardFileName=" + boardFileName
				+ ", boardFilePath=" + boardFilePath + ", boardFileOrigin=" + boardFileOrigin + "]";
	}

}
