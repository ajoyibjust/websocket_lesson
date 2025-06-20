import 'package:websocket_lesson/features/data/models/message.dart';

abstract class ChatEvent {}

class FetchChat extends ChatEvent {}

class AddData extends ChatEvent {
  final Message data;
  AddData(this.data);
}

class SendMessage extends ChatEvent {
  final Message data;
  SendMessage(this.data);
}
