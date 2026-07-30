import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/message/data/model/notifications_response_model.dart';
import '../../domain/entity/notification_entity.dart';
import '../../domain/repository_interface/notification_repository_interface.dart';
import '../data_source/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepositoryInterface {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<List<NotificationEntity>>> getNotifications() async {
    final result = await remoteDataSource.getNotifications();

    if (result is ApiSuccess<NotificationsResponseModel>) {
      return ApiSuccess(data: result.data.notifications, message: result.message);
    }

    final failure = result as ApiFailure<NotificationsResponseModel>;
    return ApiFailure(error: failure.error, message: failure.message);
  }
}