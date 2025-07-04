import 'package:chap_ia_001/bloc/chap_event.dart';
import 'package:chap_ia_001/bloc/chap_state.dart';
import 'package:chap_ia_001/views/data/openai_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final OpenAIService api;

  ChatBloc(this.api) : super(ChatInitial()) {
    on<SendMessageEvent>((event, emit) async {
      emit(ChatLoading());
      try {
        final response = await api.sendMessage(event.message);
        emit(ChatSuccess(response));
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });
  }
}
