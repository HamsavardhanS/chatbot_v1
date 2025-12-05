import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/chat_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';
import '../screens/privacy_screen.dart';
import '../screens/faqs_screen.dart';

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => const WelcomeScreen(),
    '/chatscreen': (context) => const ChatScreen(),
    '/settings':(context)=> const SettingsScreen(),
    '/about': (context) => const AboutPage(),
    '/privacy': (context) => const PrivacySecurityPage(),
    '/faqs': (context) => const FAQsPage(),
  };
}



