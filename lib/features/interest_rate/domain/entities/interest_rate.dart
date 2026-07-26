import 'package:equatable/equatable.dart';

class InterestRate extends Equatable {
  final String kind;
  final String deposit;
  final String rate;

  const InterestRate({
    required this.kind,
    required this.deposit,
    required this.rate,
  });

  @override
  List<Object?> get props => [kind, deposit, rate];
}