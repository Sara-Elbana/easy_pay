import 'package:easy_pay_app/features/app_information/domain/use_case/get_app_info_use_case.dart';
import 'package:easy_pay_app/features/app_information/presentation/cubit/app_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInfoCubit extends Cubit<AppInfoState> {
  final GetAppInfoUseCase getAppInfoUseCase;

  AppInfoCubit(this.getAppInfoUseCase) : super(AppInfoInitial());

  void fetchAppInfo() async {
    emit(AppInfoLoading());
    try {
      final info = await getAppInfoUseCase();
      emit(AppInfoSuccess(info));
    } catch (e) {
      emit(AppInfoError(e.toString()));
    }
  }
}
