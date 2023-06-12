package com.bit.springboard.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bit.springboard.dto.UserDTO;
import com.bit.springboard.service.user.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	@Qualifier("userDAO")
	UserDAO userDAO;

	@Override
	public void join(UserDTO userDTO/*userId = "aaa"*/) {
		// TODO Auto-generated method stub
		System.out.println("UserServiceImpl의 join 호출");
		System.out.println("UserServiceImpl의 userDTO");
		System.out.println(userDTO);
		userDAO.join(userDTO);
		System.out.println("UserServiceImpl의 join 호출 종료");
	}

	@Override
	public UserDTO getUser(int id) {
		// TODO Auto-generated method stub
		System.out.println("UserServiceImpl의 getUser 호출");
		System.out.println("UserServiceImpl의 id");
		System.out.println(id);
		System.out.println("UserServiceImpl의 getUser 호출종료");
		return userDAO.getUser(id);
	}

	@Override
	public int idCheck(String userId) {
		// TODO Auto-generated method stub
		return userDAO.idCheck(userId);
	}

	@Override
	public UserDTO login(UserDTO userDTO) {
		// TODO Auto-generated method stub
		return userDAO.login(userDTO);
	}

	
	
	
	
	
	
	
	
	
	
}
