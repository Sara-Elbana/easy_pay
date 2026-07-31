import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';
import 'package:easy_pay_app/features/save_online/domain/use_cases/create_saving_use_case.dart';
import 'package:easy_pay_app/features/save_online/domain/use_cases/get_savings_accounts_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementCubit extends Cubit<BaseState<List<SavingsAccountModel>>> {
  final GetSavingsAccountsUseCase getSavingsAccountsUseCase;
  final CreateSavingUseCase createSavingUseCase;

  ManagementCubit({
    required this.getSavingsAccountsUseCase,
    required this.createSavingUseCase,
  }) : super(const BaseInitial());


  Future<void> fetchSavingsAccounts() async {
    emit(const BaseLoading());
    final result = await getSavingsAccountsUseCase();

    if (result is ApiSuccess<List<SavingsAccountModel>>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<List<SavingsAccountModel>>) {
      emit(BaseError(result.error));
    }
  }



  Future<void> createSaving({
    required int bankAccountId,
    required double amount,
    required int termMonths,
  }) async {
    emit(const BaseLoading());

    final result = await createSavingUseCase(
      bankAccountId: bankAccountId,
      amount: amount,
      termMonths: termMonths,
    );

    if (result is ApiSuccess<SavingsAccountModel>) {
      emit(BaseSuccess([result.data]));
    } else if (result is ApiFailure<SavingsAccountModel>) {
      // في الـ Cubit لما يرجع ApiFailure، اطبعي الـ error أو الـ response اللي جاي من السيرفر:
      print('Server Error Details: ${result.error}');
      emit(BaseError(result.error));
    }
  }
}