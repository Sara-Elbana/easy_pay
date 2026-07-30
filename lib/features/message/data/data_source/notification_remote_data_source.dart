import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/message/data/model/notifications_response_model.dart';

class NotificationRemoteDataSource {
  final ApiService apiService;

  NotificationRemoteDataSource(this.apiService);

  Future<ApiResult<NotificationsResponseModel>> getNotifications() async {
    try {
      final response = await apiService.get(ApiConstants.notificationsEndpoint);
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final model = NotificationsResponseModel.fromJson(response.data as Map<String, dynamic>);
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