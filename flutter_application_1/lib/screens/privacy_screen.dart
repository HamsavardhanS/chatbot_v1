import 'package:flutter/material.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Security'), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text('🔐 Privacy & Security', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('We are committed to safeguarding your data and ensuring a secure experience using ChatSmart.'),
            SizedBox(height: 12),
            Text('📌 What We Collect:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('- Mobile Number\n- Chat Questions\n- Chatbot Responses'),
            SizedBox(height: 12),
            Text('💼 How We Use It:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('To personalize your experience, display history, and improve chatbot accuracy.'),
            SizedBox(height: 12),
            Text('🔒 Data Security:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Your data is securely stored and encrypted. It is not shared with any third-party entities.'),
            SizedBox(height: 12),
            Text('📄 User Rights:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('You may request to view or delete your data at any time.'),
            SizedBox(height: 12),
            Text('📧 Contact:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('For any privacy-related questions, email: support@chatsmart.ai'),
          ],
        ),
      ),
    );
  }
}
