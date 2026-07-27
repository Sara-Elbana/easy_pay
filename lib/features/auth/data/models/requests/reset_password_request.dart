class ResetPasswordRequest {
  final String phoneNumber;
  final String code;
  final String newPassword;

  const ResetPasswordRequest({
    required this.phoneNumber,
    required this.code,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phoneNumber,
      'code': code,
      'newPassword': newPassword,
    };
  }
}
