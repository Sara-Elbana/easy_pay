import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/chat/data/models/requests/send_chat_reply_request.dart';
import 'package:easy_pay_app/features/chat/domain/entities/chat_message_entity.dart';
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

    final request = SendChatReplyRequest(
      message: text,
      notificationId: notificationId,
    );
    final result = await sendMessageUseCase(request);
    if (result is ApiSuccess<ChatMessageEntity>) {
      emit(ChatMessageSentSuccess(result.data));
    } else if (result is ApiFailure<ChatMessageEntity>) {
      emit(ChatError(result.error));
    }
  }
}