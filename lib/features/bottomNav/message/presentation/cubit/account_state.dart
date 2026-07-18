import 'package:easy_pay_app/features/bottomNav/message/domain/entities/account_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object?> get props => [];
}
class AccountInitial extends AccountState {}
class AccountLoading extends AccountState {}
class AccountSuccess extends AccountState {
  final List<AccountEntity> accounts;
  const AccountSuccess(this.accounts);
  @override
  List<Object?> get props => [accounts];
}
class AccountError extends AccountState {
  final String message;
  const AccountError(this.message);
  @override
  List<Object?> get props => [message];
}
