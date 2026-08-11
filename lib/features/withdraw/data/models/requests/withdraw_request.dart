class WithdrawRequest {
  final String accountId;
  final String phoneNumber;
  final double amount;

  const WithdrawRequest({
    required this.accountId,
    required this.phoneNumber,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'account_id': int.tryParse(accountId) ?? accountId,
      'phone_number': phoneNumber,
      'amount': amount,
    };
  }
}

