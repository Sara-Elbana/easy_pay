import 'package:easy_pay_app/core/core.dart';
import '../models/chat_reply_model.dart';

class ChatRemoteDataSource {
  final ApiService apiService;

  ChatRemoteDataSource(this.apiService);

  Future<ChatReplyModel> sendReply({
    required String message,
    int? notificationId,
  }) async {
    final response = await apiService.post(
      ApiConstants.chatEndpoint,
      data: {
        'message': message,
        if (notificationId != null) 'id': notificationId,
      },
    );
    return ChatReplyModel.fromJson(response.data);
  }
}