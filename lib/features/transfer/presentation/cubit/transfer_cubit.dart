import 'package:easy_pay_app/core/services/biometric_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../beneficiary/domain/entities/beneficiary.dart';
import '../../domain/entities/transfer_card.dart';
import '../../domain/usecases/execute_transfer_usecase.dart';
import '../../../beneficiary/domain/usecases/get_beneficiaries_usecase.dart';
import '../../domain/usecases/get_cards_usecase.dart';
import 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final GetCardsUseCase getCardsUseCase;
  final GetBeneficiariesUseCase getBeneficiariesUseCase;
  final ExecuteTransferUseCase executeTransferUseCase;
  final BiometricService biometricService;

  TransferCubit({
    required this.getCardsUseCase,
    required this.getBeneficiariesUseCase,
    required this.executeTransferUseCase,
    required this.biometricService,
  }) : super(const TransferState()) {
    loadTransferData();
  }

  Future<void> loadTransferData() async {
    emit(state.copyWith(isLoading: true, errorMessage: () => null));
    try {
      final cards = await getCardsUseCase();
      final beneficiaries = await getBeneficiariesUseCase();
      emit(state.copyWith(
        cards: cards,
        beneficiaries: beneficiaries,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => 'Failed to load transfer data',
      ));
    }
  }

  void selectCard(TransferCard? card) {
    emit(state.copyWith(
      selectedCard: () => card,
    ));
  }

  void selectTransactionType(int type) {
    emit(state.copyWith(
      selectedTransactionType: () => type,
      selectedBeneficiary: () => null,
      isManualBeneficiary: false,
      name: '',
      cardNumber: '',
      amount: '',
      content: '',
      selectedBank: '',
      selectedBranch: '',
      saveBeneficiary: false,
    ));
  }

  void selectBeneficiary(Beneficiary beneficiary) {
    emit(state.copyWith(
      selectedBeneficiary: () => beneficiary,
      isManualBeneficiary: false,
      name: beneficiary.name,
      cardNumber: beneficiary.cardNumber,
      amount: '',
      content: '',
      selectedBank: beneficiary.bank ?? '',
      selectedBranch: beneficiary.branch ?? '',
      saveBeneficiary: false,
    ));
  }

  void selectManualBeneficiary() {
    emit(state.copyWith(
      selectedBeneficiary: () => null,
      isManualBeneficiary: true,
      name: '',
      cardNumber: '',
      amount: '',
      content: '',
      selectedBank: '',
      selectedBranch: '',
      saveBeneficiary: false,
    ));
  }

  void clearBeneficiarySelection() {
    emit(state.copyWith(
      selectedBeneficiary: () => null,
      isManualBeneficiary: false,
      name: '',
      cardNumber: '',
      amount: '',
      content: '',
      selectedBank: '',
      selectedBranch: '',
      saveBeneficiary: false,
    ));
  }

  void selectBank(String bank) {
    emit(state.copyWith(selectedBank: bank, bankSearchQuery: ''));
  }

  void selectBranch(String branch) {
    emit(state.copyWith(selectedBranch: branch, branchSearchQuery: ''));
  }

  void updateBankSearch(String query) {
    emit(state.copyWith(bankSearchQuery: query));
  }

  void updateBranchSearch(String query) {
    emit(state.copyWith(branchSearchQuery: query));
  }

  void resetSearchQueries() {
    emit(state.copyWith(bankSearchQuery: '', branchSearchQuery: ''));
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateCardNumber(String cardNumber) {
    emit(state.copyWith(cardNumber: cardNumber));
  }

  void updateAmount(String amount) {
    emit(state.copyWith(amount: amount));
  }

  void updateContent(String content) {
    emit(state.copyWith(content: content));
  }

  void toggleSaveBeneficiary(bool value) {
    emit(state.copyWith(saveBeneficiary: value));
  }

  void toggleVerificationMode(bool isOtp) {
    emit(state.copyWith(otpMode: isOtp));
  }

  Future<void> requestOtpCode() async {
    emit(state.copyWith(otpRequested: true));
    await Future.delayed(
        const Duration(milliseconds: 600)); // Simulate sms delivery delay
    emit(state.copyWith(otpCode: ''));
  }

  void updateOtpCode(String code) {
    emit(state.copyWith(otpCode: code));
  }

  Future<void> verifyBiometric() async {
    emit(state.copyWith(isLoading: true, errorMessage: () => null));
    try {
      final success = await biometricService.authenticate();
      emit(state.copyWith(
        isBiometricVerified: success,
        isLoading: false,
        errorMessage: success ? null : () => 'Biometric authentication failed',
      ));
    } catch (e) {
      emit(state.copyWith(
        isBiometricVerified: false,
        isLoading: false,
        errorMessage: () => e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  Future<void> submitTransfer() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, errorMessage: () => null));
    try {
      final amt =
          double.tryParse(state.amount.replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0.0;
      final result = await executeTransferUseCase(
        fromCardId: state.selectedCard!.id,
        beneficiaryName: state.name,
        cardNumber: state.cardNumber,
        amount: amt,
        content: state.content,
        saveBeneficiary: state.saveBeneficiary,
        type: state.selectedTransactionType,
        bank: state.selectedBank.isNotEmpty ? state.selectedBank : null,
        branch: state.selectedBranch.isNotEmpty ? state.selectedBranch : null,
      );

      if (result) {
        final beneficiaries = await getBeneficiariesUseCase();
        emit(state.copyWith(
          beneficiaries: beneficiaries,
          isSuccess: true,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: () => 'Transfer failed. Please check details.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => 'An error occurred during transfer.',
      ));
    }
  }

  void reset() {
    emit(TransferState(
      cards: state.cards,
      beneficiaries: state.beneficiaries,
      selectedCard: state.selectedCard,
    ));
  }
}
