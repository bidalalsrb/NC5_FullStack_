package com.bit.springboard.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.springboard.dto.UserDTO;
import com.bit.springboard.service.user.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller 
//@RestController = @Controller + @ResponseBody 
//									=> Map 리턴 시 자동 json형태로 리턴 
//클래스 자체를 RequestMapping으로 설정하면 폴더 구조로 요청을 지정할 수있다.
//UserController의 요청을 호출할 때는 /user/login.do
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	
	//회원가입 페이지로 이동
	@GetMapping("/join.do")
	public String joinView() {
		//WEB-INF/views/home.jsp
		//WEB-INF/views/user/join.jsp
		return "user/join";
	}
	
	//회원가입 진행
	@PostMapping("/join.do")
	public String join(UserDTO userDTO) {
		//회원가입 처리
		userService.join(userDTO);
		
		return "user/login";
	}
	
	//로그인 화면으로 이동
	@GetMapping("/login.do")
	public String loginView() {
		return "user/login";
	}
	
	//로그인 처리
	@PostMapping("/login.do")
	public String login(UserDTO userDTO, Model model,
			HttpSession session) {
		//아이디가 존재하는 유저인지
		int idCheck = userService.idCheck(userDTO.getUserId());
		
		//아이디가 존재하지 않을때
		if(idCheck < 1) {
			model.addAttribute("message", "idNotExist");
			
			return "user/login";
		} 
		//아이디가 존재할 때
		else {
			//아이디와 비번 모두 비교
			UserDTO loginUser = userService.login(userDTO);
			
			//비번이 틀렸을 때
			if(loginUser == null) {
				model.addAttribute("message", "wrongPw");
				
				return "user/login";
			}
			
			//로그인되면 session에 사용자정보 저장
			//UserDTO형태로 세션에 저장
			session.setAttribute("loginUser", loginUser);
		}
		
		return "redirect:/index.jsp";
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		//세션 강제 만료
		//세션에 저장되어 있는 정보들도 다 삭제된다.
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	@PostMapping("/idCheck.do")
	//String을 리턴하면 ViewResolver를 타서 해당 화면을 찾아서 
	//Response 바디에 HTML화면을 리턴
	//화면에서 리턴되는 값만 받아서 쓰고 싶을 때는 리턴값을 Response 바디에 넣어서 리턴
	//@ResponseBody: 리턴 값을 response 바디에 담아서 전송, 
	//				 viewresolver도 실행되지 않음 
	@ResponseBody
	public String idCheck(UserDTO userDTO) throws JsonProcessingException {
		int idCheck = userService.idCheck(userDTO.getUserId());
		
		//중복된 아이디일 때
//		if(idCheck > 0) {
//			return "duplicatedId";
//		}
//		
//		//중복되지 않은 아이디일 때
//		return "idOk";
		
		//json 형태의 데이터 만들어서 리턴
		//자주 사용되는 방식1: jsonView
		//자주 사용되는 방식2: objectMapper
		
		//ObjectMapper 객체 사용해서 json 형태의 데이터 리턴
		ObjectMapper mapper = new ObjectMapper();
		
		//Map이 Json의 형태와 같은 key, value형식의 데이터기 때문에 
		//Map을 이용하여 json 데이터를 구성한다.
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		if(idCheck > 0) {
			jsonMap.put("msg", "duplicatedId");
		} else {
			jsonMap.put("msg", "idOk");
		}
		
		//Map을 json 형태의 데이터로 만든 후 스트링으로 변환
		//writerWithDefaultPrettyPrinter(): Map을 json데이터 형태로 만들어준다.
		//                                  엔터값과 들여쓰기를 추가해줌
		//writeValueAsString(jsonMap): json데이터를 String으로 변환
		String jsonStr = mapper.writerWithDefaultPrettyPrinter()
							   .writeValueAsString(jsonMap);
		
		return jsonStr;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
