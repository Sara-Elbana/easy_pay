import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/app_information/data/model/app_info_model.dart';
import 'package:easy_pay_app/core/network/api_service.dart';

class AppInfoRemoteDataSource {
  final ApiService apiService;

  AppInfoRemoteDataSource(this.apiService);

  Future<ApiResult<AppInfoModel>> getAppInfo() async {
    try {
      final response = await apiService.get(ApiConstants.appInfoEndpoint);
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final model = AppInfoModel.fromJson(response.data as Map<String, dynamic>);
      return ApiSuccess(data: model);
    } on DioException catch (e) {
      return ApiFailure(
        error: e.response?.data['message'] ??
            e.message ??
            ApiConstants.unknownError,
      );
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }
}