import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';

class InterestRemoteDataSource {
  final Dio _dio = Dio();

  Future<List<InterestRate>> getInterestRates() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.interestRatesEndpoint}',
      );
      if (response.statusCode == 200 && response.data != null) {
        final List list = response.data;
        return list.map((json) {
          return InterestRate(
            kind: json['kind'] ?? '',
            deposit: json['term'] ?? '',
            rate: '${json['rate']}%',
          );
        }).toList();
      }
      throw Exception('Failed to load interest rates');
    } catch (e) {
      rethrow;
    }
  }
}