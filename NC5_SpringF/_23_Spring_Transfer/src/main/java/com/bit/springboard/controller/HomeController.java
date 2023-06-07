package com.bit.springboard.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.springboard.dto.NameDTO;

@Controller
public class HomeController {
	//	요청 url 매핑
	//	요청이 오면 아래의 메소드 실행
	@GetMapping("/")
	public String home() {
		//		viewresolver을 통해서 /web-info/views/home.jsp 파일이 리턴
		return "home";
	}
	// 화면단에서 전송한 데이터 받기
	//	1. @RequestParam 이용하기

	@GetMapping("test.do")
	public String testGet(@RequestParam("name") String name
			, @RequestParam("tel") String tel) {
		System.out.println("이름 : " + name);
		System.out.println("번호 : " + tel);
		return "home";
	}

	@PostMapping("test.do")
	public String testUpdate(@RequestParam("name") String name
			, @RequestParam("tel") String tel) {
		System.out.println("Post 메소드 실행");

		System.out.println("이름 : " + name);
		System.out.println("번호 : "  + tel);
		return "home";
	}
	
//	2. @RequsetParam으로 Map에 할당
	@GetMapping("test2.do")
	public String test2Get(@RequestParam Map<String, Object> paramMap) {
		System.out.println(paramMap.get("name") 
				+ " :  " + paramMap.get("tel"));
		
		
		return "home";
	}
	
//	3. Command 객체로 데이터 받기
	@GetMapping("test3.do")
	public String test3Get(NameDTO nameDTO, Model model) {
		System.out.println(nameDTO.getName() + ": " + nameDTO.getTel()) ;
		
//		4. Model 객체로 화면단에 데이터 전송
		model.addAttribute("nm","홍길동");
		model.addAttribute("telNum","01112323123");
		return "home";
	}
	
	
	
	
}
