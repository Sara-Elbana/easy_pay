import '../../domain/entity/notification_entity.dart';
import '../../domain/repository_interface/notification_repository_interface.dart';
import '../data_source/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepositoryInterface {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final responseModel = await remoteDataSource.getNotifications();
    return responseModel.notifications;
  }
}