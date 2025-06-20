import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_lesson/features/data/models/message.dart';
import 'package:websocket_lesson/features/view/blocs/chat_bloc.dart';
import 'package:websocket_lesson/features/view/blocs/chat_event.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ColoredBox(
        color: Color(0xFF17212B),
        child: Row(
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 15),
            Expanded(
              child: TextFormField(
                controller: _messageController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Xabar yozing...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (_messageController.text.trim().isNotEmpty) {
                  final message = Message(
                    name: "NoBody",
                    message: _messageController.text.trim(),
                    time: DateTime.now(),
                  );
                  context.read<ChatBloc>().add(SendMessage(message));
                  _messageController.clear();
                }
              },
              icon: Icon(Icons.send, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
