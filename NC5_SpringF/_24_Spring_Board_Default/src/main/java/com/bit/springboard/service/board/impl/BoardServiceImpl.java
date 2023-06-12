package com.bit.springboard.service.board.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.service.board.BoardService;

//ServiceImpl: 비즈니스 로직을 구현하는 클래스
@Service("boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	@Qualifier("boardDAO")
	BoardDAO boardDAO;
	
	//기본게시판이라 비즈니스 로직이 별도로 존재하지 않아서 바로 DAO 객체의 메소드 호출
	@Override
	public void insertBoard(BoardDTO boardDTO) {
		//받아온 데이터 형식을 DB에 맞게 변경해주는 작업이라던지...
		// TODO Auto-generated method stub
		//임의 예외 발생
//		if(boardDTO.getBoardNo() == 0) {
//			throw new IllegalArgumentException("게시글 번호로 0은 입력할 수 없습니다.");
//		}
		
		boardDAO.insertBoard(boardDTO);
	}

	@Override
	public void updateBoard(BoardDTO boardDTO) {
		// TODO Auto-generated method stub
		boardDAO.updateBoard(boardDTO);
	}

	@Override
	public void deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		boardDAO.deleteBoard(boardNo);
	}

	@Override
	public BoardDTO getBoard(int boardNo) {
		// TODO Auto-generated method stub
		return boardDAO.getBoard(boardNo);
	}

	@Override
	public List<BoardDTO> getBoardList(Map<String, String> paramMap) {
		// TODO Auto-generated method stub
		return boardDAO.getBoardList(paramMap);
	}

	@Override
	public void updateBoardCnt(int boardNo) {
		// TODO Auto-generated method stub
		boardDAO.updateBoardCnt(boardNo);
	}


}
