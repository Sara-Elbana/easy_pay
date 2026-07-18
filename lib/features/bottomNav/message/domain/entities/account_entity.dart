import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String title;
  final String accountNumber;
  final double availableBalance;
  final String branch;
  const AccountEntity({
    required this.title,
    required this.accountNumber,
    required this.availableBalance,
    required this.branch,
  });
  @override
  List<Object?> get props => [title, accountNumber, availableBalance, branch];
}