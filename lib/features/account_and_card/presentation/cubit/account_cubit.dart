import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/get_accounts_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  final GetAccountsUseCase getAccountsUseCase;

  AccountCubit({required this.getAccountsUseCase}) : super(AccountInitial());

  void loadAccounts() async {
    emit(AccountLoading());

    final result = await getAccountsUseCase();

    if (result is ApiSuccess<List<AccountEntity>>) {
      emit(AccountSuccess(result.data));
    } else if (result is ApiFailure<List<AccountEntity>>) {
      emit(AccountError(result.error));
    }
  }
}