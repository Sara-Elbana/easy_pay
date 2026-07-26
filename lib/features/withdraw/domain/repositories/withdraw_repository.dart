abstract class WithdrawRepository {
  Future<bool> executeWithdraw({
    required String cardId,
    required String phoneNumber,
    required double amount,
  });
}
