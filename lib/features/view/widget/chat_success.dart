import 'package:flutter/material.dart';
import 'package:websocket_lesson/features/data/models/message.dart';

class ChatSuccess extends StatelessWidget {
  final List<Message> chat;
  const ChatSuccess({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.none,
      reverse: true,
      itemBuilder: (context, index) {
        final data = chat[index];
        final isMe = data.name == "NoBody";
        return Row(
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!isMe) const SizedBox(width: 10),
            if (!isMe) const CircleAvatar(),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF549CD7) : const Color(0xFF182533),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(data.time),
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: chat.length,
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
