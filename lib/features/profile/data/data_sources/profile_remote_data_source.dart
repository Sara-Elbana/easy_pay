import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/profile/data/models/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSource(this.apiService);

  Future<ApiResult<ProfileModel>> getProfileData() async {
    try {
      final response = await apiService.get(ApiConstants.profileEndpoint);
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final model = ProfileModel.fromJson(response.data as Map<String, dynamic>);
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
