class ChatMessageEntity {
  final int id;
  final int userId;
  final String senderName;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final String createdAt;

  const ChatMessageEntity({
    required this.id,
    required this.userId,
    required this.senderName,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });
}