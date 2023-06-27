package com.bit.springboard.controller;

import com.bit.springboard.dto.ResponseDTO;
import com.bit.springboard.dto.UserDTO;
import com.bit.springboard.entity.User;
import com.bit.springboard.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {
    private UserService userService;


    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login-view")
    public ModelAndView loginView() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user/login.html");
        return mv;
    }

    @GetMapping("/join-view")
    public ModelAndView joinView() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("user/join.html");
        return mv;
    }

    @PostMapping("/id-check")
    public ResponseEntity<?> idCheck(UserDTO userDTO) {
        ResponseDTO<Map<String, String>> responseDTO = new ResponseDTO<>();
        try {
            //중복된 아이디인지 체크
            //중복됐으면 해당 아이디에 대한 유저 정보를 담은 user 엔티티가 user 변수에 담김
            //중복되지 않았으면 null이 user 변수에 담김
            User user = userService.idCheck(userDTO.getUserId());

            //메시지를 담을 맵 선언
            Map<String, String> returnMap = new HashMap<>();
            //조건문으로 메시지를 다르게 리턴
            if (user == null) {
                returnMap.put("idCheckMsg", "idOk");
            } else {
                returnMap.put("idCheckMsg", "idFail");
            }
            responseDTO.setItem(returnMap);
            responseDTO.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            responseDTO.setErrorMessage(e.getMessage());
            responseDTO.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(responseDTO);

        }
    }


    //회원가입 처리 후 ModelAndView로 login 페이지로 이동
    @PostMapping("/join")
    public ModelAndView Join(UserDTO userDTO) {
        //화면을 리턴해줄 ModelAndView 객체 생성
        ModelAndView mv = new ModelAndView();

        //JPA로 저장하기 위해 DTO를 Entity로 변환
        //화면에서 사용자가 입력한 내용을 가지고 있는 Entity
        User user = userDTO.DTOToEntity();

        //회원가입처리(화면에서 보여준 내용을 디비에 저장)
        userService.join(user);
        mv.setViewName("user/login.html");
        return mv;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(UserDTO userDTO, HttpSession session) {
        ResponseDTO<Map<String, String>> responseDTO = new ResponseDTO<>();

        try {
            //메시지를 담을 맵 선언
            Map<String, String> returnMap = new HashMap<>();

            //아이디가 존재하면 해당 아이디에 대한 유저정보가 담김
            //아이디가 존재하지 않으면 null이 담김
            User user = userService.idCheck(userDTO.getUserId());

            //1. 아이디가 존재하는 지 체크, 아이디가 없으면 msg에 "notExistId"
            if (user == null) {
                returnMap.put("msg", "notExtistId");
            } else {
                //DB에서 조회해온 password와 사용자가 입력한 password가 다르면
                if (!user.getUserPw().equals(userDTO.getUserPw())) {
                    returnMap.put("msg", "wrongPw");
                } else {
                    returnMap.put("msg", user.getUserId());

                    UserDTO loginUser = user.EntityToDTO();
                    session.setAttribute("loginUser", loginUser);
                }
            }
            responseDTO.setItem(returnMap);
            responseDTO.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            responseDTO.setErrorMessage(e.getMessage());
            responseDTO.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(responseDTO);

        }
    }
}
