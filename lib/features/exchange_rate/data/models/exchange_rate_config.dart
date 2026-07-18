import 'package:easy_pay_app/core/constants/app_assets.dart';

class CountryConfig {
  final String id;
  final String country;
  final String code;
  final String flagAsset;

  const CountryConfig({
    required this.id,
    required this.country,
    required this.code,
    required this.flagAsset,
  });
}

const List<CountryConfig> supportedCountries = [
  CountryConfig(id: '1', country: 'Vietnam', code: 'VND', flagAsset: AppAssets.flagVn),
  CountryConfig(id: '2', country: 'Nicaragua', code: 'NIO', flagAsset: AppAssets.flagNi),
  CountryConfig(id: '3', country: 'Korea', code: 'KRW', flagAsset: AppAssets.flagKr),
  CountryConfig(id: '4', country: 'Russia', code: 'RUB', flagAsset: AppAssets.flagRu),
  CountryConfig(id: '5', country: 'China', code: 'CNY', flagAsset: AppAssets.flagCn),
  CountryConfig(id: '6', country: 'Portugal', code: 'EUR', flagAsset: AppAssets.flagPt),
  CountryConfig(id: '7', country: 'France', code: 'EUR', flagAsset: AppAssets.flagFr),
  CountryConfig(id: '8', country: 'Austria', code: 'EUR', flagAsset: AppAssets.flagAt),
  CountryConfig(id: '9', country: 'Argentina', code: 'ARS', flagAsset: AppAssets.flagAr),
  CountryConfig(id: '10', country: 'Ukraine', code: 'UAH', flagAsset: AppAssets.flagUa),
  CountryConfig(id: '11', country: 'United Kingdom', code: 'GBP', flagAsset: AppAssets.flagGb),
  CountryConfig(id: '12', country: 'Japan', code: 'JPY', flagAsset: AppAssets.flagJp),
  CountryConfig(id: '13', country: 'India', code: 'INR', flagAsset: AppAssets.flagIn),
];
