import '../../domain/entities/account_entity.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final List<AccountEntity> accounts;
  AccountSuccess(this.accounts);
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}