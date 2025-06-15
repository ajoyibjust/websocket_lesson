import '../../../data/model/message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<Message> messages;
  ChatSuccess(this.messages);
}

class ChatFailure extends ChatState {
  final String error;
  ChatFailure(this.error);
}
