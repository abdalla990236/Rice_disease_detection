import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotScreen extends StatefulWidget {
  static const String id = 'ChatBotScreen';

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, String>> _messages = [
    {
      'sender': 'bot',
      'text': "🌾 Hello! I'm your Rice Disease Assistant 🤖"
    },
    {
      'sender': 'bot',
      'text': "I can help you diagnose and manage rice plant diseases."
    },
    {
      'sender': 'bot',
      'text':
      "Ask me things like:\n- 'What is Sheath Blight?'\n- 'How to treat Brown Spot?'\n- 'How to prevent Leaf Blast?'"
    },
  ];

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });

    final botReply = await _fetchBotReply(text);

    setState(() {
      _messages.add({'sender': 'bot', 'text': botReply});
    });

    _controller.clear();
  }

  Future<String> _fetchBotReply(String userInput) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.14:5000/ask"), // -----
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': userInput}),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return decoded['answer'];
      } else {
        return "⚠️ Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      return "⚠️ Failed to connect to AI service. Please check your internet or server.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.smart_toy_outlined),
            SizedBox(width: 8),
            Text('AI'),
            Text(' 👋'),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.yellow[100],
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.orange),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'This is the beginning of a conversation with the E-Crop Diagnosis Digital Assistant',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(message['text']!),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask a question',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _sendMessage(_controller.text),
                  child: Icon(Icons.send_rounded,
                      size: 28, color: Colors.blueAccent),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
