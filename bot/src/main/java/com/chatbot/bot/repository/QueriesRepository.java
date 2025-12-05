package com.chatbot.bot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.chatbot.bot.model.Queries;
import java.util.List;

public interface QueriesRepository extends JpaRepository<Queries, Integer> {
    List<Queries> findByDomainIgnoreCase(String domain);
    List<Queries> findByQuestionContainingIgnoreCase(String keyword);

    // 1. Exact match first
Queries findByDomainIgnoreCaseAndQuestionIgnoreCase(String domain, String question);

// 2. Then fallback to fuzzy match
@Query("SELECT q FROM Queries q WHERE LOWER(q.domain) = LOWER(:domain) AND LOWER(q.question) LIKE %:question%")
Queries searchFuzzyMatch(@Param("domain") String domain, @Param("question") String question);


}

