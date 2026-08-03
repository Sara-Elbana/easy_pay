import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/message/domain/entity/notification_entity.dart';
import 'package:easy_pay_app/features/message/domain/repository_interface/notification_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<BaseState<List<NotificationEntity>>> {
  final NotificationRepositoryInterface repository;

  NotificationCubit(this.repository) : super(const BaseInitial());

  Future<void> fetchNotifications() async {
    emit(const BaseLoading());
    final result = await repository.getNotifications();
    if (isClosed) return;
    if (result is ApiSuccess<List<NotificationEntity>>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<List<NotificationEntity>>) {
      emit(BaseError(result.error));
    }
  }
}