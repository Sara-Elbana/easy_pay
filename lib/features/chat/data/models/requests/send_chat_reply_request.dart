class SendChatReplyRequest {
  final String message;
  final int? notificationId;

  const SendChatReplyRequest({
    required this.message,
    this.notificationId,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (notificationId != null) 'id': notificationId,
    };
  }
}
