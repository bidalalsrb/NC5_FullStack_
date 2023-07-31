package com.bit.todobootapp.service;

import com.bit.todobootapp.entity.Member;

public interface MemberService {
    Member join(Member member);

    Member login(String username, String password);
}
