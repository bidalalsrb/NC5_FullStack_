package com.bit.springboard.entity;

import com.bit.springboard.dto.UserDTO;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "T_USER")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column(unique = true)
    private String userId;
    private String userPw;
    private String userName;
    private String userEmail;
    private String userTel;
    private LocalDateTime userRegdate = LocalDateTime.now();

    public UserDTO EntityToDTO() {
        UserDTO userDTO = UserDTO.builder()
                .id(this.id)
                .userId(this.userId)
                .userEmail(this.userEmail)
                .userName(this.userName)
                .userTel(this.userTel)
                .userRegdate(this.userRegdate)
                .build();
        return userDTO;
    }
}