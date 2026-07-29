import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/features/message/data/model/notifications_response_model.dart';

class NotificationRemoteDataSource {
  final ApiService apiService;

  NotificationRemoteDataSource(this.apiService);

  Future<NotificationsResponseModel> getNotifications() async {
    final response = await apiService.get(ApiConstants.notificationsEndpoint);
    return NotificationsResponseModel.fromJson(response.data);
  }
}