import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String? password;
  final String? accessToken;
  final String? refreshToken;

  const UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.password,
    this.accessToken,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, password, accessToken, refreshToken];
}
