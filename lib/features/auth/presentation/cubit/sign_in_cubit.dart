import 'package:easy_pay_app/features/auth/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<LoginState> {
  SignInCubit() : super(const LoginState());

  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    await Future.delayed(const Duration(seconds: 2));
    if (email == "sara@gmail.com" && password == "123456") {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else {
      emit(state.copyWith(isLoading: false, errorMessage: "Invalid email or password"));
    }
  }
}
