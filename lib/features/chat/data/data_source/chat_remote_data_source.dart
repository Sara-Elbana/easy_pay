import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/chat/data/models/requests/send_chat_reply_request.dart';
import '../models/chat_reply_model.dart';

class ChatRemoteDataSource {
  final ApiService apiService;

  ChatRemoteDataSource(this.apiService);

  Future<ApiResult<ChatReplyModel>> sendReply(SendChatReplyRequest request) async {
    try {
      final response = await apiService.post(
        ApiConstants.chatEndpoint,
        data: request.toJson(),
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