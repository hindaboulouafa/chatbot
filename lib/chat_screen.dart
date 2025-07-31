import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // Simple bot replies based on user input
    String botReply = 'Sorry, I did not understand that.';
    if (text.toLowerCase().contains('hello')) {
      botReply = 'Hi there! How can I help you today?';
    } else if (text.toLowerCase().contains('how are you')) {
      botReply = 'I\'m a bot, but I\'m doing great, thanks!';
    }

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _messages.add({'sender': 'bot', 'text': botReply});
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('ChatGPT Bot', style: TextStyle(fontSize: 18)),
                Text('Online', style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    constraints: const BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg['text'] ?? '',
                      style: TextStyle(color: isUser ? Colors.white : Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                    onPressed: _sendMessage,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
