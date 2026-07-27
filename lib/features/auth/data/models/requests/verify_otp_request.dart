class VerifyOtpRequest {
  final String phoneNumber;
  final String code;

  const VerifyOtpRequest({
    required this.phoneNumber,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phoneNumber,
      'code': code,
    };
  }
}
