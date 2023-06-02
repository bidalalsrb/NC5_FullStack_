package com.bit.springboard.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bit.springboard.dto.UserDTO;
import com.bit.springboard.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Autowired
	@Qualifier("userDAO")
	UserDAO userDAO;

	@Override
	public void join(UserDTO userDTO) {
		// TODO Auto-generated method stub
		userDAO.join(userDTO);
	}

	@Override
	public UserDTO getUser(int id) {
		// TODO Auto-generated method stub
		return userDAO.getUser(id);
	}

}
