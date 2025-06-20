import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:websocket_lesson/features/view/blocs/chat_bloc.dart';
import 'package:websocket_lesson/features/view/blocs/chat_event.dart';
import 'package:websocket_lesson/features/view/screen/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('messages');

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
