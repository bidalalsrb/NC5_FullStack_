package com.bit.todobootapp.service;

import com.bit.todobootapp.entity.Todo;

import java.util.List;

public interface TodoService {
    void insertTodo(Todo todo);

    List<Todo> getTodoList(String username);

    void updateTodo(Todo todo);

    void deleteTodo(Todo todo);
}
