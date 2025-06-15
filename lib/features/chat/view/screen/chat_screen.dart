import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_lesson/core/service/hive_chat.dart';
import 'package:websocket_lesson/features/chat/view/blocs/chat_bloc/chat_bloc.dart';
import 'package:websocket_lesson/features/chat/view/blocs/chat_bloc/chat_event.dart';
import 'package:websocket_lesson/features/chat/view/widget/chat_body.dart';
import '../../data/model/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final message = TextEditingController();

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
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              HiveChat().readAlldata();
            },
          ),
        ],
      ),

      body: ChatBody(),
      bottomNavigationBar: IntrinsicHeight(
        child: ColoredBox(
          color: Color(0xFF17212B),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: Colors.white),
              ),
              SizedBox(width: 15),
              Expanded(
                child: TextFormField(
                  controller: message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<ChatBloc>().add(
                    SendMessage(
                      Message(
                        name: "NoBody",
                        message: message.text.trim(),
                        time: DateTime.now().toIso8601String(),
                      ),
                    ),
                  );
                  HiveChat().insertData(
                    name: "NoBody",
                    message: message.text,
                    time: DateTime.now().toIso8601String(),
                  );
                  message.clear();
                },
                icon: Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
