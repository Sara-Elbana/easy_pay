import 'package:easy_pay_app/core/network/api_result.dart';
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
    if (sendOtpUseCase != null) {
      final result = await sendOtpUseCase!(request);
      if (result is ApiSuccess<bool>) {
        emit(state.copyWith(
          isLoading: false,
          isCodeSent: true,
          phoneNumber: request.phoneNumber,
        ));
      } else if (result is ApiFailure<bool>) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.error,
        ));
      }
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    if (verifyOtpUseCase != null) {
      final result = await verifyOtpUseCase!(request);
      if (result is ApiSuccess<bool>) {
        emit(state.copyWith(
          isLoading: false,
          isCodeVerified: true,
          verificationCode: request.code,
        ));
      } else if (result is ApiFailure<bool>) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.error,
        ));
      }
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    if (resetPasswordUseCase != null) {
      final result = await resetPasswordUseCase!(request);
      if (result is ApiSuccess<bool>) {
        emit(state.copyWith(
          isLoading: false,
          isPasswordReset: true,
        ));
      } else if (result is ApiFailure<bool>) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.error,
        ));
      }
    } else {
      emit(state.copyWith(isLoading: false));
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
