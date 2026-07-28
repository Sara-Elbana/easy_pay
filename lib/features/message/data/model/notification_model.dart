import '../../domain/entity/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.userId,
    required super.isRead,
    required super.senderName,
    required super.title,
    required super.message,
    required super.type,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      isRead: json['is_read'] ?? 0,
      senderName: json['sender_name'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}