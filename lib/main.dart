import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:websocket_lesson/features/chat/view/screen/chat_screen.dart';
import 'features/chat/view/blocs/chat_bloc/chat_bloc.dart';
import 'features/chat/view/blocs/chat_bloc/chat_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("chat");
  final chatBloc = ChatBloc();
  chatBloc.getLocalChat();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(FetchChat()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChatScreen(),
      ),
    );
  }
}
