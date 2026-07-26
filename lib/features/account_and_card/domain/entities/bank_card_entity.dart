class BankCardEntity {
  final int id;
  final String cardNumber;
  final String cardHolderName;
  final String cardType;
  final String expirationDate;
  final String cvv;

  BankCardEntity({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardType,
    required this.expirationDate,
    required this.cvv,
  });
}