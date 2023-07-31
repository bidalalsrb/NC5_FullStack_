package com.bit.todobootapp.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class TodoId implements Serializable {
    private int id;
    private String username;
}
