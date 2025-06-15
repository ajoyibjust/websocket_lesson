import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_lesson/core/service/hive_chat.dart';
import 'package:websocket_lesson/core/service/web_socket_services.dart';
import 'package:websocket_lesson/features/chat/data/model/message.dart';
import 'package:websocket_lesson/features/chat/view/blocs/chat_bloc/chat_event.dart';
import 'package:websocket_lesson/features/chat/view/blocs/chat_bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> chat = [];

  getLocalChat() {
    List<Map<String, dynamic>> messages = HiveChat().readAlldata();
    for (var mes in messages) {
      chat.add(Message.fromJson(mes));
    }
  }

  ChatBloc() : super(ChatInitial()) {
    _initializeWebSocket();

    on<FetchChat>(_fetchChat);
    on<AddData>(_addData);
    on<SendMessage>(_sendMessage);
  }

  void _initializeWebSocket() {
    WebSocketServices.getInstance(
      "wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1",
    );

    WebSocketServices.channel.stream.listen(
      (event) {
        if (event is String && event.isNotEmpty) {
          try {
            add(AddData(Message.fromJson(json.decode(event))));
          } catch (e) {
            print(e);
          }
        }
      },
      cancelOnError: true,
      onError: (e) {
        emit(ChatFailure(e.toString()));
      },
      onDone: () {
        emit(ChatFailure("Server bilan aloqa yo‘q"));
      },
    );
  }

  void _fetchChat(FetchChat event, Emitter<ChatState> emit) {
    emit(ChatSuccess(chat));
  }

  void _addData(AddData event, Emitter<ChatState> emit) {
    chat = [event.data, ...chat];
    emit(ChatSuccess(chat));
  }

  void _sendMessage(SendMessage event, Emitter<ChatState> emit) {
    WebSocketServices.channel.sink.add(json.encode(event.data.toJson()));
  }
}
