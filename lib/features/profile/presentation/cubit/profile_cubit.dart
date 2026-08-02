import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_pay_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<BaseState<ProfileEntity>> {
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit(this.getProfileUseCase) : super(const BaseInitial());

  void fetchProfile({bool forceRefresh = false}) async {
    if (!forceRefresh && state is BaseSuccess<ProfileEntity>) return;

    emit(const BaseLoading());
    final result = await getProfileUseCase();
    if (isClosed) return;
    if (result is ApiSuccess<ProfileEntity>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<ProfileEntity>) {
      emit(BaseError(result.error));
    }
  }

  void clear() {
    emit(const BaseInitial());
  }
}