import 'package:equatable/equatable.dart';

class Beneficiary extends Equatable {
  final String id;
  final String name;
  final String cardNumber;
  final String? avatarUrl;
  final int type; // 0: Card number, 1: Same bank, 2: Other bank
  final String? bank;
  final String? branch;

  const Beneficiary({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.type,
    this.avatarUrl,
    this.bank,
    this.branch,
  });

  @override
  List<Object?> get props => [id, name, cardNumber, avatarUrl, type, bank, branch];
}
