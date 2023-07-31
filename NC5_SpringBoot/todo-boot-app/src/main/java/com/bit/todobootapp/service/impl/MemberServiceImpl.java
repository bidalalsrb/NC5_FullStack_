package com.bit.todobootapp.service.impl;

import com.bit.todobootapp.entity.Member;
import com.bit.todobootapp.repository.MemberRepository;
import com.bit.todobootapp.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public Member join(Member member) {
        //유효성 검사
        if(member == null || member.getUsername() == null) {
            throw new RuntimeException("Invalid Argument");
        }
        
        //username 중복체크
        if(memberRepository.existsByUsername(member.getUsername())) {
            throw new RuntimeException("already exist username");
        }

        return memberRepository.save(member);
    }

    @Override
    public Member login(String username, String password) {
        //username으로 조회
        Optional<Member> loginMember = memberRepository.findByUsername(username);
        
        if(loginMember.isEmpty()) {
            throw new RuntimeException("not exist username");
        }

        //비밀번호 비교
        //PasswordEncoder 객체 사용
        //PasswordEncoder의 matches(암호화되지 않은 비밀번호, 암호화된 비밀번호) 메소드 사용
        if(!passwordEncoder.matches(password, loginMember.get().getPassword())) {
            throw new RuntimeException("wrong password");
        }

        return loginMember.get();
    }
}
