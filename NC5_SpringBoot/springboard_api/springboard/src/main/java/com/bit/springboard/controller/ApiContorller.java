package com.bit.springboard.controller;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.service.BoardSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController //@Controller + @ResponseBody
@RequestMapping("/api")
public class ApiContorller {


    private BoardSerivce boardSerivce;

    //생성자 주입
    @Autowired
    public ApiContorller(BoardSerivce boardSerivce) {
        this.boardSerivce = boardSerivce;
    }

    @GetMapping("/testApi")
    public Map<String, String> testApi() {
        Map<String, String> returnMap = new HashMap<String, String>();
        returnMap.put("first", "one");
        returnMap.put("second", "two");
        return returnMap;

    }

    @GetMapping("/board")
    public BoardDTO getBoard(int boardNo) {
        return boardSerivce.getBoard(boardNo);
    }
}