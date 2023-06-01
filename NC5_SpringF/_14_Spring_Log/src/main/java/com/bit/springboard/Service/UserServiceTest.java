package com.bit.springboard.Service;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.bit.springboard.dto.UserDTO;

public class UserServiceTest {
	public static void main(String[] args) {
		AbstractApplicationContext factory 
		= new GenericXmlApplicationContext("root-context.xml");

		UserService userService = (UserService)factory.getBean("userService");
		//	3. 글 등록 테스트
		UserDTO userDTO = new UserDTO();

		//		글 등록 
		userDTO.setUser_Id("wqe");
		userDTO.setUser_Pw("hello");
		userDTO.setUser_Name("hello");
		
//		userService.join(userDTO);
		
		
		UserDTO returnUser = userService.getUser(3);
		System.out.println(returnUser);
		
	}
}
