import 'package:equatable/equatable.dart';

class TransferCard extends Equatable {
  final String id;
  final String cardNumber;
  final String balance;

  const TransferCard({
    required this.id,
    required this.cardNumber,
    required this.balance,
  });

  @override
  List<Object?> get props => [id, cardNumber, balance];
}
