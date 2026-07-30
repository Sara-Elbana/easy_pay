import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/message/domain/entity/notification_entity.dart';
import 'package:easy_pay_app/features/message/domain/repository_interface/notification_repository_interface.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepositoryInterface repository;

  NotificationCubit(this.repository) : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    final result = await repository.getNotifications();
    if (result is ApiSuccess<List<NotificationEntity>>) {
      emit(NotificationSuccess(result.data));
    } else if (result is ApiFailure<List<NotificationEntity>>) {
      emit(NotificationError(result.error));
    }
  }
}