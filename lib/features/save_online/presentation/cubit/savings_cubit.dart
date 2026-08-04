import 'dart:developer' as developer;
import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/features/save_online/data/models/requests/create_saving_request.dart';
import 'package:easy_pay_app/features/save_online/domain/entity/savings_account_entity.dart';
import 'package:easy_pay_app/features/save_online/domain/use_cases/create_saving_use_case.dart';
import 'package:easy_pay_app/features/save_online/domain/use_cases/get_savings_accounts_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementCubit extends Cubit<BaseState<List<SavingsAccountEntity>>> {
  final GetSavingsAccountsUseCase getSavingsAccountsUseCase;
  final CreateSavingUseCase createSavingUseCase;

  ManagementCubit({
    required this.getSavingsAccountsUseCase,
    required this.createSavingUseCase,
  }) : super(const BaseInitial());

  Future<void> fetchSavingsAccounts() async {
    emit(const BaseLoading());
    final result = await getSavingsAccountsUseCase();
    if (isClosed) return;

    if (result is ApiSuccess<List<SavingsAccountEntity>>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<List<SavingsAccountEntity>>) {
      emit(BaseError(result.error));
    }
  }

  Future<void> createSaving(CreateSavingRequest request) async {
    emit(const BaseLoading());

    final result = await createSavingUseCase(request);
    if (isClosed) return;

    if (result is ApiSuccess<SavingsAccountEntity>) {
      getIt<AccountCubit>().loadAccounts(forceRefresh: true);
      getIt<CardCubit>().loadCards(forceRefresh: true);
      emit(BaseSuccess([result.data]));
    } else if (result is ApiFailure<SavingsAccountEntity>) {
      developer.log('Server Error Details: ${result.error}');
      emit(BaseError(result.error));
    }
  }
}