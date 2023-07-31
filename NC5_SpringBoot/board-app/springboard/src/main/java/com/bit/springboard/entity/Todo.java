package com.bit.todobootapp.entity;

import com.bit.todobootapp.dto.TodoDTO;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "T_TODO")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@IdClass(TodoId.class)
public class Todo {
    @Id
    private int id;
    @Id
    private String username;
    private String text;
    private boolean checked;

    public TodoDTO toTodoDTO() {
        return TodoDTO.builder()
                .id(this.id)
                .username(this.username)
                .text(this.text)
                .checked(this.checked)
                .build();
    }
}
