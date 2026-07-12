import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String username;
  final String password;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [id, name, username, password];
}
