class NotificationEntity {
  final int id;
  final int userId;
  final int isRead;
  final String senderName;
  final String title;
  final String message;
  final String type;
  final String createdAt;

  NotificationEntity({
    required this.id,
    required this.userId,
    required this.isRead,
    required this.senderName,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
  });
}