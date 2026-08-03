import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/account_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/get_accounts_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<BaseState<List<AccountEntity>>> {
  final GetAccountsUseCase getAccountsUseCase;

  AccountCubit({required this.getAccountsUseCase}) : super(const BaseInitial());

  Future<void> loadAccounts({bool forceRefresh = false}) async {
    if (!forceRefresh && state is BaseSuccess<List<AccountEntity>>) return;

    emit(const BaseLoading());

    final result = await getAccountsUseCase();
    if (isClosed) return;

    if (result is ApiSuccess<List<AccountEntity>>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<List<AccountEntity>>) {
      emit(BaseError(result.error));
    }
  }

  void clear() {
    emit(const BaseInitial());
  }
}