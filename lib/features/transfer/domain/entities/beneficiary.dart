import 'package:equatable/equatable.dart';

class Beneficiary extends Equatable {
  final String id;
  final String name;
  final String cardNumber;
  final String? avatarUrl;

  const Beneficiary({
    required this.id,
    required this.name,
    required this.cardNumber,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, cardNumber, avatarUrl];
}
