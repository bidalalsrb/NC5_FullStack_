package com.bit.springboard.Service;

import com.bit.springboard.dto.UserDTO;

public interface UserService {

	void join(UserDTO userDTO);
	
//select from T_User where id - ?
		
	UserDTO getUser(int id);
	
}
