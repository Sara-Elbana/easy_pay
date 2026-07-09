import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/services/shared_preferences_service.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final int totalPages;

  OnboardingCubit({required this.totalPages})
      : super(OnboardingState.initial());

  void setPage(int index) {
    emit(state.copyWith(
      pageIndex: index,
      isLastPage: index == totalPages - 1,
      isFinished: false,
    ));
  }

  void nextPage() {
    if (state.pageIndex < totalPages - 1) {
      setPage(state.pageIndex + 1);
    }
  }

  void previousPage() {
    if (state.pageIndex > 0) {
      setPage(state.pageIndex - 1);
    }
  }

  void skip() {
    setPage(totalPages - 1);
  }

  void finishOnboarding() {
    getIt<SharedPreferencesService>().saveOnboardingCompleted(true);
    emit(state.copyWith(isFinished: true));
  }
}
