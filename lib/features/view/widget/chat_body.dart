import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_lesson/features/view/blocs/chat_bloc.dart';
import 'package:websocket_lesson/features/view/blocs/chat_state.dart';
import 'package:websocket_lesson/features/view/widget/chat_success.dart';

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
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is Success) {
              final chat = state.messages;
              return ChatSuccess(chat: chat);
            } else if (state is Failure) {
              return Center(
                child: Text(state.error, style: TextStyle(color: Colors.white)),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
