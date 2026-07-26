class BankCardModel {
  final int id;
  final int bankAccountId;
  final String cardNumber;
  final String cardHolderName;
  final String cardType;
  final String expirationDate;
  final String cvv;
  final int isActive;

  BankCardModel({
    required this.id,
    required this.bankAccountId,
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardType,
    required this.expirationDate,
    required this.cvv,
    required this.isActive,
  });

  factory BankCardModel.fromJson(Map<String, dynamic> json) {
    return BankCardModel(
      id: json['id'],
      bankAccountId: json['bank_account_id'],
      cardNumber: json['card_number'] ,
      cardHolderName: json['card_holder_name'],
      cardType: json['card_type'],
      expirationDate: json['expiration_date'],
      cvv: json['cvv'],
      isActive: json['is_active'] ,
    );
  }
}