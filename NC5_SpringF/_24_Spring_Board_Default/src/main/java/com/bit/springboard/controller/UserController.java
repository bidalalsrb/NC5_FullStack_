package com.bit.springboard.controller;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.jni.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.springboard.dto.UserDTO;
import com.bit.springboard.service.board.BoardService;
import com.bit.springboard.service.user.UserService;

@Controller
//클래스 자체를 RequestMapping으로 설정하면 폴더 구조로 요청을 지정할 수 있다.
//UserController의 요청을 호출할 때는 /user/login.do
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	//	회원가입 페이지로 이동
	@GetMapping("/join.do")
	public String joinView() {
		//		WEB-INF/views/home.jsp
		return "user/join";
	}
	@GetMapping("/login.do")
	public String loginView() {
		//		WEB-INF/views/home.jsp
		return "user/login";

	}
	@PostMapping("/join.do")
	public String join(UserDTO userDTO) {
		userService.join(userDTO);
		return "user/login";
	} 

	@PostMapping("/login.do")
	public String login(UserDTO userDTO, Model model, HttpSession session) {
		int idCheck = userService.idCheck(userDTO.getUserId());

		//		아이디가 존재하지 않을 때
		if (idCheck<1) {
			model.addAttribute("message","idNotExist");
			return "user/login";
		}
		//		아이디가 존재할 때
		else {
			UserDTO loginUser = userService.login(userDTO);
			//			비번이 틀렸을 때			
			if (loginUser == null) {
				model.addAttribute("message","wrongPw");
				return "user/login";
			}
			//			로그인되면 session에 사용자 정보 저장
			session.setAttribute("loginUser", loginUser);
		}
 
		return "redirect:/index.jsp";
	}

}
