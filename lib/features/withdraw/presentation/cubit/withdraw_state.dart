import 'package:equatable/equatable.dart';
import '../../../transfer/domain/entities/transfer_card.dart';

class WithdrawState extends Equatable {
  final List<TransferCard> cards;
  final TransferCard? selectedCard;
  final String phoneNumber;
  final int? selectedAmount;
  final String customAmount;
  final bool isOtherSelected;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const WithdrawState({
    this.cards = const [],
    this.selectedCard,
    this.phoneNumber = '',
    this.selectedAmount,
    this.customAmount = '',
    this.isOtherSelected = false,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  bool get isPhoneEnabled => selectedCard != null;
  bool get isAmountEnabled => phoneNumber.trim().isNotEmpty;

  bool get isFormValid {
    if (selectedCard == null) return false;
    if (phoneNumber.trim().isEmpty) return false;
    if (isOtherSelected) {
      return customAmount.trim().isNotEmpty;
    } else {
      return selectedAmount != null;
    }
  }

  WithdrawState copyWith({
    List<TransferCard>? cards,
    TransferCard? Function()? selectedCard,
    String? phoneNumber,
    int? Function()? selectedAmount,
    String? customAmount,
    bool? isOtherSelected,
    bool? isLoading,
    String? Function()? errorMessage,
    bool? isSuccess,
  }) {
    return WithdrawState(
      cards: cards ?? this.cards,
      selectedCard: selectedCard != null ? selectedCard() : this.selectedCard,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedAmount: selectedAmount != null ? selectedAmount() : this.selectedAmount,
      customAmount: customAmount ?? this.customAmount,
      isOtherSelected: isOtherSelected ?? this.isOtherSelected,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        cards,
        selectedCard,
        phoneNumber,
        selectedAmount,
        customAmount,
        isOtherSelected,
        isLoading,
        errorMessage,
        isSuccess,
      ];
}
