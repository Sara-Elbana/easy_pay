import 'package:easy_pay_app/features/bottomNav/message/domain/use_cases/get_accounts_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final GetAccountsUseCase getAccountsUseCase;
  AccountCubit({required this.getAccountsUseCase}) : super(AccountInitial());
  Future<void> loadAccounts() async {
    emit(AccountLoading());
    try {
      final accounts = await getAccountsUseCase();
      emit(AccountSuccess(accounts));
    } catch (e) {
      emit(const AccountError("Failed to fetch accounts"));
    }
  }
}
