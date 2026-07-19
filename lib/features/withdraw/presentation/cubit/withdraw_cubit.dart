import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/biometric_service.dart';
import '../../../transfer/data/models/mock_transfer_data.dart';
import '../../../transfer/domain/entities/transfer_card.dart';
import '../../domain/usecases/execute_withdraw_usecase.dart';
import 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  final ExecuteWithdrawUseCase executeWithdrawUseCase;

  WithdrawCubit({
    required this.executeWithdrawUseCase,
  }) : super(const WithdrawState()) {
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

    try {
      final success = await biometricService.authenticate();
      if (success) {
        final double amount = state.isOtherSelected
            ? (double.tryParse(state.customAmount.trim()) ?? 0.0)
            : (state.selectedAmount?.toDouble() ?? 0.0);

        final executeSuccess = await executeWithdrawUseCase(
          cardId: state.selectedCard!.id,
          phoneNumber: state.phoneNumber.trim(),
          amount: amount,
        );

        if (executeSuccess) {
          emit(state.copyWith(
            isSuccess: true,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: () => 'Withdrawal execution failed',
          ));
        }
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: () => 'Biometric authentication failed',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  void forceSuccess() {
    emit(state.copyWith(
      isSuccess: true,
      isLoading: false,
      errorMessage: () => null,
    ));
  }
}
