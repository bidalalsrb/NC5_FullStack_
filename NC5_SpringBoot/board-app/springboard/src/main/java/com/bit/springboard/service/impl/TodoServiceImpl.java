package com.bit.todobootapp.service.impl;

import com.bit.todobootapp.entity.Todo;
import com.bit.todobootapp.repository.TodoRepository;
import com.bit.todobootapp.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TodoServiceImpl implements TodoService {
    private final TodoRepository todoRepository;

    @Override
    public void insertTodo(Todo todo) {
        todoRepository.save(todo);
    }

    @Override
    public List<Todo> getTodoList(String username) {
        return todoRepository.findByUsername(username);
    }

    @Override
    public void updateTodo(Todo todo) {
        todoRepository.save(todo);
    }

    @Override
    public void deleteTodo(Todo todo) {
        todoRepository.delete(todo);
    }
}
