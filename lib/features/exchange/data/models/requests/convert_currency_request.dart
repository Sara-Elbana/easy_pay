class ConvertCurrencyRequest {
  final String from;
  final String to;
  final double amount;

  const ConvertCurrencyRequest({
    required this.from,
    required this.to,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'from_currency': from,
      'to_currency': to,
      'amount': amount,
    };
  }
}
