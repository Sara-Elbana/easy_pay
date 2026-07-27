import 'package:easy_pay_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
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

  Future<void> sendOtp(SendOtpRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      if (sendOtpUseCase != null) {
        await sendOtpUseCase!(request);
      }
      emit(state.copyWith(
        isLoading: false,
        isCodeSent: true,
        phoneNumber: request.phoneNumber,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      if (verifyOtpUseCase != null) {
        await verifyOtpUseCase!(request);
      }
      emit(state.copyWith(
        isLoading: false,
        isCodeVerified: true,
        verificationCode: request.code,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      if (resetPasswordUseCase != null) {
        await resetPasswordUseCase!(request);
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
