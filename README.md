# 🤖 ChatSmart – AI-Powered Domain-Based Chatbot

ChatSmart is a smart and responsive chatbot application built using **Flutter** for frontend and **Spring Boot** for backend. It provides domain-specific answers to user queries after verifying their mobile number. The application supports voice input, text-to-speech output, chat history, and a clean, user-friendly interface.

---

## ✨ Features

- ✅ **Mobile Number Verification** – Only registered users can access the chatbot
- 🧠 **Domain-Specific Question Answering** – Domains like Procurement, Documentation, Pricing, etc.
- 🎤 **Voice Input Support** – Users can speak instead of typing their queries
- 🔊 **Text-to-Speech** – Tap on the bot’s messages to hear them
- 🗂️ **Chat History** – Past conversations stored and viewable in the History tab
- 🌐 **RESTful Backend** – Integrated with Spring Boot + MySQL
- 🔐 **Secure Data Handling** – Ensures user data privacy

---

## 🛠️ Tech Stack

| Layer         | Technology      |
|---------------|------------------|
| Frontend      | Flutter (Dart)   |
| Backend       | Spring Boot (Java) |
| Database      | MySQL            |
| Speech Input  | speech_to_text   |
| Speech Output | flutter_tts      |
| API Protocol  | RESTful HTTP     |

---

## 📁 Project Structure (Frontend - Chatbot)

lib/
│
├── screens/
│ ├── chat_screen.dart
│ ├── history_screen.dart
│ ├── settings_screen.dart
│ └── faqs_page.dart
│
├── main.dart





---

## 🚀 How to Run

### 🔧 Prerequisites

- Flutter SDK
- Android Studio / VS Code
- MySQL Database
- Spring Boot backend (running on port `8080`)

### 🔑 Flutter Setup

```bash
git clone https://github.com/HamsavardhanS/chatbot.git
cd chatbot
flutter pub get
flutter run


---


