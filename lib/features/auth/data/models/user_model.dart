import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    super.password,
    super.accessToken,
    super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle root or nested user payload
    final userData = json['user'] is Map<String, dynamic>
        ? json['user'] as Map<String, dynamic>
        : json['data'] is Map<String, dynamic>
            ? json['data'] as Map<String, dynamic>
            : json;

    final token = json['token'] ?? json['access_token'] ?? json['accessToken'] ?? userData['token'] ?? userData['access_token'] ?? userData['accessToken'];
    final refresh = json['refresh_token'] ?? json['refreshToken'] ?? userData['refresh_token'] ?? userData['refreshToken'];

    return UserModel(
      id: (userData['id'] ?? userData['user_id'] ?? json['user_id'] ?? '').toString(),
      name: (userData['name'] ?? userData['username'] ?? '').toString(),
      phoneNumber: (userData['phoneNumber'] ?? userData['phone_number'] ?? userData['phone'] ?? '').toString(),
      password: userData['password']?.toString(),
      accessToken: token?.toString(),
      refreshToken: refresh?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      if (password != null) 'password': password,
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
    };
  }
}
