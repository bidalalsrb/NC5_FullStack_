package com.bit.springboard.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.springboard.dto.BoardDTO;
import com.bit.springboard.dto.NameDTO;
import com.bit.springboard.service.board.BoardService;
import com.bit.springboard.service.name.NameService;


//@Controller = @Component + Servlet
@Controller
public class HomeController {
	@Autowired
	private BoardService boardService;

	@Autowired
	private NameService nameService;

	//요청url 매핑
	// /test.do 요청이 오면 아래의 메소드 실행
	//method지정 안하면 get/post 모두 해당 메소드 실행
	@GetMapping("/")
	public String home() {
		//viewresolver를 통해서 /WEB-INF/views/home.jsp 파일이 리턴
		return "home";
	}

	//화면단에서 전송한 데이터 받기
	//1. @RequestParam 이용하기
	@GetMapping("test.do")
	public String testGet(
			@RequestParam("name") String name,
			@RequestParam("tel") String tel) {
		System.out.println("이름: " + name);
		System.out.println("번호: " + tel);
		return "home";
	}

	@PostMapping("test.do")
	public String testPost(
			@RequestParam("name") String name,
			@RequestParam("tel") String tel) {
		System.out.println("POST 메소드 실행----------");
		System.out.println("이름: " + name);
		System.out.println("번호: " + tel);
		return "home";
	}

	//2. @RequestParam으로 Map에 할당
	@GetMapping("test2.do")
	public String test2Get(
			@RequestParam Map<String, Object> paramMap) {
		System.out.println(paramMap.get("name") 
				+ ": " + paramMap.get("tel"));

		return "home";
	}

	//3. Command 객체로 데이터 받기
	@GetMapping("test3.do")
	public String test3Get(NameDTO nameDTO, 
			Model model,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) {
		System.out.println(nameDTO.getName() + ": " 
				+ nameDTO.getTel());
		//자바에서 화면으로 데이터 전송
		//4. Model 객체로 화면단에 데이터 전송
		//		model.addAttribute("nm", "홍길동");
		//		model.addAttribute("telNum", "01011111111");

		//5. HttpServletRequest 객체 이용
		//		request.setAttribute("nm", "임꺽정");
		//		request.setAttribute("telNum", "01022222222");

		//6. HttpSession 객체 이용
		//		session.setAttribute("nm", "장길산");
		//		session.setAttribute("telNum", "01033333333");

		//7. value에 list, map, set 등 컬렉션이나 어떠한 값도 담을 수 있다.
		//model, request, session 공통
		//		List<Integer> intList = new ArrayList<Integer>();
		//		
		//		for(int i = 1; i <= 10; i++) {
		//			intList.add(i);
		//		}
		//		
		//		model.addAttribute("intList", intList);

		//8. 게시판 목록 화면에 표출
		List<BoardDTO> boardList = boardService.getBoardList();

		model.addAttribute("boardList", boardList);

		return "home";
	}

	@PostMapping("insertName.do")
	public String insertName(NameDTO nameDTO , Model model) {
		//nameService에는  NameServiceImpl 객체가 담겨있기 때문에
		//NameServiceImpl의 insertName이 실행
		nameService.insertName(nameDTO);

//		model.addAttribute("nameList",nameService.getNameList());
		
//		redirect 다른 요청을 호출함
		return "redirect:/getNameList.do";
	}

	@GetMapping("getNameList.do")
	public String getNameList(Model model) {
		model.addAttribute("nameList",nameService.getNameList());
		return "home";	
	}







}
