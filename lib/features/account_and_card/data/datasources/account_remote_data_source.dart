import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/account_model.dart';

class AccountRemoteDataSource {
  final Dio dio;

  AccountRemoteDataSource(): dio = getIt<Dio>();

  Future<List<AccountModel>> getAccounts() async {
    final response = await dio.get(ApiConstants.accountsEndpoint);
    return AccountModel.listFromJson(response.data);
  }
}
