class AddCardRequest {
  final String cardHolderName;
  final String cardNumber;
  final String expirationDate;
  final String cardType;

  const AddCardRequest({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expirationDate,
    required this.cardType,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_holder_name': cardHolderName,
      'card_number': cardNumber,
      'expiration_date': expirationDate,
      'card_type': cardType,
    };
  }
}
