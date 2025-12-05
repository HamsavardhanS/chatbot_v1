package com.chatbot.bot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.chatbot.bot.model.Queries;
import com.chatbot.bot.repository.QueriesRepository;

@RestController
@RequestMapping("/api/queries")
public class QueriesController {
    @Autowired
    private QueriesRepository repository;

    @GetMapping("/domain/{domain}")
    public List<Queries> getByDomain(@PathVariable String domain) {
        return repository.findByDomainIgnoreCase(domain);
    }

   @GetMapping("/search")
public Queries searchQuestionInDomain(@RequestParam String domain, @RequestParam String question) {
    System.out.println("🔎 Domain: " + domain + ", Question: " + question);

    // Try exact match first
    Queries exact = repository.findByDomainIgnoreCaseAndQuestionIgnoreCase(domain, question);
    if (exact != null) {
        System.out.println("✅ Exact match found: " + exact.getQuestion());
        return exact;
    }

    // Then fuzzy
    Queries fuzzy = repository.searchFuzzyMatch(domain, question);
    System.out.println("⚠️ Fuzzy match used: " + (fuzzy != null ? fuzzy.getQuestion() : "No match"));
    return fuzzy;
}

}


