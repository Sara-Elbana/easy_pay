import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final bool isCodeSent;
  final bool isCodeVerified;
  final bool isPasswordReset;
  final String? errorMessage;
  final String phoneNumber;
  final String verificationCode;

  const ForgotPasswordState({
    this.isLoading = false,
    this.isCodeSent = false,
    this.isCodeVerified = false,
    this.isPasswordReset = false,
    this.errorMessage,
    this.phoneNumber = '',
    this.verificationCode = '',
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isCodeSent,
    bool? isCodeVerified,
    bool? isPasswordReset,
    String? errorMessage,
    String? phoneNumber,
    String? verificationCode,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isCodeSent: isCodeSent ?? this.isCodeSent,
      isCodeVerified: isCodeVerified ?? this.isCodeVerified,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      errorMessage: errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isCodeSent,
        isCodeVerified,
        isPasswordReset,
        errorMessage,
        phoneNumber,
        verificationCode,
      ];
}
