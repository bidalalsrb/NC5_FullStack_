package com.bit.springboard.service.impl;


import com.bit.springboard.entity.User;
import com.bit.springboard.repository.UserRepository;
import com.bit.springboard.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {
    private UserRepository userRepository;


    @Autowired
    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User idCheck(String userId) {
        Optional<User> userOptional = userRepository.findByUserId(userId);

        //아이디가 중복되지 않앗으면 null 리턴
        if (userOptional.isEmpty()){
            return null;
        }
        return userOptional.get();
    }

    @Override
    public void join(User user) {
        userRepository.save(user);
    }
}
