import 'package:easy_pay_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit(this.getProfileUseCase) : super(ProfileInitial());

  void fetchProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await getProfileUseCase();
      emit(ProfileSuccess(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}