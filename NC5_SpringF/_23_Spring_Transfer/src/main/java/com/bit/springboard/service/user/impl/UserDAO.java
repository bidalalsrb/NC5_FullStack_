package com.bit.springboard.service.user.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.springboard.dto.UserDTO;

@Repository("userDAO")
public class UserDAO {
//	@Autowired
//	private SqlSessionTemplate mybatis;
//	public void join(UserDTO userDTO) {
//		System.out.println("유저 조인");
//		mybatis.insert("UserDAO.insertUser",userDTO);
//
//	}
//
//	public UserDTO getUser(int id) {
//		System.out.println("겟유저 실행");
//		UserDTO userDTO = mybatis.selectOne("UserDAO.getUser",id);
//		return userDTO;
//	}
}
