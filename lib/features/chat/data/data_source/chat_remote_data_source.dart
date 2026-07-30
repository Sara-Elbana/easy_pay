import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import '../models/chat_reply_model.dart';

class ChatRemoteDataSource {
  final ApiService apiService;

  ChatRemoteDataSource(this.apiService);

  Future<ApiResult<ChatReplyModel>> sendReply({
    required String message,
    int? notificationId,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.chatEndpoint,
        data: {
          'message': message,
          if (notificationId != null) 'id': notificationId,
        },
      );
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final model = ChatReplyModel.fromJson(response.data);
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