import 'package:easy_pay_app/features/auth/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<LoginState> {
  SignInCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2));
    if (email == "sara@gmail.com" && password == "123456") {
      emit(LoginSuccess());
    } else {
      emit(LoginError("Invalid email or password"));
    }
  }
}
