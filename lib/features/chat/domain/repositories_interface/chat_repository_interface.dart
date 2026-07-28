import '../entities/chat_message_entity.dart';

abstract class ChatRepositoryInterface {
  Future< ChatMessageEntity>sendReply(String message,{int? notificationId});
}