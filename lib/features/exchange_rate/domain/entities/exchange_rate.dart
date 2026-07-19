class ExchangeRate {
  final String id;
  final String country;
  final double buy;
  final double sell;
  final String flagAsset;

  const ExchangeRate({
    required this.id,
    required this.country,
    required this.buy,
    required this.sell,
    required this.flagAsset,
  });
}
