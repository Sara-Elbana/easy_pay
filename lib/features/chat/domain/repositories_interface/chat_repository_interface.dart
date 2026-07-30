import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/chat/data/models/requests/send_chat_reply_request.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatRepositoryInterface {
  Future<ApiResult<ChatMessageEntity>> sendReply(SendChatReplyRequest request);
}