import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import '../blocs/chat_bloc/chat_state.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ColoredBox(
        color: Color(0xFF0E1621),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatSuccess) {
              final chat = state.messages;
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isMe
                              ? const Color(0xFF549CD7)
                              : Color(0xFF182533),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          data.message,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: chat.length,
              );
            } else if (state is ChatFailure) {
              return Center(child: Text(state.error));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
