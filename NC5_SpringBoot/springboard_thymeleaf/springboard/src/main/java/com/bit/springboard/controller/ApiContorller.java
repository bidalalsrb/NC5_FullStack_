package com.bit.springboard.controller;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.dto.ResponseDTO;
import com.bit.springboard.service.BoardService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController //@Controller + @ResponseBody
@RequestMapping("/api")
public class ApiContorller {
    private BoardService boardService;

    //생성자 주입
    @Autowired
    public ApiContorller(BoardService boardService) {
        this.boardService = boardService;
    }

    @GetMapping("/testApi")
    public Map<String, String> testApi() {
        Map<String, String> returnMap = new HashMap<String, String>();

        returnMap.put("first", "one");
        returnMap.put("second", "two");

        return returnMap;
    }

    @GetMapping("/board")
    public ResponseEntity<?> getBoard(int boardNo) {
        ResponseDTO<BoardDTO> responseDTO =
                new ResponseDTO<BoardDTO>();
        try {
            responseDTO.setItem(boardService.getBoard(boardNo));

            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            responseDTO.setErrorMessage(e.getMessage());

            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    //글 등록
    @PostMapping("/board")
    public ResponseEntity<?> insertBoard(BoardDTO boardDTO) {
        ResponseDTO<Map<String, Object>> responseDTO
                = new ResponseDTO<Map<String, Object>>();

        try {
            Map<String, Object> returnMap =
                    new HashMap<String, Object>();

            returnMap.put("msg", "정상적으로 입력되었습니다.");

            responseDTO.setItem(returnMap);

            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            responseDTO.setErrorMessage(e.getMessage());

            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    //글수정
    @PutMapping("/board")
    public ResponseEntity<?> updateBoard(BoardDTO boardDTO) {
        ResponseDTO<Map<String, Object>> responseDTO
                = new ResponseDTO<Map<String, Object>>();
        try {
            boardService.updateBoard(boardDTO);
            Map<String, Object> returnMap = new HashMap<String, Object>();
            returnMap.put("msg", "게시판 항목이 성공적으로 수정되었습니다.");
            responseDTO.setItem(returnMap);
            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            responseDTO.setErrorMessage(e.getMessage());

            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    //글삭제
    @DeleteMapping("/board")
    public ResponseEntity<?> deleteBoard(int boardNo) {
        ResponseDTO<Map<String, Object>> responseDTO
                = new ResponseDTO<Map<String, Object>>();
        try {
            boardService.deleteBoard(boardNo);

            Map<String, Object> returnMap = new HashMap<String, Object>();
            returnMap.put("msg", "게시판 항목이 성공적으로 삭제되었습니다.");
            responseDTO.setItem(returnMap);
            return ResponseEntity.ok(responseDTO);
        } catch (Exception e) {
            responseDTO.setErrorMessage(e.getMessage         ());
            return ResponseEntity.badRequest().body(responseDTO);
        }

    }

    @GetMapping("/board-list")
    public List<BoardDTO> getBoardList() {
        return boardService.getBoardList();
    }

    @GetMapping("testApi2")
    public Map<String, Object> testApi2(int boardNo) {
        Map<String, Object> returnMap = new HashMap<String, Object>();

        returnMap.put("board", boardService.getBoard(boardNo));
        returnMap.put("boardList", boardService.getBoardList());
        List<Integer> intList = new ArrayList<Integer>();

        for (int i = 0; i < 100; i++) {
            intList.add(i);
        }
        returnMap.put("intList", intList);

        return returnMap;
    }

    //ResponseEntity를 이용한 RESTful API
    //응답코드, 에러메시지 등을 전송해주는 객체
    //응답 바디에 전송할 데이터도 추가할 수 있다.
    @GetMapping("/restfulapi")
    public ResponseEntity<?> restFulApi(int boardNo, HttpServletResponse response) {
        ResponseDTO<Map<String, Object>> responseDTO =
                new ResponseDTO<Map<String, Object>>();
        try {
            Map<String, Object> returnMap = new HashMap<String, Object>();

            returnMap.put("board", boardService.getBoard(boardNo));
            returnMap.put("boardList", boardService.getBoardList());
            List<Integer> intList = new ArrayList<Integer>();

            for (int i = 0; i < 100; i++) {
                intList.add(i);
            }
            returnMap.put("intList", intList);

            //응답 데이터
            responseDTO.setItem(returnMap);
            //요청 상태코드
            responseDTO.setStatusCode(response.getStatus());
            //request status code == 200일때(정상)
            //요청이 정상적으로 끝나면 응답 데이터와 요청 상태코드를 갖는
            //객체를 응답으로 보내줌
            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            //요청 상태코드
            responseDTO.setStatusCode(response.getStatus());
            //에러가 발생하면 응답데이터 대신 에러메시지를 전송한다.
            responseDTO.setErrorMessage(e.getMessage());
            return ResponseEntity.badRequest().body(responseDTO);
        }
    }


}
