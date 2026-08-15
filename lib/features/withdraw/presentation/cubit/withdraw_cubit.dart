import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/services/crashlytics_service.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/features/withdraw/data/models/requests/withdraw_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/biometric_service.dart';
import '../../../transfer/data/models/mock_transfer_data.dart';
import '../../../transfer/domain/entities/transfer_card.dart';
import '../../domain/usecases/execute_withdraw_usecase.dart';
import 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  final ExecuteWithdrawUseCase executeWithdrawUseCase;
  final CrashlyticsService _crashlytics;

  WithdrawCubit({
    required this.executeWithdrawUseCase,
    CrashlyticsService? crashlytics,
  })  : _crashlytics = crashlytics ?? getIt<CrashlyticsService>(),
        super(const WithdrawState()) {
    loadCards();
  }

  void loadCards() {
    emit(state.copyWith(cards: mockCards));
  }

  void selectCard(TransferCard? card) {
    if (card == null) {
      emit(state.copyWith(
        selectedCard: () => null,
        phoneNumber: '',
        selectedAmount: () => null,
        customAmount: '',
        isOtherSelected: false,
        errorMessage: () => null,
      ));
    } else {
      emit(state.copyWith(
        selectedCard: () => card,
        errorMessage: () => null,
      ));
    }
  }

  void updatePhone(String phone) {
    if (phone.trim().isEmpty) {
      emit(state.copyWith(
        phoneNumber: '',
        selectedAmount: () => null,
        customAmount: '',
        isOtherSelected: false,
        errorMessage: () => null,
      ));
    } else {
      emit(state.copyWith(
        phoneNumber: phone,
        errorMessage: () => null,
      ));
    }
  }

  void selectAmount(int? amount) {
    emit(state.copyWith(
      selectedAmount: () => amount,
      isOtherSelected: false,
      customAmount: '',
      errorMessage: () => null,
    ));
  }

  void selectOther() {
    emit(state.copyWith(
      isOtherSelected: true,
      selectedAmount: () => null,
      errorMessage: () => null,
    ));
  }

  void updateCustomAmount(String amount) {
    emit(state.copyWith(
      customAmount: amount,
      errorMessage: () => null,
    ));
  }

  void clearError() {
    emit(state.copyWith(errorMessage: () => null));
  }

  Future<void> performWithdraw(BiometricService biometricService) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, errorMessage: () => null));

    await _crashlytics.log('Withdraw request started');
    await _crashlytics.log('Withdraw validation passed');

    try {
      await _crashlytics.log('Biometric authentication started');
      final success = await biometricService.authenticate();
      if (success) {
        final double amount = state.isOtherSelected
            ? (double.tryParse(state.customAmount.trim()) ?? 0.0)
            : (state.selectedAmount?.toDouble() ?? 0.0);

        final request = WithdrawRequest(
          accountId: state.selectedCard!.id,
          phoneNumber: state.phoneNumber.trim(),
          amount: amount,
        );

        await _crashlytics.log('Withdraw API request started');
        final executeResult = await executeWithdrawUseCase(request);

        if (executeResult is ApiSuccess<bool>) {
          await _crashlytics.log('Withdraw request succeeded');
          getIt<AccountCubit>().loadAccounts(forceRefresh: true);
          getIt<CardCubit>().loadCards(forceRefresh: true);
          emit(state.copyWith(
            isSuccess: true,
            isLoading: false,
          ));
        } else if (executeResult is ApiFailure<bool>) {
          await _crashlytics.log('Withdraw business failure');
          emit(state.copyWith(
            isLoading: false,
            errorMessage: () => executeResult.error,
          ));
        }
      } else {
        await _crashlytics.log('Withdraw biometric cancelled/failed');
        emit(state.copyWith(
          isLoading: false,
          errorMessage: () => 'Biometric authentication failed',
        ));
      }
    } catch (e, stackTrace) {
      await _crashlytics.recordError(
        e,
        stackTrace,
        reason: 'Unexpected Withdraw runtime error',
        fatal: false,
      );
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => e.toString(),
      ));
    }
  }

  void forceSuccess() {
    _crashlytics.log('Withdraw completed via fallback');
    emit(state.copyWith(
      isSuccess: true,
      isLoading: false,
      errorMessage: () => null,
    ));
  }
}
