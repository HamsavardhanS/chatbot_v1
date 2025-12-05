package com.chatbot.bot.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chatbot.bot.model.User;
import com.chatbot.bot.repository.UserRepository;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;

    public User loginOrRegister(String mobileNumber) {
        if (!isValidMobileNumber(mobileNumber)) {
            throw new IllegalArgumentException("Invalid mobile number. It must be exactly 10 digits and numeric only.");
        }

        return userRepository.findByMobileNumber(mobileNumber)
                .orElseGet(() -> userRepository.save(new User(null, mobileNumber, null)));
    }

    private boolean isValidMobileNumber(String mobileNumber) {
        return mobileNumber != null && mobileNumber.matches("\\d{10}");
    }

    private Optional<User> getByMobile(String mobile) {
        return userRepository.findByMobileNumber(mobile);
    }
    
    public boolean userExists(String mobileNumber) {
    return userRepository.existsByMobileNumber(mobileNumber);
}


    public Object getAllUsers() {
        try {
            return userRepository.findAll();
        } catch (Exception e) {
            throw new RuntimeException("Error fetching users: " + e.getMessage());
        }
    }
}
