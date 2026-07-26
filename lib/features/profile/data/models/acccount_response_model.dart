class AccountResponseModel {
  final String accountNumber;
  final String balance;

  AccountResponseModel({required this.accountNumber, required this.balance});

  factory AccountResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountResponseModel(
      accountNumber: json['account_number'],
      balance: json['balance'],
    );
  }
}