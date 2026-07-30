import 'package:easy_pay_app/core/network/api_result.dart';
import '../entity/notification_entity.dart';

abstract class NotificationRepositoryInterface {
  Future<ApiResult<List<NotificationEntity>>> getNotifications();
}