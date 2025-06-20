import 'package:flutter/material.dart';
import 'package:websocket_lesson/features/view/widget/bottom_bar.dart';
import 'package:websocket_lesson/features/view/widget/chat_body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF17212B),
        title: Row(
          children: [
            SizedBox(width: 10),
            Text('Flutter', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [Icon(Icons.more_vert, color: Colors.white)],
      ),
      body: ChatBody(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
