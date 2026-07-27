class SignInRequest {
  final String phoneNumber;
  final String password;

  const SignInRequest({
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phoneNumber,
      'password': password,
    };
  }
}
