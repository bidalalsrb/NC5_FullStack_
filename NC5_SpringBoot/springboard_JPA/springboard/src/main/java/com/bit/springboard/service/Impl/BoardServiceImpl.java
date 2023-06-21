package com.bit.springboard.service.Impl;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.entity.Board;
import com.bit.springboard.mapper.BoardMapper;
import com.bit.springboard.repository.BoardRepository;
import com.bit.springboard.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {
    private BoardMapper boardMapper;


    private BoardRepository boardRepository;

    //생성자 주입
    @Autowired
    public BoardServiceImpl(BoardMapper boardMapper, BoardRepository boardRepository) {
        this.boardMapper = boardMapper;
        this.boardRepository = boardRepository;
    }

    @Override
    public BoardDTO getBoard(int boardNo) {
        return boardMapper.getBoard(boardNo);
    }

    @Override
    public List<Board> getBoardList() {
        return boardRepository.findAll();
    }

    @Override
    public void insertBoard(BoardDTO boardDTO) {
        boardMapper.insertBoard(boardDTO);
    }

    @Override
    public void updateBoard(BoardDTO boardDTO) {
        boardMapper.updateBoard(boardDTO);
    }

    @Override
    public void deleteBoard(int boardNo) {
        boardMapper.deleteBoard(boardNo);
    }
}
