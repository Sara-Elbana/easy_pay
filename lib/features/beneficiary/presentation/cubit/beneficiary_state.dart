import 'package:equatable/equatable.dart';
import '../../domain/entities/beneficiary.dart';
import 'package:easy_pay_app/features/transfer/data/models/mock_transfer_data.dart';

class BeneficiaryState extends Equatable {
  final List<Beneficiary> beneficiaries;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  // Form Fields
  final String name;
  final String cardNumber;
  final int selectedType; // 0: Card number, 1: Same bank, 2: Other bank
  final String selectedBank;
  final String selectedBranch;
  final String bankSearchQuery;
  final String branchSearchQuery;
  final String? avatarUrl;
  final String? editingBeneficiaryId;

  const BeneficiaryState({
    this.beneficiaries = const [],
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.name = '',
    this.cardNumber = '',
    this.selectedType = 0,
    this.selectedBank = '',
    this.selectedBranch = '',
    this.bankSearchQuery = '',
    this.branchSearchQuery = '',
    this.avatarUrl,
    this.editingBeneficiaryId,
  });

  bool get isFormValid {
    if (name.trim().isEmpty || cardNumber.trim().isEmpty) return false;
    if (selectedType == 2) {
      if (selectedBank.trim().isEmpty || selectedBranch.trim().isEmpty) return false;
    }
    return true;
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

  BeneficiaryState copyWith({
    List<Beneficiary>? beneficiaries,
    bool? isLoading,
    bool? isSuccess,
    String? Function()? errorMessage,
    String? name,
    String? cardNumber,
    int? selectedType,
    String? selectedBank,
    String? selectedBranch,
    String? bankSearchQuery,
    String? branchSearchQuery,
    String? Function()? avatarUrl,
    String? Function()? editingBeneficiaryId,
  }) {
    return BeneficiaryState(
      beneficiaries: beneficiaries ?? this.beneficiaries,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      selectedType: selectedType ?? this.selectedType,
      selectedBank: selectedBank ?? this.selectedBank,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      bankSearchQuery: bankSearchQuery ?? this.bankSearchQuery,
      branchSearchQuery: branchSearchQuery ?? this.branchSearchQuery,
      avatarUrl: avatarUrl != null ? avatarUrl() : this.avatarUrl,
      editingBeneficiaryId: editingBeneficiaryId != null ? editingBeneficiaryId() : this.editingBeneficiaryId,
    );
  }

  @override
  List<Object?> get props => [
        beneficiaries,
        isLoading,
        isSuccess,
        errorMessage,
        name,
        cardNumber,
        selectedType,
        selectedBank,
        selectedBranch,
        bankSearchQuery,
        branchSearchQuery,
        avatarUrl,
        editingBeneficiaryId,
      ];
}
