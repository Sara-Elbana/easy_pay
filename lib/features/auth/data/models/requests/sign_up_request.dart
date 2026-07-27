class SignUpRequest {
  final String name;
  final String phoneNumber;
  final String password;

  const SignUpRequest({
    required this.name,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phoneNumber,
      'password': password,
    };
  }
}
