package com.bit.todobootapp.dto;

import com.bit.todobootapp.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberDTO {
    private long id;
    private String username;
    private String password;
    private String role;
    private String token;

    public Member toMemberEntity() {
        return Member.builder()
                .id(this.id)
                .username(this.username)
                .password(this.password)
                .role(this.role)
                .build();
    }
}
