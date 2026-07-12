import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  void updatePhoneNumber(String value) {
    emit(state.copyWith(phoneNumber: value));
  }

  void updateVerificationCode(String value) {
    emit(state.copyWith(verificationCode: value));
  }

  void sendCode() {
    emit(state.copyWith(isCodeSent: true));
  }

  void changePhoneNumber() {
    emit(state.copyWith(
      isCodeSent: false,
      verificationCode: '',
    ));
  }
}
