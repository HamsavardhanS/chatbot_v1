import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


const String baseUrl = "https://chatbot-v1-90ar.onrender.com";
class HistoryScreen extends StatefulWidget {
  final String mobileNumber;

  const HistoryScreen({super.key, required this.mobileNumber});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChatHistory();
  }

  Future<void> _fetchChatHistory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse("$baseUrl/api/history/${widget.mobileNumber}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _history = data.map((e) => {
                'userMessage': e['userMessage'],
                'chatResponse': e['chatResponse'],
              }).toList();
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _history = [];
          _isLoading = false;
        });
        print("No history found for this mobile number.");
      } else {
        setState(() {
          _history = [];
          _isLoading = false;
        });
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to fetch history: $e");
      setState(() {
        _history = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_history.isEmpty) {
      return Center(
        child: Text(
          'No history found for this mobile number.',
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final item = _history[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text("You: ${item['userMessage']}"),
            subtitle: Text("Bot: ${item['chatResponse']}"),
          ),
        );
      },
    );
  }
}