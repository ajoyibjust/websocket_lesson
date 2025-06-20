part of 'chat_bloc.dart';



abstract class ChatState {}

class Initial extends ChatState {}

class Loading extends ChatState {}

class Success extends ChatState {
  final List<Message> messages;
  Success(this.messages);
}

class Failure extends ChatState {
  final String error;
  Failure(this.error);
}
