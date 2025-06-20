import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_lesson/features/chat/view/screen/chat_screen.dart';
import 'features/chat/view/blocs/chat_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(FetchChat()),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: ChatScreen()),
    );
  }
}
