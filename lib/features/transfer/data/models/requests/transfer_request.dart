class TransferRequest {
  final String fromCardId;
  final String beneficiaryName;
  final String cardNumber;
  final double amount;
  final String content;
  final bool saveBeneficiary;
  final int? type;
  final String? bank;
  final String? branch;

  const TransferRequest({
    required this.fromCardId,
    required this.beneficiaryName,
    required this.cardNumber,
    required this.amount,
    required this.content,
    required this.saveBeneficiary,
    this.type,
    this.bank,
    this.branch,
  });

  Map<String, dynamic> toJson() {
    return {
      'from_card_id': fromCardId,
      'beneficiary_name': beneficiaryName,
      'card_number': cardNumber,
      'amount': amount,
      'content': content,
      'save_beneficiary': saveBeneficiary,
      if (type != null) 'type': type,
      if (bank != null) 'bank': bank,
      if (branch != null) 'branch': branch,
    };
  }
}
