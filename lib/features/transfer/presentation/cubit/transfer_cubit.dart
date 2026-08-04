import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/core/services/biometric_service.dart';
import 'package:easy_pay_app/features/transfer/data/models/requests/transfer_request.dart';
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
    final cardsResult = await getCardsUseCase();
    final beneficiariesResult = await getBeneficiariesUseCase();

    final cards = cardsResult is ApiSuccess<List<TransferCard>> ? cardsResult.data : <TransferCard>[];
    final beneficiaries = beneficiariesResult is ApiSuccess<List<Beneficiary>> ? beneficiariesResult.data : <Beneficiary>[];

    if (cardsResult is ApiSuccess || beneficiariesResult is ApiSuccess) {
      emit(state.copyWith(
        cards: cards,
        beneficiaries: beneficiaries,
        isLoading: false,
      ));
    } else {
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
        errorMessage: () => e.toString(),
      ));
    }
  }

  Future<void> submitTransfer() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, errorMessage: () => null));
    final amt =
        double.tryParse(state.amount.replaceAll(RegExp(r'[^0-9.]'), '')) ??
            0.0;
    final request = TransferRequest(
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
    final result = await executeTransferUseCase(request);

    if (result is ApiSuccess<bool>) {
      getIt<AccountCubit>().loadAccounts(forceRefresh: true);
      getIt<CardCubit>().loadCards(forceRefresh: true);
      final beneficiariesResult = await getBeneficiariesUseCase();
      final beneficiaries = beneficiariesResult is ApiSuccess<List<Beneficiary>> ? beneficiariesResult.data : state.beneficiaries;
      emit(state.copyWith(
        beneficiaries: beneficiaries,
        isSuccess: true,
        isLoading: false,
      ));
    } else if (result is ApiFailure<bool>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => result.error,
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
