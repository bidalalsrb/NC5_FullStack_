package com.bit.springboard.controller;


import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.dto.ResponseDTO;
import com.bit.springboard.entity.Board;
import com.bit.springboard.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/board")
public class BoardController {
    private BoardService boardService;

    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @GetMapping("/board-list")
    public ResponseEntity<?> BoardController() {
        ResponseDTO<BoardDTO> responseDTO = new ResponseDTO<BoardDTO>();
        try {
            List<Board> boardList = boardService.getBoardList();

            List<BoardDTO> boardDTOList = new ArrayList<BoardDTO>();
            for (Board b : boardList) {
                BoardDTO returnBoardDTO = BoardDTO.builder()
                        .boardNo(b.getBoardNo())
                        .boardTitle(b.getBoardTitle())
                        .boardContent(b.getBoardContent())
                        .boardWriter(b.getBoardTitle())
                        .boardRegDate(b.getBoardRegDate().toString())
                        .boardCnt(b.getBoardCnt())
                        .build();
                boardDTOList.add(returnBoardDTO);
            }
            responseDTO.setItems(boardDTOList);

            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            responseDTO.setStatusCode(HttpStatus.BAD_REQUEST.value());
            responseDTO.setErrorMessage(e.getMessage());
            return ResponseEntity.badRequest().body(responseDTO);
        }

    }

}
