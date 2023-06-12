package com.bit.springboard.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.dto.Criteria;
import com.bit.springboard.dto.PageDTO;
import com.bit.springboard.dto.UserDTO;
import com.bit.springboard.service.board.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	//post,get 요청 모두 받아서 실
	@RequestMapping("/getBoardList.do")
	public String getBoardList(Model model,
			@RequestParam Map<String, String> paramMap,
			Criteria cri) {
		//화면을 표출하면서 바로 데이터 출력
		model.addAttribute("boardList", boardService.getBoardList(paramMap, cri));
		
		//검색조건, 검색어 화면단으로 다시 전달
		if(paramMap.get("searchCondition") != null && 
				!paramMap.get("searchCondition").equals("")) {
			model.addAttribute("searchCondition", 
					paramMap.get("searchCondition"));
		}
		
		if(paramMap.get("searchKeyword") != null && 
				!paramMap.get("searchKeyword").equals("")) {
			model.addAttribute("searchKeyword", 
					paramMap.get("searchKeyword"));
		}
		
		//총 게시글의 개수 구하기
		int boardTotal = boardService.getBoardTotal(paramMap);
		
		model.addAttribute("pageDTO", new PageDTO(cri, boardTotal));
		
		return "board/getBoardList";
	}
	
	//새 글 등록 화면으로 이동(get방식)
	@GetMapping("insertBoard.do")
	public String insertBoardView(HttpSession session) {
		//로그인 된 정보가 없으면 로그인 화면으로 이동
		//세션에 담겨있는 사용자 정보 조회
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			return "redirect:/user/login.do";
		}
		
		return "board/insertBoard";
	}
	
	//새 글 등록 처리(post방식)
	//등록 완료후 게시글 목록으로 이동
	@PostMapping("/insertBoard.do")
	public String insertBoard(BoardDTO boardDTO) {
		boardService.insertBoard(boardDTO);
		
		return "redirect:/board/getBoardList.do";
	}
	
	//조회수 올리기
	@GetMapping("/updateBoardCnt.do")
	public String updateBoardCnt(@RequestParam("boardNo") int boardNo) {
		//조회수 올리기
		boardService.updateBoardCnt(boardNo);
		
		return "redirect:/board/getBoard.do?boardNo=" + boardNo;
	}
	
	@GetMapping("/getBoard.do")
	public String getBoard(@RequestParam("boardNo") int boardNo,
			Model model) {
		model.addAttribute("board", boardService.getBoard(boardNo));
		
		return "board/getBoard";
	}
	
	@PostMapping("/updateBoard.do")
	public String updateBoard(BoardDTO boardDTO) {
		boardService.updateBoard(boardDTO);
		
		//return "redirect:/board/getBoardList.do";
		return "redirect:/board/getBoard.do?boardNo=" + boardDTO.getBoardNo();
	}
	
	//getBoardListAjax 화면으로 이동
	@GetMapping("/getBoardListAjax.do")
	public String getBoardListAjaxView() {
		return "board/getBoardListAjax";
	}
	
	//게시글 목록 json string으로 리턴
//	@PostMapping(value="/getBoardListAjax.do", 
//			produces="application/text; charset=UTF-8")
//	//리턴된 데이터만 response body로 전송
//	@ResponseBody
//	public String getBoardListAjax() throws JsonProcessingException {
//		//json string을 생성하기 위한 ObjectMapper 객체 생성
//		ObjectMapper objectMapper = new ObjectMapper();
//		
//		//json 데이터 형식을 만들기 위한 Map생성
//		Map<String, Object> jsonMap = new HashMap<String, Object>();
//		
//		//jsonMap에 담아줄 게시글 목록 조회
//		List<BoardDTO> boardList = boardService.getBoardList();
//		
//		//게시글 목록 jsonMap에 담기
//		jsonMap.put("boardList", boardList);
//		
//		//jsonMap을 jsonString으로 변경
//		String jsonStr = objectMapper.writerWithDefaultPrettyPrinter()
//									 .writeValueAsString(jsonMap);
//		
//		//변환된 jsonStr 리턴
//		return jsonStr;
//	}
	
	@GetMapping("/deleteBoard.do")
	public String deleteBoard(@RequestParam("boardNo") int boardNo) {
		boardService.deleteBoard(boardNo);
		
		return "redirect:/board/getBoardList.do";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
