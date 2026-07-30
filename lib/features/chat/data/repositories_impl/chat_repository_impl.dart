import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/chat/data/data_source/chat_remote_data_source.dart';
import 'package:easy_pay_app/features/chat/data/models/chat_reply_model.dart';
import 'package:easy_pay_app/features/chat/domain/repositories_interface/chat_repository_interface.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatRepositoryImpl implements ChatRepositoryInterface {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<ChatMessageEntity>> sendReply(String message, {int? notificationId}) async {
    final result = await remoteDataSource.sendReply(
      message: message,
      notificationId: notificationId,
    );
    if (result is ApiSuccess<ChatReplyModel>) {
      return ApiSuccess(data: result.data, message: result.message);
    }
    final failure = result as ApiFailure<ChatReplyModel>;
    return ApiFailure(error: failure.error, message: failure.message);
  }
}