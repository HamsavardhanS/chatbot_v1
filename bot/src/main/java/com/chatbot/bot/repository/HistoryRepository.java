package com.chatbot.bot.repository;

import com.chatbot.bot.model.History;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface HistoryRepository extends JpaRepository<History, Long> {
    

    List<History> findByUser_MobileNumberOrderByTimestampDesc(String mobileNumber);
    // Custom query methods can be defined here if needed
    // For example, to find history by user ID or timestamp
    // List<History> findByUserId(Long userId);
    // List<History> findByTimestampBetween(LocalDateTime start, LocalDateTime end);

}
