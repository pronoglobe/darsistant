import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final types.User _user = types.User(id: 'user-id');

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'message-id',
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}