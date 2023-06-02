package com.bit.springboard.Service;

import java.util.List;

import com.bit.springboard.dto.BoardDTO;

public interface BoardService {
//	글 등록
	void insertBoard(BoardDTO boardDTO);
	
//	글 수정
	void updateBoard(BoardDTO boardDTO);
	
//	글 삭제
	void deleteBoard(int boardNo);
	
//	글 상세 조회
	BoardDTO getBoard(int boardNo);
	
//	글 목록 조회
//	List<BoardDTO> 여러 게시글을 담고있는 List
	List<BoardDTO> getBoardList();
	
	
}