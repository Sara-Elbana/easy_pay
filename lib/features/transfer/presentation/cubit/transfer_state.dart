import 'package:equatable/equatable.dart';
import '../../../beneficiary/domain/entities/beneficiary.dart';
import '../../domain/entities/transfer_card.dart';
import 'package:easy_pay_app/features/transfer/data/models/mock_transfer_data.dart';

class TransferState extends Equatable {
  final List<TransferCard> cards;
  final List<Beneficiary> beneficiaries;
  final TransferCard? selectedCard;
  final int? selectedTransactionType;
  final Beneficiary? selectedBeneficiary;
  final bool isManualBeneficiary;
  final String name;
  final String cardNumber;
  final String amount;
  final String content;
  final String selectedBank;
  final String selectedBranch;
  final String bankSearchQuery;
  final String branchSearchQuery;
  final bool saveBeneficiary;
  final bool otpMode;
  final bool otpRequested;
  final String otpCode;
  final bool isBiometricVerified;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const TransferState({
    this.cards = const [],
    this.beneficiaries = const [],
    this.selectedCard,
    this.selectedTransactionType,
    this.selectedBeneficiary,
    this.isManualBeneficiary = false,
    this.name = '',
    this.cardNumber = '',
    this.amount = '',
    this.content = '',
    this.selectedBank = '',
    this.selectedBranch = '',
    this.bankSearchQuery = '',
    this.branchSearchQuery = '',
    this.saveBeneficiary = false,
    this.otpMode = true,
    this.otpRequested = false,
    this.otpCode = '',
    this.isBiometricVerified = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  double get fee {
    if (amount.trim().isEmpty) return 0.0;
    final amountClean = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    final amountVal = double.tryParse(amountClean) ?? 0.0;
    if (amountVal <= 0) return 0.0;
    double feeVal = amountVal * 0.001;
    if (feeVal < 0.5) {
      feeVal = 0.5;
    }
    return feeVal;
  }

  bool get isAmountExceeded {
    if (selectedCard == null || amount.trim().isEmpty) return false;
    final balanceClean =
        selectedCard!.balance.replaceAll(RegExp(r'[^0-9]'), '');
    final balanceVal = double.tryParse(balanceClean) ?? 0.0;

    final amountClean = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    final amountVal = double.tryParse(amountClean) ?? 0.0;

    return (amountVal + fee) > balanceVal;
  }

  bool get isFormValid {
    if (selectedCard == null) return false;

    final balanceClean =
        selectedCard!.balance.replaceAll(RegExp(r'[^0-9]'), '');
    final balanceVal = double.tryParse(balanceClean) ?? 0.0;

    final amountClean = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    final amountVal = double.tryParse(amountClean) ?? 0.0;

    final isAnotherBank = selectedTransactionType == 2;
    final isBankBranchValid = !isAnotherBank ||
        (selectedBank.trim().isNotEmpty && selectedBranch.trim().isNotEmpty);

    return selectedTransactionType != null &&
        (selectedBeneficiary != null || isManualBeneficiary) &&
        isBankBranchValid &&
        name.trim().isNotEmpty &&
        cardNumber.trim().isNotEmpty &&
        amount.trim().isNotEmpty &&
        amountVal > 0 &&
        (amountVal + fee) <= balanceVal &&
        content.trim().isNotEmpty;
  }

  List<Beneficiary> get filteredBeneficiaries {
    if (selectedTransactionType == null) return const [];
    return beneficiaries
        .where((b) => b.type == selectedTransactionType)
        .toList();
  }

  List<String> get filteredBanks {
    if (bankSearchQuery.trim().isEmpty) return mockBanks;
    return mockBanks
        .where((bank) => bank.toLowerCase().contains(bankSearchQuery.toLowerCase()))
        .toList();
  }

  List<String> get filteredBranches {
    if (branchSearchQuery.trim().isEmpty) return mockBranches;
    return mockBranches
        .where((branch) => branch.toLowerCase().contains(branchSearchQuery.toLowerCase()))
        .toList();
  }

  TransferState copyWith({
    List<TransferCard>? cards,
    List<Beneficiary>? beneficiaries,
    TransferCard? Function()? selectedCard,
    int? Function()? selectedTransactionType,
    Beneficiary? Function()? selectedBeneficiary,
    bool? isManualBeneficiary,
    String? name,
    String? cardNumber,
    String? amount,
    String? content,
    String? selectedBank,
    String? selectedBranch,
    String? bankSearchQuery,
    String? branchSearchQuery,
    bool? saveBeneficiary,
    bool? otpMode,
    bool? otpRequested,
    String? otpCode,
    bool? isBiometricVerified,
    bool? isLoading,
    bool? isSuccess,
    String? Function()? errorMessage,
  }) {
    return TransferState(
      cards: cards ?? this.cards,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      selectedCard: selectedCard != null ? selectedCard() : this.selectedCard,
      selectedTransactionType: selectedTransactionType != null
          ? selectedTransactionType()
          : this.selectedTransactionType,
      selectedBeneficiary: selectedBeneficiary != null
          ? selectedBeneficiary()
          : this.selectedBeneficiary,
      isManualBeneficiary: isManualBeneficiary ?? this.isManualBeneficiary,
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      amount: amount ?? this.amount,
      content: content ?? this.content,
      selectedBank: selectedBank ?? this.selectedBank,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      bankSearchQuery: bankSearchQuery ?? this.bankSearchQuery,
      branchSearchQuery: branchSearchQuery ?? this.branchSearchQuery,
      saveBeneficiary: saveBeneficiary ?? this.saveBeneficiary,
      otpMode: otpMode ?? this.otpMode,
      otpRequested: otpRequested ?? this.otpRequested,
      otpCode: otpCode ?? this.otpCode,
      isBiometricVerified: isBiometricVerified ?? this.isBiometricVerified,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        cards,
        beneficiaries,
        selectedCard,
        selectedTransactionType,
        selectedBeneficiary,
        isManualBeneficiary,
        name,
        cardNumber,
        amount,
        content,
        selectedBank,
        selectedBranch,
        bankSearchQuery,
        branchSearchQuery,
        saveBeneficiary,
        otpMode,
        otpRequested,
        otpCode,
        isBiometricVerified,
        isLoading,
        isSuccess,
        errorMessage,
      ];
}
