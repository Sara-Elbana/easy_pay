class CardResponseModel {
  final String cardNumber;
  final String cardHolderName;
  final String cardType;
  final String expirationDate;

  CardResponseModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardType,
    required this.expirationDate,
  });

  factory CardResponseModel.fromJson(Map<String, dynamic> json) {
    return CardResponseModel(
      cardNumber: json['card_number'],
      cardHolderName: json['card_holder_name'],
      cardType: json['card_type'],
      expirationDate: json['expiration_date'],
    );
  }
}