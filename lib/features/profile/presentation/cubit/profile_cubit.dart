import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_pay_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit(this.getProfileUseCase) : super(ProfileInitial());

  void fetchProfile() async {
    emit(ProfileLoading());
    final result = await getProfileUseCase();
    if (result is ApiSuccess<ProfileEntity>) {
      emit(ProfileSuccess(result.data));
    } else if (result is ApiFailure<ProfileEntity>) {
      emit(ProfileError(result.error));
    }
  }
}