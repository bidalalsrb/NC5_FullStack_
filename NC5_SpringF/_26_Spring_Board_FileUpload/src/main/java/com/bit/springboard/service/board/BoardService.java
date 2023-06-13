package com.bit.springboard.service.board;

import java.util.List;
import java.util.Map;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.dto.BoardFileDTO;
import com.bit.springboard.dto.Criteria;

//공지사항, 자유게시판
public interface BoardService {
	//글등록
	void insertBoard(BoardDTO boardDTO, List<BoardFileDTO> boardFileList);
	
	//글수정
	void updateBoard(BoardDTO boardDTO);
	
	//글삭제
	void deleteBoard(int boardNo);
	
	//글 상세 조회
	BoardDTO getBoard(int boardNo);
	
	//글 목록 조회
	//List<BoardDTO> 여러 게시글을 담고있는 List
	List<BoardDTO> getBoardList(Map<String, String> paramMap, Criteria cri);
	
	//조회수 올리기
	void updateBoardCnt(int boardNo);
	
	//게시글 총개수 구하기(검색했을 때도 포함)
	int getBoardTotal(Map<String, String> paramMap);

	List<BoardFileDTO> getBoardFileList(int boardNo);

	BoardFileDTO getBoardFile(BoardFileDTO boardFileDTO);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
