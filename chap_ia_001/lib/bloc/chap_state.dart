abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final String response;
  ChatSuccess(this.response);
}

class ChatError extends ChatState {
  final String error;
  ChatError(this.error);
}
