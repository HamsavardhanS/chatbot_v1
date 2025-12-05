package com.chatbot.bot.repository;

import java.lang.StackWalker.Option;

import org.springframework.data.jpa.repository.JpaRepository;

import com.chatbot.bot.model.User;
import java.util.Optional;


public interface UserRepository extends JpaRepository<User,Long> {

    Optional<User> findByMobileNumber(String mobileNumber);
    boolean existsByMobileNumber(String mobileNumber);

}
