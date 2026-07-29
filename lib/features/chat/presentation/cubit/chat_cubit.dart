import 'package:easy_pay_app/features/chat/domain/use_case/send_message_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;

  ChatCubit(this.sendMessageUseCase) : super(ChatInitial());

  void clearError() {
    if (state is ChatError) {
      emit(ChatInitial());
    }
  }
  Future<void> sendMessage(String text, {int? notificationId}) async {
    if (text.trim().isEmpty) return;

    emit(ChatLoading());

    try {
      final messageEntity = await sendMessageUseCase(text, notificationId: notificationId);
      emit(ChatMessageSentSuccess(messageEntity));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}