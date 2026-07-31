class SavingsAccountEntity {
  final int id;
  final int userId;
  final int bankAccountId;
  final String accountNumber;
  final String amount;
  final int termMonths;
  final String interestRate;
  final String startDate;
  final String endDate;
  final String status;

  const SavingsAccountEntity({
    required this.id,
    required this.userId,
    required this.bankAccountId,
    required this.accountNumber,
    required this.amount,
    required this.termMonths,
    required this.interestRate,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

}