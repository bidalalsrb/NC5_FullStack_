package com.bit.springboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller

@RequestMapping("/board")

public class BoardController {
	@GetMapping("/getBoardList.do")
	public String join() {
//		userService.join(boardDTO);
		return "board/getBoardList";
	} 
}
