package com.bit.todobootapp.dto;

import com.bit.todobootapp.entity.Todo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TodoDTO {
    private int id;
    private String username;
    private String text;
    private boolean checked;

    public Todo toTodoEntity() {
        return Todo.builder()
                .id(this.id)
                .username(this.username)
                .text(this.text)
                .checked(this.checked)
                .build();
    }
}
