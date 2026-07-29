import 'package:easy_pay_app/features/message/domain/repository_interface/notification_repository_interface.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepositoryInterface repository;

  NotificationCubit(this.repository) : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    try {
      final notificationsList = await repository.getNotifications();
      emit(NotificationSuccess(notificationsList));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}