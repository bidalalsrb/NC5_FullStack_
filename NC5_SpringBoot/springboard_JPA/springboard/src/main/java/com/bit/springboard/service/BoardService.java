package com.bit.springboard.service;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.entity.Board;

import java.util.List;

public interface BoardService {
    BoardDTO getBoard(int boardNo);

    List<Board> getBoardList();

    void insertBoard(BoardDTO boardDTO);

    void updateBoard(BoardDTO boardDTO);

    void deleteBoard(int boardNo);
}
