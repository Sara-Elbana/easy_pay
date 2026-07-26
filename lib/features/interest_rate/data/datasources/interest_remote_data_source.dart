import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/features/interest_rate/data/models/interest_rate_model.dart';

abstract class InterestRemoteDataSource {
  Future<List<InterestRateModel>> getInterestRates();
}

class InterestRemoteDataSourceImpl implements InterestRemoteDataSource {
  final Dio dio;

  InterestRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<InterestRateModel>> getInterestRates() async {
    try {
      final response = await dio.get(ApiConstants.interestRatesEndpoint);
      if (response.data != null && response.data is List) {
        final List list = response.data as List;
        return list
            .map((json) => InterestRateModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw Exception(e.message ?? ApiConstants.unknownError);
    }
  }
}
