import 'package:easy_pay_app/features/chat/domain/entities/chat_message_entity.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatMessageSentSuccess extends ChatState {
  final ChatMessageEntity message;
  ChatMessageSentSuccess(this.message);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}