import 'package:equatable/equatable.dart';
import '../../domain/entities/beneficiary.dart';
import '../../domain/entities/transfer_card.dart';

class TransferState extends Equatable {
  final List<TransferCard> cards;
  final List<Beneficiary> beneficiaries;
  final TransferCard? selectedCard;
  final int? selectedTransactionType; // 0-4, null means none
  final Beneficiary? selectedBeneficiary;
  final bool isManualBeneficiary; // true if "+" custom input was selected
  final String name;
  final String cardNumber;
  final String amount;
  final String content;
  final bool saveBeneficiary;
  final bool otpMode; // true = OTP, false = Biometrics
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
    this.saveBeneficiary = false,
    this.otpMode = true,
    this.otpRequested = false,
    this.otpCode = '',
    this.isBiometricVerified = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  bool get isAmountExceeded {
    if (selectedCard == null || amount.trim().isEmpty) return false;
    final balanceClean = selectedCard!.balance.replaceAll(RegExp(r'[^0-9]'), '');
    final balanceVal = double.tryParse(balanceClean) ?? 0.0;
    
    final amountClean = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    final amountVal = double.tryParse(amountClean) ?? 0.0;
    
    return amountVal > balanceVal;
  }

  bool get isFormValid {
    if (selectedCard == null) return false;
    
    final balanceClean = selectedCard!.balance.replaceAll(RegExp(r'[^0-9]'), '');
    final balanceVal = double.tryParse(balanceClean) ?? 0.0;
    
    final amountClean = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    final amountVal = double.tryParse(amountClean) ?? 0.0;

    return selectedTransactionType != null &&
        (selectedBeneficiary != null || isManualBeneficiary) &&
        name.trim().isNotEmpty &&
        cardNumber.trim().isNotEmpty &&
        amount.trim().isNotEmpty &&
        amountVal > 0 &&
        amountVal <= balanceVal &&
        content.trim().isNotEmpty;
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
      selectedTransactionType: selectedTransactionType != null ? selectedTransactionType() : this.selectedTransactionType,
      selectedBeneficiary: selectedBeneficiary != null ? selectedBeneficiary() : this.selectedBeneficiary,
      isManualBeneficiary: isManualBeneficiary ?? this.isManualBeneficiary,
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      amount: amount ?? this.amount,
      content: content ?? this.content,
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
