class SaveBeneficiaryRequest {
  final String id;
  final String name;
  final String cardNumber;
  final int type;
  final String? avatarUrl;
  final String? bank;
  final String? branch;

  const SaveBeneficiaryRequest({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.type,
    this.avatarUrl,
    this.bank,
    this.branch,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'card_number': cardNumber,
      'type': type,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (bank != null) 'bank': bank,
      if (branch != null) 'branch': branch,
    };
  }
}
