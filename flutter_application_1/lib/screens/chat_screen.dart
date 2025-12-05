import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'history_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;

  bool _isListening = false;
  bool _isWaitingResponse = false;
  bool _isUserIdentified = false;
  String? _mobileNumber;
  int _currentIndex = 0;
  String? _selectedDomain;

  final List<String> _domains = [
    'PROCUREMENT',
    'QUALITY SPECIFICATIONS',
    'DELIVERY TIMELINES',
    'PRICING',
    'DOCUMENTATION'
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _messages.add({
      'sender': 'bot',
      'text': '👋 Hey there! Please enter your mobile number to start chatting.'
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        });
      }
    } else {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  void _sendMessage([String? textOverride]) {
    final text = textOverride?.trim() ?? _controller.text.trim();
    if (text.isEmpty || _isWaitingResponse) return;

    if (_isListening) {
      _speech.stop();
      setState(() => _isListening = false);
    }

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });

    _controller.clear();

    if (!_isUserIdentified) {
      _verifyUser(text);
    } else if (_selectedDomain != null && text.toLowerCase() == 'others') {
      setState(() => _selectedDomain = null);
      _showDomainCards();
    } else if (_selectedDomain != null) {
      _fetchAnswerFromBackend(_selectedDomain!, text);
    }
  }

  void _verifyUser(String mobile) async {
    setState(() => _isWaitingResponse = true);
    try {
      final url = Uri.parse('http://10.0.2.2:8080/api/auth/exists?mobileNumber=$mobile');
      final response = await http.get(url);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['exists'] == true) {
        setState(() {
          _isUserIdentified = true;
          _mobileNumber = mobile;
          _messages.add({
            'sender': 'bot',
            'text': '✅ Welcome $mobile! Please choose a domain below.'
          });
          _showDomainCards();
        });
      } else {
        setState(() {
          _isUserIdentified = false;
          _mobileNumber = null;
          _messages.add({
            'sender': 'bot',
            'text': '❌ You are not registered. Please contact the administrator or register first.'
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'bot', 'text': '🚫 Server error. Please try again later.'});
      });
    } finally {
      setState(() => _isWaitingResponse = false);
    }
  }

  void _showDomainCards() {
    _messages.add({'sender': 'bot', 'text': '__DOMAINS__'});
  }

Future<void> _fetchQuestionsForDomain(String domain) async {
  setState(() {
    _selectedDomain = domain;
    _messages.add({'sender': 'user', 'text': domain});
    _messages.removeWhere((msg) => msg['text'] == '__DOMAINS__');
    _messages.add({
      'sender': 'bot',
      'text': '✅ You selected "$domain". Now you can ask your question!'
    });
    _messages.add({'sender': 'bot', 'text': '__OTHERS__'}); // 👈 Add Others button again
  });
}



 Future<void> _fetchAnswerFromBackend(String domain, String question) async {
  setState(() => _isWaitingResponse = true);
  try {
    final url = Uri.parse(
      'http://10.0.2.2:8080/api/queries/search?domain=$domain&question=${Uri.encodeComponent(question)}',
    );

    final response = await http.get(url);

    String answer = '';
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final body = jsonDecode(response.body);
      answer = body['answer']?.toString().trim() ?? '';
    }

    if (answer.isEmpty) {
      setState(() {
        _messages.add({
          'sender': 'bot',
          'text': '🤖 Sorry, I didn’t get that. You can try rephrasing your question or select a different domain.',
        });
        _messages.add({'sender': 'bot', 'text': '__OTHERS__'}); // Add after the message
      });
    } else {
      setState(() {
        _messages.add({'sender': 'bot', 'text': answer});
        _messages.add({'sender': 'bot', 'text': '__OTHERS__'}); // ✅ Add here AFTER bot response
      });

      await http.post(
        Uri.parse('http://10.0.2.2:8080/api/history/save'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobileNumber': _mobileNumber,
          'userMessage': question,
          'chatResponse': answer,
        }),
      );
    }
  } catch (e) {
    setState(() {
      _messages.add({
        'sender': 'bot',
        'text': '⚠️ Unexpected error occurred. Please try again later.',
      });
      _messages.add({'sender': 'bot', 'text': '__OTHERS__'});
    });
  } finally {
    setState(() => _isWaitingResponse = false);
  }
}


  Widget _buildMessage(String text, bool isUser) {
    if (text == '__DOMAINS__') return _buildDomainOptionsInline();
    if (text == '__OTHERS__') return _buildOthersButton();

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () async {
          if (!isUser) {
            await _flutterTts.stop();
            await _flutterTts.speak(text);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUser ? Colors.blue[300] : Colors.deepPurple[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: isUser ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }

  Widget _buildDomainOptionsInline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Wrap(
        spacing: 8,
        children: _domains.map((domain) {
          return ElevatedButton(
            onPressed: () => _fetchQuestionsForDomain(domain),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple[300]),
            child: Text(domain, style: const TextStyle(fontSize: 12)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOthersButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
          onPressed: () => setState(() {
            _selectedDomain = null;
            _showDomainCards();
          }),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text("Others"),
        ),
      ),
    );
  }

  Widget _buildChatBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[_messages.length - 1 - index];
              return _buildMessage(msg['text']!, msg['sender'] == 'user');
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                onPressed: _listen,
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: _isUserIdentified ? 'Ask your question...' : 'Enter your mobile number...',
                  ),
                  enabled: !_isWaitingResponse,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
                color: _isWaitingResponse ? Colors.grey : Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("ChatSmart", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.deepPurple),
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                  )
                ],
              ),
            ),
            Expanded(
              child: _currentIndex == 0
                  ? _buildChatBody()
                  : (_mobileNumber != null
                      ? HistoryScreen(mobileNumber: _mobileNumber!)
                      : const Center(child: Text('📱 Please enter your mobile number first'))),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chatbot'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
