import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String password;

  const UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, password];
}
