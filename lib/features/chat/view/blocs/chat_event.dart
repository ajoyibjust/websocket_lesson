part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class FetchChat extends ChatEvent {
  const FetchChat();
}

class AddData extends ChatEvent {
  final Message data;
  const AddData(this.data);
}

class SendMessage extends ChatEvent {
  final Message data;
  const SendMessage(this.data);
}