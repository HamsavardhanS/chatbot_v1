import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
void main() {
  runApp(const ChatbotApp());
}

class ChatbotApp extends StatelessWidget {
  const ChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suguna ChatBot',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        primaryColor: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
      onGenerateRoute: (settings) {
        // Handle unknown routes if needed
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
    );
  }
}
