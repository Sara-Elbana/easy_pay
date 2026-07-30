import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/app_information/domain/entities/app_info_entity.dart';
import 'package:easy_pay_app/features/app_information/domain/use_case/get_app_info_use_case.dart';
import 'package:easy_pay_app/features/app_information/presentation/cubit/app_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInfoCubit extends Cubit<AppInfoState> {
  final GetAppInfoUseCase getAppInfoUseCase;

  AppInfoCubit(this.getAppInfoUseCase) : super(AppInfoInitial());

  void fetchAppInfo() async {
    emit(AppInfoLoading());
    final result = await getAppInfoUseCase();
    if (result is ApiSuccess<AppInfoEntity>) {
      emit(AppInfoSuccess(result.data));
    } else if (result is ApiFailure<AppInfoEntity>) {
      emit(AppInfoError(result.error));
    }
  }
}
