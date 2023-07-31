package com.bit.todobootapp.entity;

import com.bit.todobootapp.dto.MemberDTO;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;

@Entity
@Table(name="T_MEMBER",
        //username UK로 지정
        uniqueConstraints = {@UniqueConstraint(columnNames = "username")}
      )
@SequenceGenerator(
        name="MemberSeqGenerator",
        sequenceName = "T_MEMBER_SEQ",
        initialValue = 1,
        allocationSize = 1
)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member {
    @Id
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "MemberSeqGenerator"
    )
    private long id;
    @Column(nullable = false)
    private String username;
    @Column(nullable = false)
    private String password;
    @ColumnDefault("'ROLE_USER'")
    private String role;

    public MemberDTO toMemberDTO() {
        return MemberDTO.builder()
                .id(this.id)
                .username(this.username)
                .password(this.password)
                .role(this.role)
                .build();
    }
}
