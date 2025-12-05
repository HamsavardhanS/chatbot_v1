import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'About ChatSmart',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(height: 16),
              Text(
                'ChatSmart is an AI-powered chatbot application designed to assist users by providing instant, accurate responses to frequently asked questions within specific business domains such as Procurement, Documentation, Pricing, and more.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                '📱 Users can simply enter their mobile number to verify themselves and then interact with the chatbot seamlessly through voice or text.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                '💡 The chatbot helps reduce manual query handling by instantly responding to user questions based on domain-specific data.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                '📁 Every interaction is securely saved as history, allowing users to revisit past conversations under the "History" section.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                '🔊 ChatSmart also includes voice input and text-to-speech features for a more accessible and engaging user experience.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Purpose of the Application',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'The main goal of ChatSmart is to provide users with a fast and efficient way to get information related to different operational domains without the need to wait for human support. It enhances communication, improves response time, and ensures that critical information is always accessible on demand.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
