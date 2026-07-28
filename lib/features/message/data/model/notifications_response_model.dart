
import 'package:easy_pay_app/features/message/data/model/notification_model.dart';

class NotificationsResponseModel {
  final List<NotificationModel> notifications;

  NotificationsResponseModel({required this.notifications});

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    final list = json['notifications'] as List? ?? [];
    final notificationsList = list
        .map((item) => NotificationModel.fromJson(item))
        .toList();
    return NotificationsResponseModel(notifications: notificationsList);
  }
}