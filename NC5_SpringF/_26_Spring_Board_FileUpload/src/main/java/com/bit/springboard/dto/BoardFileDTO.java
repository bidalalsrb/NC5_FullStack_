package com.bit.springboard.dto;

public class BoardFileDTO {
	private int boardNo;
	private int boardFileNo;
	private String boardFileName;
	private String boardFilePath;
	private String boardFileOrigin;
	//이미지인지 아닌지 구분하는 변수
	private String boardFileCate;
	//파일이 변경, 삭제, 추가됐는지 구분해줄 변수
	private String boardFileStatus;
	//파일이 변경됐을 때 변경된 파일명을 저장할 변수
	private String newFileName;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
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
	public String getBoardFileCate() {
		return boardFileCate;
	}
	public void setBoardFileCate(String boardFileCate) {
		this.boardFileCate = boardFileCate;
	}
	public String getBoardFileStatus() {
		return boardFileStatus;
	}
	public void setBoardFileStatus(String boardFileStatus) {
		this.boardFileStatus = boardFileStatus;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}
	
	@Override
	public String toString() {
		return "BoardFileDTO [boardNo=" + boardNo + ", boardFileNo=" + boardFileNo + ", boardFileName=" + boardFileName
				+ ", boardFilePath=" + boardFilePath + ", boardFileOrigin=" + boardFileOrigin + "]";
	}
}
