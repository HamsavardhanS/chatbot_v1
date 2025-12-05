package com.chatbot.bot.controller;

import com.chatbot.bot.dto.HistoryDTO;
import com.chatbot.bot.model.History;
import com.chatbot.bot.service.HistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/api/history")
@CrossOrigin
public class HistoryController {

    @Autowired
    private HistoryService historyService;

    @PostMapping("/save")
    public ResponseEntity<History> saveHistory(@RequestBody HistoryDTO dto) {
        return ResponseEntity.ok(historyService.saveHistory(dto));
    }
    
    @GetMapping("/{mobileNumber}")
    public ResponseEntity<List<History>> getHistory(@PathVariable String mobileNumber) {
        
        return ResponseEntity.ok(historyService.getHistoryForUser(mobileNumber));
    }
}
