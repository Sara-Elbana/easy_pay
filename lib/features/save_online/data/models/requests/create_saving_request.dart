class CreateSavingRequest {
  final int bankAccountId;
  final double amount;
  final int termMonths;

  const CreateSavingRequest({
    required this.bankAccountId,
    required this.amount,
    required this.termMonths,
  });

  Map<String, dynamic> toJson() {
    return {
      "bank_account_id": bankAccountId,
      "amount": amount,
      "term_months": termMonths,
    };
  }
}
