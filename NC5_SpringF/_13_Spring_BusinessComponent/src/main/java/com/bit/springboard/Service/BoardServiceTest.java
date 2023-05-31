package com.bit.springboard.Service;

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


		//	boardDTO.setBOARD_TITLE("test 제목");
		//	boardDTO.setBOARD_CONTENT("test 내용");
		//	boardDTO.setBOARD_WRITER("관리자");
		//	
		//	boardService.insertBoard(boardDTO);

		//		boardService.getBoard(1);

		//	4. 글 상세 조회 테스트
		BoardDTO returnBoard = boardService.getBoard(1);
		System.out.println(returnBoard);
		//	5. 스프링 컨테이너 종료
		factory.close();

	}
}