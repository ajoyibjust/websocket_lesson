import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:websocket_lesson/core/services/web_socket_services.dart';
import 'package:websocket_lesson/features/chat/data/models/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> chat = [];
  
  ChatBloc() : super( Success([])) {
    WebSocketServices.getInstance("wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1");
    
    WebSocketServices.channel.stream.listen(
      (event) {
        if (event is String && event.isEmpty) return;
        try {
          add(AddData(Message.fromJson(json.decode(event))));
        } catch (e) {
          print("Error: $e");
        }
      },
      cancelOnError: true,
      onError: (e) {
        emit(Failure(e.toString()));
        WebSocketServices.getInstance("wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1");
      },
      onDone: () {
        emit(Failure("Server bilan uzulish yuzaga keldi"));
        WebSocketServices.getInstance("wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1");
      },
    );

    on<FetchChat>(_fetchChat);
    on<AddData>(_addData);
    on<SendMessage>(_sendMessage);
  }

  void _fetchChat(FetchChat event, Emitter<ChatState> emit) {
    emit(Success(chat));
  }

  void _addData(AddData event, Emitter<ChatState> emit) {
    chat = [event.data, ...chat];
    emit(Success(chat));
  }

  void _sendMessage(SendMessage event, Emitter<ChatState> emit) {
    WebSocketServices.channel.sink.add(json.encode(event.data.toJson()));
  }
}