import '../../domain/repositories/withdraw_repository.dart';

class WithdrawRepositoryImpl implements WithdrawRepository {
  @override
  Future<bool> executeWithdraw({
    required String cardId,
    required String phoneNumber,
    required double amount,
  }) async {
    // Simulate server API network call delay
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
