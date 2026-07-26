import 'package:easy_pay_app/features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/send_otp_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/verify_otp_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final SendOtpUseCase? sendOtpUseCase;
  final VerifyOtpUseCase? verifyOtpUseCase;
  final ResetPasswordUseCase? resetPasswordUseCase;

  ForgotPasswordCubit({
    this.sendOtpUseCase,
    this.verifyOtpUseCase,
    this.resetPasswordUseCase,
  }) : super(const ForgotPasswordState());

  void updatePhoneNumber(String value) {
    emit(state.copyWith(phoneNumber: value, errorMessage: null));
  }

  void updateVerificationCode(String value) {
    emit(state.copyWith(verificationCode: value, errorMessage: null));
  }

  Future<void> sendOtp(String phoneNumber) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      if (sendOtpUseCase != null) {
        await sendOtpUseCase!(phoneNumber);
      }
      emit(state.copyWith(
        isLoading: false,
        isCodeSent: true,
        phoneNumber: phoneNumber,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  Future<void> verifyOtp(String phoneNumber, String code) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      if (verifyOtpUseCase != null) {
        await verifyOtpUseCase!(phoneNumber, code);
      }
      emit(state.copyWith(
        isLoading: false,
        isCodeVerified: true,
        verificationCode: code,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  Future<void> resetPassword(
      String phoneNumber, String code, String newPassword) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      if (resetPasswordUseCase != null) {
        await resetPasswordUseCase!(phoneNumber, code, newPassword);
      }
      emit(state.copyWith(
        isLoading: false,
        isPasswordReset: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  void changePhoneNumber() {
    emit(state.copyWith(
      isCodeSent: false,
      isCodeVerified: false,
      verificationCode: '',
      errorMessage: null,
    ));
  }
}
