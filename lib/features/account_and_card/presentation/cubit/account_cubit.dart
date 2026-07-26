import 'package:easy_pay_app/features/account_and_card/domain/use_cases/get_accounts_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  final GetAccountsUseCase getAccountsUseCase;

  AccountCubit({required this.getAccountsUseCase}) : super(AccountInitial());

  void loadAccounts() async {
    emit(AccountLoading());

    final result = await getAccountsUseCase();

    result.fold(
          (failure) => emit(AccountError(failure.message)),
          (accounts) => emit(AccountSuccess(accounts)),
    );
  }
}