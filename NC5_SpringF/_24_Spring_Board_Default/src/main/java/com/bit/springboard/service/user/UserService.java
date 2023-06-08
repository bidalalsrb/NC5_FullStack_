package com.bit.springboard.service.user;

import com.bit.springboard.dto.UserDTO;

public interface UserService {
	//insert into T_USER
	void join(UserDTO userDTO);

	//select from T_USER where id = ?
	UserDTO getUser(int id);

	//	아이디로 데이터 개수 조회
	int idCheck(String userId);

	//	아이디와 패스워드로 사용자 정보 조회
	UserDTO login(UserDTO userDTO);


}
