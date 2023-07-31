package com.bit.todobootapp.controller;

import com.bit.todobootapp.dto.ResponseDTO;
import com.bit.todobootapp.dto.TodoDTO;
import com.bit.todobootapp.entity.Todo;
import com.bit.todobootapp.service.TodoService;
import jdk.jshell.spi.ExecutionControlProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/todo")
@RequiredArgsConstructor
public class TodoController {
    public final TodoService todoService;

    @GetMapping("/todo")
    public ResponseEntity<?> getTodoList(@AuthenticationPrincipal String username) {
        ResponseDTO<TodoDTO> response = new ResponseDTO<>();
        try {
            List<Todo> todoList = todoService.getTodoList(username);

            //TodoDTO로 변환
            List<TodoDTO> todoDTOList = new ArrayList<>();
            for(Todo t : todoList) {
                todoDTOList.add(t.toTodoDTO());
            }

            response.setItems(todoDTOList);
            response.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(response);
        } catch (Exception e) {
            response.setErrorMessage(e.getMessage());
            response.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PostMapping("/todo")
    public ResponseEntity<?> insertTodo(@RequestBody Todo todo, @AuthenticationPrincipal String username) {
        ResponseDTO<TodoDTO> response = new ResponseDTO<>();
        try {
            System.out.println(todo);
            System.out.println(username);
            todo.setUsername(username);

            //새로운 todo 저장
            todoService.insertTodo(todo);

            //저장된 todo를 포함하는 리스트를 리턴
            List<Todo> todoList = todoService.getTodoList(username);
            
            //TodoDTO로 변환
            List<TodoDTO> todoDTOList = new ArrayList<>();
            for(Todo t : todoList) {
                todoDTOList.add(t.toTodoDTO());
            }

            response.setItems(todoDTOList);
            response.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(response);
        } catch (Exception e) {
            response.setErrorMessage(e.getMessage());
            response.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PutMapping("/todo")
    public ResponseEntity<?> updateTodo(@RequestBody Todo todo, @AuthenticationPrincipal String username) {
        ResponseDTO<TodoDTO> response = new ResponseDTO<>();

        try {
            todo.setUsername(username);

            //저장되어 있는 todo 내용 수정
            todoService.updateTodo(todo);
            
            //수정된 내용까지 포함하는 todolist 조회
            List<Todo> todoList = todoService.getTodoList(username);

            //TodoDTO로 변환
            List<TodoDTO> todoDTOList = new ArrayList<>();
            for(Todo t : todoList) {
                todoDTOList.add(t.toTodoDTO());
            }

            response.setItems(todoDTOList);
            response.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(response);

        } catch (Exception e) {
            response.setErrorMessage(e.getMessage());
            response.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @DeleteMapping("/todo")
    public ResponseEntity<?> deleteTodo(@RequestParam int id, @AuthenticationPrincipal String username) {
        ResponseDTO<TodoDTO> response = new ResponseDTO<>();

        try {
            Todo todo = Todo.builder()
                            .id(id)
                            .username(username)
                            .build();

            //저장되어 있는 todo 내용 삭제
            todoService.deleteTodo(todo);

            //수정된 내용까지 포함하는 todolist 조회
            List<Todo> todoList = todoService.getTodoList(username);

            //TodoDTO로 변환
            List<TodoDTO> todoDTOList = new ArrayList<>();
            for(Todo t : todoList) {
                todoDTOList.add(t.toTodoDTO());
            }

            response.setItems(todoDTOList);
            response.setStatusCode(HttpStatus.OK.value());

            return ResponseEntity.ok().body(response);

        } catch (Exception e) {
            response.setErrorMessage(e.getMessage());
            response.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.badRequest().body(response);
        }
    }
}
