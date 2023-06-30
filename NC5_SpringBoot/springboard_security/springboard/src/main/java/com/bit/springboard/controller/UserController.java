package com.bit.springboard.controller;

import com.bit.springboard.dto.ResponseDTO;
import com.bit.springboard.dto.UserDTO;
import com.bit.springboard.entity.User;
import com.bit.springboard.service.UserService;
import com.bit.springboard.service.impl.UserDetailsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {
    private UserService userService;

    private PasswordEncoder passwordEncoder;

    //회원정보 수정후 Authentication 객체의 UserDetails를 변경하기 위해
    //loadByUsername 호출
    private UserDetailsServiceImpl userDetailsServiceImpl;

    @Autowired
    public UserController(UserService userService,
                          PasswordEncoder passwordEncoder,
                          UserDetailsServiceImpl userDetailsServiceImpl) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.userDetailsServiceImpl = userDetailsServiceImpl;
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
        ResponseDTO<Map<String, String>> responseDTO =
                            new ResponseDTO<>();

        try {
            //중복된 아이디인지 체크
            //중복됐으면 해당 아이디에 대한 유정 정보를 담은 User엔티티가 user 변수에 담김
            //중복되지 않았으면 null이 user 변수에 담김
            User user = userService.idCheck(userDTO.getUserId());

            //메시지를 담을 맵 선언
            Map<String, String> returnMap = new HashMap<>();

            //조건문으로 메시지를 다르게 리턴
            if(user == null) {
                returnMap.put("idCheckMsg", "idOk");
            } else {
                returnMap.put("idCheckMsg", "idFail");
            }

            responseDTO.setItem(returnMap);
            responseDTO.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(responseDTO);
        } catch(Exception e) {
            responseDTO.setErrorMessage(e.getMessage());
            responseDTO.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(responseDTO);
        }
    }
    
    //회원가입 처리 후 ModelAndView로 login페이지로 이동
    @PostMapping("/join")
    public ModelAndView join(UserDTO userDTO) {
        //화면을 리턴해줄 ModelAndView 객체 생성
        ModelAndView mv = new ModelAndView();

        //JPA로 저장하기 위해 DTO를 Entity로 변환
        //화면에서 사용자가 입력한 내용을 가지고 있는 Entity
        User user = userDTO.DTOToEntity();

        user.setUserPw(
                passwordEncoder.encode(userDTO.getUserPw())
        );
        user.setRole("ROLE_USER");

        //회원가입처리(화면에서 보내준 내용을 디비에 저장)
        userService.join(user);

        mv.setViewName("user/login.html");
        return mv;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(UserDTO userDTO, HttpSession session) {
        ResponseDTO<Map<String, String>> responseDTO =
                new ResponseDTO<>();

        try {
            //메시지를 담을 맵 선언
            Map<String, String> returnMap = new HashMap<>();

            //아이디가 존재하면 해당 아이디에 대한 유저정보가 담김
            //아이디가 존재하지 않으면 null이 담김
            User user = userService.idCheck(userDTO.getUserId());

            //1. 아이디가 존재하는 지 체크, 아이디가 없으면 msg에 "notExistId"
            if(user == null) {
                returnMap.put("msg", "notExistId");
            } else {
                //DB에서 조회해온 password와 사용자가 입력한 password가 다르면
                if(!user.getUserPw().equals(userDTO.getUserPw())) {
                    //2. 비밀번호가 맞는 지 체크, 비밀번호가 틀리면 msg에 "wrongPw"
                    returnMap.put("msg", "wrongPw");
                } else {
                    //3. 다 맞았을 경우 returnMap에 msg로 userId 담기
                    returnMap.put("msg", user.getUserId());

                    UserDTO loginUser = user.EntityToDTO();

                    session.setAttribute("loginUser", loginUser);
                }
            }

            responseDTO.setItem(returnMap);
            responseDTO.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(responseDTO);
        } catch(Exception e) {
            responseDTO.setErrorMessage(e.getMessage());
            responseDTO.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    @GetMapping("/modify-view")
    public ModelAndView modifyView() {
        ModelAndView mv = new ModelAndView();

        mv.setViewName("user/modifyUser.html");
        return mv;
    }

    @PostMapping("/modify")
    public ResponseEntity<?> modify(UserDTO userDTO, HttpSession session) {
        ResponseDTO<Map<String, String>> responseDTO =
                    new ResponseDTO<>();

        try {
            //사용자가 입력한 현재 비밀번호가 맞는 지 검사
            User user = userService.findById(userDTO.getId());

            Map<String, String> returnMap = new HashMap<>();

            if(!passwordEncoder.matches(
                    userDTO.getCurUserPw(), user.getUserPw())) {
                returnMap.put("modifyMsg", "wrongPw");
            } else {
                User modifyUser = null;

                //변경할 비밀번호가 비어있을 때
                if(userDTO.getUserPw() == null ||
                userDTO.getUserPw().equals("")) {
                    modifyUser = User.builder()
                            .id(userDTO.getId())
                            .userId(userDTO.getUserId())
                            .userPw(passwordEncoder.encode(
                                    userDTO.getCurUserPw()
                            ))
                            .userEmail(userDTO.getUserEmail())
                            .userName(userDTO.getUserName())
                            .userTel(userDTO.getUserTel())
                            .userRegdate(LocalDateTime.now())
                            .role("ROLE_USER")
                            .build();
                //변경할 비밀번호가 입력됐을 때
                } else {
                    modifyUser = User.builder()
                            .id(userDTO.getId())
                            .userId(userDTO.getUserId())
                            .userPw(passwordEncoder.encode(
                                    userDTO.getUserPw()
                            ))
                            .userEmail(userDTO.getUserEmail())
                            .userName(userDTO.getUserName())
                            .userTel(userDTO.getUserTel())
                            .userRegdate(LocalDateTime.now())
                            .role("ROLE_USER")
                            .build();
                }

                userService.modify(modifyUser);

                //회원정보 수정 후 세션에 담겨있는 security context의
                //Authentication 객체를 수정된 회원정보로 변경
                
                //수정된 정보를 갖는 UserDetails 객체 생성
                UserDetails userDetails =
                        userDetailsServiceImpl.loadUserByUsername(
                                userDTO.getUserId());

                //변경할 Authentication 객체 생성
                Authentication authentication =
                        new UsernamePasswordAuthenticationToken(
                                userDetails,
                                null,
                                userDetails.getAuthorities()
                        );

                //현재 사용중인 security context 얻기
                SecurityContext securityContext =
                        SecurityContextHolder.getContext();

                //security context에 등록되어 있는 Authentication 객체 바꾸기
                securityContext.setAuthentication(authentication);

                //세션에 있는 시큐리티 컨텍스트 바꾸기
                //현재 세션 받기 1. 리퀘스트에서 받기
                //HttpSession session = request.getSession();

                //현재 세션 받기 2. 메소드의 매개변수로 HttpSession session 선언
                session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

                returnMap.put("modifyMsg", "modifyOk");
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
