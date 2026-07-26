import 'package:easy_pay_app/features/profile/data/models/acccount_response_model.dart';
import 'package:easy_pay_app/features/profile/data/models/card_response_model.dart';
import 'package:easy_pay_app/features/profile/data/models/user_response_model.dart';

class ProfileModel {
  final UserResponseModel user;
  final AccountResponseModel account;
  final CardResponseModel card;

  ProfileModel({
    required this.user,
    required this.account,
    required this.card,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: UserResponseModel.fromJson(json['user']),
      account: AccountResponseModel.fromJson(json['account']),
      card: CardResponseModel.fromJson(json['card']),
    );
  }
}





