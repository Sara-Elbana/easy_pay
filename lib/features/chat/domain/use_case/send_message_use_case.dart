import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:easy_pay_app/features/chat/domain/repositories_interface/chat_repository_interface.dart';

class SendMessageUseCase {
  final ChatRepositoryInterface repository;

  SendMessageUseCase(this.repository);

  Future<ApiResult<ChatMessageEntity>> call(String message, {int? notificationId}) async {
    return await repository.sendReply(message, notificationId: notificationId);
  }
}