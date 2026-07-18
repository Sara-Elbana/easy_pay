abstract class ExchangeRepository {
  Future<Map<String, dynamic>> convertCurrency({
    required String from,
    required String to,
    required double amount,
  });
}
