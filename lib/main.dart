import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:websocket_lesson/features/chat/view/blocs/chat_bloc/chat_event.dart';
import 'package:websocket_lesson/features/chat/view/screen/chat_screen.dart';
import 'features/chat/view/blocs/chat_bloc/chat_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("chat");
  final chatBloc = ChatBloc();
  chatBloc.getLocalChat();
  chatBloc.add(FetchChat());
  runApp(MyApp(chatBloc: chatBloc));
}

class MyApp extends StatelessWidget {
  final ChatBloc chatBloc;

  const MyApp({super.key, required this.chatBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatBloc,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: ChatScreen()),
    );
  }
}
