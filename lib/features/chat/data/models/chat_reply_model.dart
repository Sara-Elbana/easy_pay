import '../../domain/entities/chat_message_entity.dart';

class ChatReplyModel extends ChatMessageEntity {
  const ChatReplyModel({
    required super.id,
    required super.userId,
    required super.senderName,
    required super.title,
    required super.message,
    required super.type,
    required super.isRead,
    required super.createdAt,
  });

  factory ChatReplyModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return ChatReplyModel(
      id: data['id'] ?? 0,
      userId: data['user_id'] ?? 0,
      senderName: data['sender_name'] ?? '',
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      type: data['type'] ?? '',
      isRead: data['is_read'] ?? false,
      createdAt: data['created_at'] ?? '',
    );
  }
}