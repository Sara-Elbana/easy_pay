class ForgotPasswordState {
  final bool isCodeSent;
  final String phoneNumber;
  final String verificationCode;

  const ForgotPasswordState({
    this.isCodeSent = false,
    this.phoneNumber = '',
    this.verificationCode = '',
  });

  ForgotPasswordState copyWith({
    bool? isCodeSent,
    String? phoneNumber,
    String? verificationCode,
  }) {
    return ForgotPasswordState(
      isCodeSent: isCodeSent ?? this.isCodeSent,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }
}
