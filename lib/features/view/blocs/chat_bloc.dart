import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:websocket_lesson/core/services/web_socket_services.dart';
import 'package:websocket_lesson/features/data/models/message.dart';
import 'package:websocket_lesson/features/view/blocs/chat_event.dart';
import 'package:websocket_lesson/features/view/blocs/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> messages = [];
  late final Box _messageBox;

  ChatBloc() : super(Loading()) {
    _initHive();
    _initWebSocket();

    on<FetchChat>(_fetchChat);
    on<AddData>(_addData);
    on<SendMessage>(_sendMessage);
  }

  Future<void> _initHive() async {
    _messageBox = await Hive.openBox('messages');
    _loadMessages();
  }

  void _initWebSocket() {
    WebSocketServices.getInstance(
      "wss://s14781.nyc1.piesocket.com/v3/1?api_key=kLgGoDV7ablppHkpGtqwvb1kGOru8svXMwpu47C3&notify_self=1",
    );

    WebSocketServices.channel.stream.listen((event) {
      if (event is String && event.isEmpty) return;
      try {
        add(AddData(Message.fromJson(json.decode(event))));
      } catch (e) {
        emit(Failure("Xabar qabul qilishda xatolik: $e"));
      }
    });
  }

  void _loadMessages() {
    try {
      messages = _messageBox.values
          .map((e) => Message.fromMap(Map<String, dynamic>.from(e)))
          .toList();
      emit(Success(messages));
    } catch (e) {
      emit(Failure("Xabarlarni yuklashda xatolik: $e"));
    }
  }

  void _addData(AddData event, Emitter<ChatState> emit) {
    try {
      messages = [event.data, ...messages];
      _messageBox.add(event.data.toMap());
      emit(Success(messages));
    } catch (e) {
      emit(Failure("Xabar qo'shishda xatolik: $e"));
    }
  }

  void _fetchChat(FetchChat event, Emitter<ChatState> emit) {
    emit(Success(messages));
  }

  void _sendMessage(SendMessage event, Emitter<ChatState> emit) {
    try {
      WebSocketServices.channel.sink.add(json.encode(event.data.toJson()));
    } catch (e) {
      emit(Failure("Xabar yuborishda xatolik: $e"));
    }
  }
}
