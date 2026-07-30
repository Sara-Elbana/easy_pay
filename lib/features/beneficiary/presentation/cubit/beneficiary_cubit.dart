import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/beneficiary/data/models/requests/save_beneficiary_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/beneficiary.dart';
import '../../domain/usecases/get_beneficiaries_usecase.dart';
import '../../domain/usecases/save_beneficiary_usecase.dart';
import 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  final GetBeneficiariesUseCase getBeneficiariesUseCase;
  final SaveBeneficiaryUseCase saveBeneficiaryUseCase;

  BeneficiaryCubit({
    required this.getBeneficiariesUseCase,
    required this.saveBeneficiaryUseCase,
  }) : super(const BeneficiaryState()) {
    loadBeneficiaries();
  }

  Future<void> loadBeneficiaries() async {
    emit(state.copyWith(isLoading: true, errorMessage: () => null, isSuccess: false));
    final result = await getBeneficiariesUseCase();
    if (result is ApiSuccess<List<Beneficiary>>) {
      emit(state.copyWith(
        beneficiaries: result.data,
        isLoading: false,
      ));
    } else if (result is ApiFailure<List<Beneficiary>>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => result.error,
      ));
    }
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateCardNumber(String cardNumber) {
    emit(state.copyWith(cardNumber: cardNumber));
  }

  void selectType(int type) {
    emit(state.copyWith(
      selectedType: type,
      selectedBank: '',
      selectedBranch: '',
      bankSearchQuery: '',
      branchSearchQuery: '',
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

  void updateAvatarUrl(String? url) {
    emit(state.copyWith(avatarUrl: () => url));
  }

  void initEditBeneficiary(Beneficiary beneficiary) {
    emit(state.copyWith(
      editingBeneficiaryId: () => beneficiary.id,
      name: beneficiary.name,
      cardNumber: beneficiary.cardNumber,
      selectedType: beneficiary.type,
      selectedBank: beneficiary.bank ?? '',
      selectedBranch: beneficiary.branch ?? '',
      avatarUrl: () => beneficiary.avatarUrl,
      isSuccess: false,
      errorMessage: () => null,
    ));
  }

  void resetForm() {
    emit(state.copyWith(
      editingBeneficiaryId: () => null,
      name: '',
      cardNumber: '',
      selectedType: 0,
      selectedBank: '',
      selectedBranch: '',
      avatarUrl: () => null,
      isSuccess: false,
      errorMessage: () => null,
    ));
  }

  Future<void> saveBeneficiary() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, errorMessage: () => null));

    final id = state.editingBeneficiaryId ?? DateTime.now().millisecondsSinceEpoch.toString();
    final request = SaveBeneficiaryRequest(
      id: id,
      name: state.name,
      cardNumber: state.cardNumber,
      type: state.selectedType,
      avatarUrl: state.avatarUrl ?? 'https://i.pravatar.cc/150?img=${id.hashCode % 70 + 1}',
      bank: state.selectedType == 2 ? state.selectedBank : null,
      branch: state.selectedType == 2 ? state.selectedBranch : null,
    );

    final saveResult = await saveBeneficiaryUseCase(request);
    if (saveResult is ApiSuccess<bool>) {
      final listResult = await getBeneficiariesUseCase();
      final list = listResult is ApiSuccess<List<Beneficiary>> ? listResult.data : state.beneficiaries;
      emit(state.copyWith(
        beneficiaries: list,
        isSuccess: true,
        isLoading: false,
      ));
    } else if (saveResult is ApiFailure<bool>) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => saveResult.error,
      ));
    }
  }
}
