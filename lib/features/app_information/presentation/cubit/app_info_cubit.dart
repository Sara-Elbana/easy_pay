import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/app_information/domain/entities/app_info_entity.dart';
import 'package:easy_pay_app/features/app_information/domain/use_case/get_app_info_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInfoCubit extends Cubit<BaseState<AppInfoEntity>> {
  final GetAppInfoUseCase getAppInfoUseCase;

  AppInfoCubit(this.getAppInfoUseCase) : super(const BaseInitial());

  void fetchAppInfo() async {
    emit(const BaseLoading());
    final result = await getAppInfoUseCase();
    if (isClosed) return;
    if (result is ApiSuccess<AppInfoEntity>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<AppInfoEntity>) {
      emit(BaseError(result.error));
    }
  }
}
