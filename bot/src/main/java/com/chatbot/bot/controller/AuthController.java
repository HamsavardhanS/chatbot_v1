package com.chatbot.bot.controller;

import com.chatbot.bot.model.User;
import com.chatbot.bot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin
public class AuthController {

    @Autowired
    private UserService userService;

    
    @PostMapping("/login")
    public ResponseEntity<?> loginOrRegister(@RequestBody Map<String, String> payload) {
    String mobile = payload.get("mobileNumber");
    try {
        User newUser = userService.loginOrRegister(mobile);
        return ResponseEntity.ok(newUser);
    } catch (RuntimeException e) {
        return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
    }
}
    @GetMapping("/exists")
public ResponseEntity<?> checkUserExists(@RequestParam String mobileNumber) {
    boolean exists = userService.userExists(mobileNumber);
    return ResponseEntity.ok(Map.of("exists", exists));
}

    @GetMapping("/all")
    public ResponseEntity<?> getAllUsers() {
        try {
            return ResponseEntity.ok(userService.getAllUsers());
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
}


