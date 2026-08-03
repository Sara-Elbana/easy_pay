class DeleteCardRequest {
  final int cardId;

  const DeleteCardRequest({
    required this.cardId,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_id': cardId,
    };
  }
}
