import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String userName;
  final String userAvatar;

  ChatPage({
    required this.userId,
    required this.userName,
    required this.userAvatar,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class Message {
  final String senderId;
  final String text;
  final DateTime timestamp;

  Message({required this.senderId, required this.text, required this.timestamp});
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];

  final String currentUserId = 'currentUser';

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(
        senderId: currentUserId,
        text: text,
        timestamp: DateTime.now(),
      ));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.userAvatar),
            ),
            SizedBox(width: 12),
            Text(widget.userName, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[_messages.length - 1 - index];
                final isMe = msg.senderId == currentUserId;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.deepPurple : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
