package com.bit.todobootapp.repository;

import com.bit.todobootapp.entity.Todo;
import com.bit.todobootapp.entity.TodoId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TodoRepository extends JpaRepository<Todo, TodoId> {
    List<Todo> findByUsername(String username);

    void deleteById(int id);
}
