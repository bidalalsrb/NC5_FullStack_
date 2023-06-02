package com.bit.springboard.service;

import java.util.List;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.bit.springboard.dto.BoardDTO;

public class BoardServiceTest {
	public static void main(String[] args) {


		//	1. 스프링 컨테이너 구동
		AbstractApplicationContext factory =
				new GenericXmlApplicationContext("root-context.xml");
		//	2. BoardService 변수의 의존성 검색과 의존성 주입
		BoardService boardService = (BoardService)factory.getBean("boardService");
		//	3. 글 등록 테스트
		BoardDTO boardDTO = new BoardDTO();

		//		글 등록 
		boardDTO.setBOARD_TITLE("test 제목");
		boardDTO.setBOARD_CONTENT("test 내용");
		boardDTO.setBOARD_WRITER("사용자 2");

		boardService.insertBoard(boardDTO);

		//	글 수정 테스트
		BoardDTO updateBoard = new BoardDTO();
		updateBoard.setBOARD_NO(4);
		updateBoard.setBOARD_TITLE("update 제목");
		updateBoard.setBOARD_CONTENT("update 내용");

		boardService.updateBoard(updateBoard);

		//		글 삭제 테스트

		//		boardService.deleteBoard(3);

		//	4. 글 상세 조회 테스트
		BoardDTO returnBoard = boardService.getBoard(1);
		System.out.println(returnBoard);

		//		글 목록 조회
		List<BoardDTO> boardList = boardService.getBoardList();
		for (BoardDTO board : boardList) {
			System.out.println(board);
		}

		//	5. 스프링 컨테이너 종료
		factory.close();

	}
}