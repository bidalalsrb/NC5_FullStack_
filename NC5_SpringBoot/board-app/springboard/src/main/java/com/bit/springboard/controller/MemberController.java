package com.bit.todobootapp.controller;

import com.bit.todobootapp.dto.MemberDTO;
import com.bit.todobootapp.dto.ResponseDTO;
import com.bit.todobootapp.entity.Member;
import com.bit.todobootapp.jwt.JwtTokenProvider;
import com.bit.todobootapp.service.MemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/member")
public class MemberController {
    private final MemberService memberService;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    public MemberController(MemberService memberService, JwtTokenProvider jwtTokenProvider,
                            PasswordEncoder passwordEncoder) {
        this.memberService = memberService;
        this.jwtTokenProvider = jwtTokenProvider;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/join")
    public ResponseEntity<?> join(@RequestBody Member member) {
        ResponseDTO<MemberDTO> response = new ResponseDTO<>();

        try {
            //비밀번호 암호화
            member.setPassword(passwordEncoder.encode(member.getPassword()));
            //회원가입(MemberEntity 리턴하도록)
            Member joinMember = memberService.join(member);
            //DTO로 변환(비밀번호는 "")
            joinMember.setPassword("");
            MemberDTO memberDTO = joinMember.toMemberDTO();
            //ResponsEntity에 DTO 담아서 리턴
            response.setItem(memberDTO);
            response.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(response);
        } catch (Exception e) {
            response.setErrorMessage(e.getMessage());
            response.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Member member) {
        ResponseDTO<MemberDTO> response = new ResponseDTO<>();
        try {
            //로그인처리
            //로그인 시 로그인 한 Member 엔티티 리턴
            Member loginMember = memberService.login(member.getUsername(), member.getPassword());

            //위에서 받아온 엔티티가 null이 아닐때
            if(loginMember != null) {
                //로그인한 유저에 대한 토큰 발행
                String token = jwtTokenProvider.create(loginMember);
                //DTO로 변환
                //비밀번호는 ""로 설정
                loginMember.setPassword("");
                MemberDTO memberDTO = loginMember.toMemberDTO();
                
                //발행된 토큰 DTO에 담기
                memberDTO.setToken(token);

                //RepsonseDTO에 MemberDTO 담아서 ResponseEntity의 body로 리턴
                response.setItem(memberDTO);
                response.setStatusCode(HttpStatus.OK.value());
                return ResponseEntity.ok().body(response);
            } else {
                response.setErrorMessage("login failed");
                return ResponseEntity.badRequest().body(response);
            }
        } catch (Exception e) {
            response.setErrorMessage(e.getMessage());
            response.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(response);
        }
    }
}
