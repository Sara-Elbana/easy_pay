import 'package:easy_pay_app/core/network/api_result.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatRepositoryInterface {
  Future<ApiResult<ChatMessageEntity>> sendReply(String message, {int? notificationId});
}