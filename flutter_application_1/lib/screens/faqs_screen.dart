import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'What is ChatSmart?',
        'answer': 'ChatSmart is an AI-powered chatbot that helps users find answers related to various business domains such as Procurement, Documentation, Pricing, and more.'
      },
      {
        'question': 'Do I need to register to use the chatbot?',
        'answer': 'Yes. You need to enter your registered mobile number to start using the chatbot. If not registered, you will be notified.'
      },
      {
        'question': 'What if I want to ask a question from a different domain?',
        'answer': 'You can tap the "Others" button anytime to go back and choose a different domain.'
      },
      {
        'question': 'Can I use voice to ask questions?',
        'answer': 'Yes! Tap the microphone icon to speak your question. The chatbot will convert your speech to text and respond accordingly.'
      },
      {
        'question': 'Can the chatbot read out the answers for me?',
        'answer': 'Yes. Just tap on the bot\'s response and it will be read aloud using Text-to-Speech.'
      },
      {
        'question': 'Where can I see my previous chats?',
        'answer': 'You can go to the History tab from the bottom navigation bar to view your previous questions and responses.'
      },
      {
        'question': 'Is my data safe?',
        'answer': 'Yes, your mobile number and chat history are stored securely and are not shared with any third parties.'
      },
      {
        'question': 'What domains does ChatSmart support?',
        'answer': 'ChatSmart currently supports: Procurement, Quality Specifications, Delivery Timelines, Pricing, and Documentation.'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('FAQs'), backgroundColor: Colors.deepPurple),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return ExpansionTile(
            title: Text(faq['question']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faq['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
