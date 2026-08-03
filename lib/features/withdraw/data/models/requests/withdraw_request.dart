class WithdrawRequest {
  final String cardId;
  final String phoneNumber;
  final double amount;

  const WithdrawRequest({
    required this.cardId,
    required this.phoneNumber,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_id': cardId,
      'phone_number': phoneNumber,
      'amount': amount,
    };
  }
}
