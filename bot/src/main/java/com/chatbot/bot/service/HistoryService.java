package com.chatbot.bot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chatbot.bot.dto.HistoryDTO;
import com.chatbot.bot.model.History;
import com.chatbot.bot.model.User;
import com.chatbot.bot.repository.HistoryRepository;
import com.chatbot.bot.repository.UserRepository;

@Service

public class HistoryService {
    @Autowired
    private HistoryRepository historyRepository;

    @Autowired
    private UserRepository userRepository;

    public History saveHistory (HistoryDTO dto)
    {
        User user = userRepository.findByMobileNumber(dto.getMobileNumber())
                .orElseThrow(() -> new RuntimeException("User not found with mobile number: " + dto.getMobileNumber()));

        History history = new History();
        history.setUserMessage(dto.getUserMessage());
        history.setChatResponse(dto.getChatResponse());
        history.setUser(user);

        return historyRepository.save(history);
    }
    public List<History> getHistoryForUser(String mobileNumber) {
        return historyRepository.findByUser_MobileNumberOrderByTimestampDesc(mobileNumber);
    }
}
