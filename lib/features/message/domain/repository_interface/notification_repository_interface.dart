import '../entity/notification_entity.dart';

abstract class NotificationRepositoryInterface {
  Future<List<NotificationEntity>> getNotifications();
}