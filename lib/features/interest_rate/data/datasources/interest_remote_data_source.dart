import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/interest_rate/data/models/interest_rate_model.dart';

abstract class InterestRemoteDataSource {
  Future<ApiResult<List<InterestRateModel>>> getInterestRates();
}

class InterestRemoteDataSourceImpl implements InterestRemoteDataSource {
  final ApiService apiService;

  InterestRemoteDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<ApiResult<List<InterestRateModel>>> getInterestRates() async {
    try {
      final response = await apiService.get(
        ApiConstants.interestRatesEndpoint,
      );

      if (response.data == null || response.data is! List) {
        return const ApiFailure(
          error: 'Invalid response format',
        );
      }

      final models = (response.data as List)
          .map(
            (json) => InterestRateModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();

      return ApiSuccess(
        data: models,
      );
    } on DioException catch (e) {
      return ApiFailure(
        error: e.response?.data['message'] ??
            e.message ??
            ApiConstants.unknownError,
      );
    } catch (_) {
      return const ApiFailure(
        error: ApiConstants.unknownError,
      );
    }
  }
}
